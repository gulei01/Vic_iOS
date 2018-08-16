//
//  RandomBuy.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/5.
//
//

#import "RandomBuy.h"
#import "RandomBuyCell.h"
#import "RandomBuyHeader.h"
#import "RandomSection.h"
#import "HelpBuy.h"
#import "HelpSale.h"
#import "HelpTake.h"
#import "RandomOrder.h"
#import "RandomMap.h"
#import "RandomShowOrder.h"

@interface RandomBuy ()<RandomBuyDelegate,UITextFieldDelegate>

@property(nonatomic,strong) NSArray* arrayBanner;
/**
 *  服务分类（帮你买、帮你送，帮你取，等）
 */
@property(nonatomic,strong) NSArray* arrayType;
/**
 *  服务分类 类型
 */
@property(nonatomic,strong) NSDictionary* dictTypeCatae;
@property(nonatomic,strong) NSArray* arrayOrder;

@property(nonatomic,strong) NSString* deliveryCount;

@property(nonatomic,strong) UITextField* emptyTxt;


@end

@implementation RandomBuy{
    CGFloat headerBannerHeight;
}

static NSString * const cellIdentifier = @"RandomBuyCell";
static NSString * const cell2Identifier =  @"RandomBuy2Cell";
static NSString * const headerIdentifier = @"RandomBuyHeader";
static NSString * const sectionIdentifier = @"RandomBuySection";

//万能跑腿
-(instancetype)init{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    self = [super initWithCollectionViewLayout:layout];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    headerBannerHeight = 0.f;
  
    [self.collectionView registerClass:[RandomBuyCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[RandomBuy2Cell class] forCellWithReuseIdentifier:cell2Identifier];
    [self.collectionView registerClass:[RandomBuyHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.collectionView registerClass:[RandomSection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionIdentifier];
//    请求数据有问题
    [self queryData];
    [self queryNearDelivery];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary* conf = [userDef dictionaryForKey:kRandomBuyConfig];
    NSString* empty = [conf objectForKey: @"title"];
     self.navigationItem.title = [WMHelper isEmptyOrNULLOrnil:empty]? @"随意购":empty;
    UIImage* img = [UIImage imageNamed: @"icon-random-buy-order"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(orderTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  query data source
-(void)queryData{
    
    NetRepositories* respositorise = [[NetRepositories alloc]init];
    NSDictionary* arg = @{ @"ince": @"get_index_info", @"lat":self.Identity.location.mapLat, @"lng":self.Identity.location.mapLng};
    [respositorise queryRandom:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            self.arrayBanner = @[[response objectForKey: @"banner"]];
            self.arrayType = [response objectForKey: @"type"];
            NSLog(@"~~~~~~~~~~~~~~~%@,geshu%d~~~~~~~~~~~~~~~~~~",response,(int)self.arrayBanner.count);
            self.dictTypeCatae = [response objectForKey: @"cate"];
            self.arrayOrder = [response objectForKey: @"buy_orders"];
            NSUserDefaults* userDef = [NSUserDefaults standardUserDefaults];
            [userDef setObject:[response objectForKey: @"conf"] forKey:kRandomBuyConfig];
            [userDef setObject:[response objectForKey: @"ship_rules"] forKey:kRandomBuyFeeConfig];
            NSLog(@"%@",[userDef objectForKey:kRandomBuyConfig]);
            [userDef synchronize];
        }else{
            [self alertHUD:message];
        }
        [self.collectionView reloadData];
    }];
}

//这一步可能出现错误，第一次有可能好，但是第二次运行 boom
-(void)queryNearDelivery{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    
    [repositories randomNetConfirm:@{ @"ince": @"get_emp_num", @"lat":self.Identity.location.mapLat, @"lng":self.Identity.location.mapLng} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
//        NSLog(@"!!!!!!!!!!!%@!!!!!!!!!!!!!!!!!!",self.Identity.location.mapLat);
        if(react == 1){
            self.deliveryCount = [response objectForKey: @"data"];
            [self.collectionView reloadData];
        }else{
            
        }
    }];
}

#pragma mark =====================================================  <UICollectionViewDataSoruce>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.arrayType.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    NSDictionary* empty = self.arrayType[section];
    NSArray* items = [self.dictTypeCatae objectForKey: [empty objectForKey: @"key"]];
    return items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        RandomBuyCell* cell = (RandomBuyCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        NSDictionary* empty = self.arrayType[indexPath.section];
        NSArray* items = [self.dictTypeCatae objectForKey: [empty objectForKey: @"key"]];
        NSDictionary* item = [items objectAtIndex:indexPath.row];
        cell.item = item;
        return cell;
    }else{
        RandomBuy2Cell* cell = (RandomBuy2Cell*)[collectionView dequeueReusableCellWithReuseIdentifier:cell2Identifier forIndexPath:indexPath];
        NSDictionary* empty = self.arrayType[indexPath.section];
        NSArray* items = [self.dictTypeCatae objectForKey: [empty objectForKey: @"key"]];
        NSDictionary* item = [items objectAtIndex:indexPath.row];
        cell.item = item;
        return cell;
    }
    return nil;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(indexPath.section == 0){
            RandomBuyHeader* header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
//            这里有问题
            [header loadDataWithType:self.arrayType banners:self.arrayBanner orders:self.arrayOrder section:@{ @"prompt": @"帮你买,什么都能买"} complete:^(CGFloat bannerHeight) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    headerBannerHeight = bannerHeight;
                    [self.collectionView reloadData];
                });
            }];
            [header loadDataDelivery:self.deliveryCount];
            header.delegate = self;
            self.emptyTxt = header.txtSearch;
            self.emptyTxt.returnKeyType=UIReturnKeyDone;
            self.emptyTxt.delegate = self;
            return header;
        }else{
            RandomSection* header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionIdentifier forIndexPath:indexPath];
            NSDictionary* empty = self.arrayType[indexPath.section];
            if([ @"send" isEqualToString: [empty objectForKey: @"key"]]){
                header.item = @{ @"prompt": @"帮你送,安全准时到达", @"business_type": @"2"};
            }else if ([ @"get" isEqualToString: [empty objectForKey: @"key"]]){
                header.item = @{ @"prompt": @"帮你取,安全准时到达" , @"business_type": @"3"};
            }
            return header;
        }
    }
    return nil;
}

#pragma mark =====================================================  <UICollectionViewFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return CGSizeMake((SCREEN_WIDTH-1)/2, 80.f);
    }else{
        return CGSizeMake((SCREEN_WIDTH-1.5)/3, 120.f);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  0.5f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.5f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        CGFloat topHeight = 190;
        CGFloat bottomHeight = 30.f;
        if(self.arrayOrder.count>0){
            bottomHeight = bottomHeight +40;
        }
        bottomHeight = bottomHeight + headerBannerHeight;
        
        return CGSizeMake(SCREEN_WIDTH, topHeight+bottomHeight);
    }else{
        return CGSizeMake(SCREEN_WIDTH, 30.f);
    }
}
#pragma mark =====================================================  <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* empty = self.arrayType[indexPath.section];
    NSArray* items =[self.dictTypeCatae objectForKey: [empty objectForKey: @"key"]];
    NSDictionary* item = [items objectAtIndex:indexPath.row];
    NSArray* emptyArray = [item objectForKey: @"childtag"];
    if(indexPath.section == 0){
        HelpBuy* controller = [[HelpBuy alloc]initWithTags:emptyArray];
        [self.navigationController pushViewController:controller animated:YES];
    }else if(indexPath.section == 1){
        HelpSale* controller = [[HelpSale alloc]initWithTags:emptyArray];
        [self.navigationController pushViewController:controller animated:YES];
    }else if (indexPath.section == 2){
        HelpTake* controller = [[HelpTake alloc]initWithTags:emptyArray];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark =====================================================  <RandomBuyDelegate>
-(void)didSelecteType:(NSDictionary *)item{
    if([ @"buy" isEqualToString: [item objectForKey: @"key"]]){
        HelpBuy* controller = [[HelpBuy alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([ @"send" isEqualToString: [item objectForKey: @"key"]]){
        HelpSale* controller = [[HelpSale alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([ @"get" isEqualToString: [item objectForKey: @"key"]]){
        HelpTake* controller = [[HelpTake alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        self.HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        self.HUD.mode = MBProgressHUDModeCustomView;
        self.HUD.minSize = CGSizeMake(135.f, 135.f);
        self.HUD.detailsLabelText = @"服务正在开通,\n敬请期待";
        [self.HUD setLabelFont:[UIFont systemFontOfSize:14]];
        self.HUD.removeFromSuperViewOnHide = YES;
        [self.HUD hide:YES afterDelay:3];
    }
}

-(void)randomSearch:(NSString*)keyWord{
    HelpBuy* controller = [[HelpBuy alloc]initWithKeyword:keyWord];
    [self.navigationController pushViewController:controller animated:YES];
    [self.view endEditing:YES];
    self.emptyTxt.text =  @"";
}

-(void)showRandomMap:(id)sender{
    RandomMap* controller = [[RandomMap alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)showRandomOrder:(id)sender{
    RandomShowOrder* controller = [[RandomShowOrder alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

//选中的图片网址有问题
-(void)selectedAdPhoto:(id)sender{
    NSURL *URL = [NSURL URLWithString:[[self.arrayBanner firstObject] objectForKey: @"href"]];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}
#pragma mark =====================================================  <UITextFeildDelegate>
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    HelpBuy* controller = [[HelpBuy alloc]initWithKeyword:self.emptyTxt.text];
    [self.navigationController pushViewController:controller animated:YES];
    [self.view endEditing:YES];
    self.emptyTxt.text =  @"";
    return YES;
}

#pragma mark =====================================================  SEL
-(IBAction)orderTouch:(id)sender{
    if(self.Identity.userInfo.isLogin){
//        跳转订单列表
        RandomOrder* controller = [[RandomOrder alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
//        跳转登录
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


@end
