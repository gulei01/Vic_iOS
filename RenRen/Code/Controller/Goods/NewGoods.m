//
//  NewGoods.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/25.
//
//

#import "NewGoods.h"
#import "Car.h"
#import "GoodsCell.h"
#import "GoodsHeader.h"
#import "GoodsHeaderDrug.h"
#import "Store.h"
#import "Goods.h"
#import "GoodsFooter.h"
#import "WXApi.h"

@interface NewGoods ()<GoodsHeaderDelegate,GoodsCellDelegate,UMSocialUIDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) MGoods* entity;
@property(nonatomic,strong) NSMutableArray* arrayGoods;
@property(nonatomic,strong) UIView* carView;
@property(nonatomic,copy) NSString* goodsID;
@property(nonatomic,copy) NSString* goodsName;
@end

@implementation NewGoods
-(instancetype)initWithGoodsID:(NSString *)goodsID goodsName:(NSString *)goodsName{
    self = [super init];
    if(self){
        _goodsID = goodsID;
        _goodsName = goodsName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self layoutUI];
    [self queryData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShopCarChangeNotification:) name:NotificationShopCarChange object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoutNotification:) name:NotificationLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData:) name:NotificationRefreshGoodsInfo object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = self.goodsName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
}

#pragma mark =====================================================  UI布局
-(void)layoutUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.carView];
    
    NSArray* formats = @[@"H:|-defEdge-[collectionView]-defEdge-|",@"H:|-defEdge-[carView]-defEdge-|", @"V:|-defEdge-[collectionView][carView(==carHeight)]-defEdge-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"carHeight":@(45)};
    NSDictionary* views = @{ @"collectionView":self.collectionView, @"carView":self.carView};
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
    
}

#pragma mark =====================================================  数据源
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_food_info_ince",@"fid":self.goodsID};
    NetRepositories* response = [[NetRepositories alloc]init];
    [response searchGoods:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            self.entity = (MGoods*)obj;
            [self queryRecommand];
        }else{
            [self alertHUD:message complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
    
}

-(void)queryRecommand{
    NSDictionary* arg = @{@"ince":@"get_food_info_tuijian",@"fid":self.goodsID,@"zoneid":self.Identity.location.circleID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryGoods:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayGoods removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MGoods* item = (MGoods*)obj;
                item.storeStatus = @"1";
                [self.arrayGoods addObject:obj];
            }];
        }else{
            
        }
        [self.collectionView reloadData];
    }];
}


-(void)refreshData:(NSNotification*)notification{
    [self.collectionView reloadData];
}

#pragma mark =====================================================  UICollectionView 协议实现
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.entity)
        return 1;
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayGoods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell *cell = (GoodsCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
    cell.entity = self.arrayGoods[indexPath.row];
    cell.delegate =self;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoods* item =  self.arrayGoods[indexPath.row];
    Goods* controller = [[Goods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH-4)/3;
    CGFloat imgHeight = width - 20;
    CGFloat height  = 10+imgHeight+5+40+20+20;
    return CGSizeMake(width, height);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if([self.entity.desc integerValue] == 0){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GoodsHeader" forIndexPath:indexPath];
            GoodsHeader* emptyHeader = (GoodsHeader*)reusableView;
            emptyHeader.entity = self.entity;
            emptyHeader.delegate = self;
            return reusableView;
        }else{
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GoodsHeaderDrug" forIndexPath:indexPath];
            GoodsHeaderDrug* emptyHeader = (GoodsHeaderDrug*)reusableView;
            emptyHeader.entity = self.entity;
            emptyHeader.delegate =self;
            return reusableView;
        }
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GoodsFooter" forIndexPath:indexPath];
        return reusableView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(CGSizeEqualToSize(self.entity.thumbnailsSize, CGSizeZero)){
        return CGSizeMake(SCREEN_WIDTH, 180+SCREEN_WIDTH);
    }else{
        CGFloat height = 200.f+self.entity.thumbnailsSize.height;
        return  CGSizeMake(SCREEN_WIDTH, height);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1.0f, 0.5f, 0.f, 0.5f);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 45.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f; //相邻两个 item 间距
}

#pragma mark =====================================================  GoodsHeader 协议实现
-(void)didSelectInfo:(id)sender{
    NSString *url = [NSString stringWithFormat:@"http://wm.wm0530.com/Mobile/re/foodinfo?fid=%@",self.entity.rowID] ;
    NSURL *URL = [NSURL URLWithString:url];
    SVWebViewController *controller = [[SVWebViewController alloc] initWithURL:URL];
    controller.defTitle = NO;
    controller.navigationItem.title = [NSString stringWithFormat:@"%@说明书",self.entity.goodsName];
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)didSelectSotre:(id)sender{
    MStore* item =[[MStore alloc]init];
    item.rowID = self.entity.storeID;
    Store* controller = [[Store alloc]initWithItem:item];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)addShopCar:(id)sender{
    [self updateShopCar:self.entity];
}
#pragma mark =====================================================  GoodsCell 协议实现
-(void)addToShopCar:(MGoods *)item{
    [self updateShopCar:item];
}

-(void)updateShopCar:(MGoods*)item{
    if(self.Identity.userInfo.isLogin){
        [self showHUD];
        NSDictionary* arg = @{@"ince":@"addcart",@"fid":item.rowID,@"uid":self.Identity.userInfo.userID,@"num":@"1"};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
            if(react == 1){
                [self hidHUD:@"添加成功!"];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshShopCar object:nil];
            }else if(react == 400){
                [self hidHUD:message];
            }else{
                [self hidHUD:message];
            }
        }];
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}


#pragma mark =====================================================  <UMSocialUIDelegate>
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        //NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else{
        
    }
}

-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData{
    NSString* url = [NSString stringWithFormat: @"http://wm.wm0530.com/Mobile/Food/index?id=%@",self.entity.rowID];
    if (platformName==UMShareToWechatTimeline) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
        
    }
    else if (platformName==UMShareToWechatSession)
    {
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
    }
    else if (platformName==UMShareToQQ)
    {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
        [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
    }
    else if (platformName==UMShareToQzone)
    {
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.entity.defaultImg]]];
        
    }else if (platformName==UMShareToEmail){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }else if (platformName == UMShareToSms){
        NSString* str = [NSString stringWithFormat: @"%@ %@", socialData.shareText,url];
        socialData.shareText = str;
    }
    
}


#pragma mark =====================================================  SEL
-(IBAction)shareTouch:(id)sender{
    NSArray* arrayShare = nil;
    if(![WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToEmail,UMShareToSms];
    }else  if (![WXApi isWXAppInstalled] && [QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms];
    }else if ([WXApi isWXAppInstalled] && ![QQApiInterface isQQInstalled]){
        arrayShare = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToEmail,UMShareToSms];
    }else{
        arrayShare = @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToSms];
    }
    [UMSocialData defaultData].extConfig.title = self.entity.goodsName;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kYouMengAppKey
                                      shareText:[NSString stringWithFormat: @"%@ 来自#外卖郎iOS#",self.entity.goodsName]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:arrayShare
                                       delegate:self];
}

-(IBAction)goShopCar:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGoClearing object:nil];
    
    if(self.tabBarController.selectedIndex==1)
        [self.navigationController popToRootViewControllerAnimated:YES];
    else
        self.tabBarController.selectedIndex=1;
    
    
}

#pragma mark =====================================================  通知
-(void)ShopCarChangeNotification:(NSNotification*)notification{
    [self queryData];
}
-(void)logoutNotification:(NSNotification*)notification{
    [self queryData];
}


#pragma mark =====================================================  property packge
-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.backgroundColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellWithReuseIdentifier:@"GoodsCell"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsHeader class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsHeader"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsHeaderDrug class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsHeaderDrug"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsFooter class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"GoodsFooter"];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

-(UIView *)carView{
    if(!_carView){
        Car* car = [[Car alloc]init];
        [self addChildViewController:car];
        _carView = car.view;
        _carView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _carView;
}

-(NSMutableArray *)arrayGoods{
    if(!_arrayGoods){
        _arrayGoods = [[NSMutableArray alloc]init];
    }
    return _arrayGoods;
}



@end
