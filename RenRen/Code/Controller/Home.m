//
//  Home.m
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#import "Home.h"
#import "Location.h"
#import "MapLocation.h"
#import "HomeHeader.h"
#import "HomeHeaderBanner.h"
#import "HomeHeaerZT.h"
#import "HomeHeaderAll.h"
#import "HomeCell.h"
#import "MStore.h"
#import "HomeSection.h"
#import "Goods.h"
#import "StoreList.h"
#import "GoodsList.h"
#import "StoreGoods.h"
#import "Store.h"
#import "MAdv.h"
#import "SpecialGoods.h"
#import "SearchGoods.h"
#import <SVWebViewController/SVWebViewController.h>
#import <SDCycleScrollView/NSData+SDDataCache.h>
#import "AppDelegate.h"

#import "BuyNow.h"
#import "Presale.h"
#import "PintuangouVC.h"
#import "FightGroupItem.h"
#import "FruitList.h"
#import "WineList.h"
#import "RandomBuy.h"

@interface Home ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,HomeSectionDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UITextFieldDelegate>

@property(nonatomic,strong) UICollectionView* collectionView;

@property(nonatomic,strong) UILabel* lableLocation;

@property(nonatomic,strong) NSMutableArray* arrayData;

@property(nonatomic,strong) NSMutableArray* arrayBannerAdv;
@property(nonatomic,strong) NSMutableArray* arrayZTAdv;

@property(nonatomic,strong) UITextField* emptyTxt;

@property(nonatomic,strong) NSString* notice;

@property(nonatomic,strong) MBuyNow* itemBuyNow;
@property(nonatomic,strong)  MFightGroup* itemFightGroup;

@property(nonatomic,strong) UIView* emptyView;
@property(nonatomic,strong) UIImageView* emptyImage;

@property(nonatomic,assign) NSInteger navHeight;
@property(nonatomic,assign) NSInteger maxWidth;
@property(nonatomic,assign) NSInteger minWidth;
@property(nonatomic,strong) UIButton* btnRight;
@property(nonatomic,strong) UIImageView* leftIcon;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIImageView* rightIcon;
@property(nonatomic,strong)  NSLayoutConstraint* constraint;

@end

@implementation Home

-(instancetype)init{
    self = [super init];
    if(self){
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab-home-default"]];
        [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab-home-enter"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self.tabBarItem setTitle:@"首页"];
        self.tabBarItem.tag=0;
    }
    return self;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    [self layoutNav];
    [self layoutUI];
    [self layoutConstraints];
    self.view.backgroundColor = theme_table_bg_color;
    self.collectionView.backgroundColor = theme_table_bg_color;
    if(self.Identity.userInfo.isLogin){
        NSUserDefaults* config = [NSUserDefaults standardUserDefaults];
        if([[config objectForKey: kisBindingJPushTag]boolValue]){
            
        }else{
            [config setObject:@(YES) forKey:kisBindingJPushTag];
            [config synchronize];
            [self registerTagsWithAlias:self.Identity.userInfo.userID];
        }
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againSingleNotification:) name:NotificationAgainSingle object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avtivityPartNotification:) name:NofificatonActivityPart object:nil];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.firstLoad){
        if(self.Identity.location){
            self.labelTitle.text = [NSString stringWithFormat:@"%@",self.Identity.location.address];
            CGSize size = [self.labelTitle intrinsicContentSize];
            CGFloat otherWidth = 10+15+5+6+5;
            CGFloat width = size.width+otherWidth;
            if(width > self.maxWidth){
                width = self.maxWidth - otherWidth;
            }else if (width<=self.minWidth){
                width = self.minWidth-otherWidth;
            }else{
                width = size.width;
            }
            self.btnRight.frame = CGRectMake(0, (self.navHeight-30)/2, width+otherWidth, 30.f);
            self.constraint = [NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
            self.constraint.priority = 1000;
            [self.labelTitle addConstraint:self.constraint];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.firstLoad){
        if(self.Identity.location){
            if(self.Identity.location.isOpen){
                self.collectionView.hidden = NO;
                self.emptyView.hidden = YES;
                [self refreshDataSource];
            }else{
                self.collectionView.hidden = YES;
                self.emptyView.hidden = NO;
            }
            self.firstLoad = NO;
        }else{
            self.firstLoad = YES;
            [self selectLocation:nil];
        }
    }
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  UI布局
-(void)layoutNav{
    
    self.navHeight = self.navigationController.navigationBar.bounds.size.height;
    self.maxWidth = SCREEN_WIDTH*2/3-20;
    self.minWidth = SCREEN_WIDTH/4;
    
    self.btnRight.frame = CGRectMake(0, (self.navHeight-30)/2, self.maxWidth, 30.f);
    [self.btnRight addSubview:self.rightIcon];
    [self.btnRight addSubview:self.labelTitle];
    [self.btnRight addSubview:self.leftIcon];
    
    NSArray* formats = @[ @"H:[leftIcon(==15)][labelTitle(>=minWidth@751)]-5-[rightIcon(==10)]-5-|",
                          @"H:[labelTitle(<=maxWidth@751)]",
                          @"V:|-paddingTopRight-[rightIcon(==6)]",
                          @"V:|-0-[labelTitle]-0-|",
                          @"V:|-paddingTopLeft-[leftIcon(==15)]"
                          ];
    CGFloat empty = 15.f;
    NSDictionary* metorics = @{@"maxWidth":@(self.maxWidth),
                               @"minWidth":@(self.minWidth),
                               @"paddingTopLeft":@((30.f-empty)/2),
                               @"paddingTopRight":@((30.f-6)/2)
                               };
    NSDictionary* views = @{ @"leftIcon":self.leftIcon, @"labelTitle":self.labelTitle, @"rightIcon":self.rightIcon};
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self.btnRight addConstraints:constraints];
    }
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

    leftBtn.frame = CGRectMake( 0, 0, SCREEN_WIDTH/4, 41*SCREEN_WIDTH/4/169);
    [leftBtn setImage:[UIImage imageNamed:@"icon-logo"] forState:UIControlStateNormal];
    UIBarButtonItem* leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    leftBar.width = 41*SCREEN_WIDTH/4/169;
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithCustomView:self.btnRight];
    rightBar.width = self.maxWidth;
    self.navigationItem.leftBarButtonItem = leftBar;
    self.navigationItem.rightBarButtonItem = rightBar;
}

-(void)layoutUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.emptyView];
    [self.emptyView addSubview:self.emptyImage];
}

//设置地址选择
-(void)layoutConstraints{
    CGFloat width = SCREEN_WIDTH;
    CGFloat heigt = width*10/13;
    NSArray* formats = @[@"H:|-0-[collectionView]-0-|",@"V:|-0-[collectionView]-0-|",
                         @"H:|-0-[emptyView]-0-|",@"V:|-0-[emptyView]-0-|",
                         @"H:|-0-[emptyImage(==emptyImageWidth)]",@"V:[topView][emptyImage(==emptyImageHeight)]"
                         ];
    
    NSDictionary* metorics = @{@"emptyImageHeight":@(heigt),@"emptyImageWidth":@(width)};
    NSDictionary* views = @{@"topView":self.topLayoutGuide,@"collectionView":self.collectionView,@"bottomView":self.bottomLayoutGuide,@"emptyView":self.emptyView,@"emptyImage":self.emptyImage};
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self.view addConstraints:constraints];
    }
}

#pragma mark =====================================================  数据源
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_index_best",@"zoneid":self.Identity.location.circleID};
    NetRepositories* response = [[NetRepositories alloc]init];
    [response queryStore:arg complete:^(NSInteger react, NSArray *list, NSInteger count, NSString *message) {
        [self.arrayData removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    }];
    
}

-(void)queryBannerAdv{
    NSDictionary* arg = @{@"ince":@"get_index_banner"};
    NetRepositories* response =[[NetRepositories alloc]init];
    [response queryAdvertBanner:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayBannerAdv removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayBannerAdv addObject:obj];
            }];
            
        }else{
            
        }
        [self.collectionView reloadData];
    }];
    
}
-(void)queryZTAdv{
    NSDictionary* arg = @{@"ince":@"get_index_zt",@"zone_id":self.Identity.location.circleID};
    NetRepositories* response =[[NetRepositories alloc]init];
    [response queryAdvertZT:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayZTAdv removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayZTAdv addObject:obj];
            }];
            
        }else{
            
        }
        [self.collectionView reloadData];
    }];
    
}

-(void)queryNotification{
    NSDictionary* arg = @{@"ince":@"get_message_send"};
    NetRepositories* response = [[NetRepositories alloc]init];
    [response searchNotice:arg complete:^(NSInteger react, id obj, NSString *message) {
        self.notice = nil;
        if(react == 1){
            self.notice = [(MSystemNotice*)obj content];
        }else{
            
        }
        // self.notice =  @"=======";
        [self.collectionView reloadData];
    }];
    
}

-(void)queryBuyNow{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:@{@"ince":@"get_index_miaotui",@"zone_id":self.Identity.location.circleID} complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            
            NSDictionary* emptyBuyNow = [response objectForKey:@"miaosha"];
            if([emptyBuyNow isKindOfClass:[NSDictionary class]]){
                if([WMHelper isNULLOrnil:emptyBuyNow]){
                    self.itemBuyNow = nil;
                }else{
                    self.itemBuyNow = [[MBuyNow alloc]initWithItem:emptyBuyNow];
                }
            }
            NSDictionary* emtpyFight = [response objectForKey:@"tuan"];
            if([emtpyFight isKindOfClass:[NSDictionary class]]){
                if([WMHelper isNULLOrnil:emtpyFight]){
                    self.itemFightGroup = nil;
                }else{
                    self.itemFightGroup = [[MFightGroup alloc]initWithItem:emtpyFight];
                }
            }
        }else{
            
        }
        [self.collectionView reloadData];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                [weakSelf.arrayBannerAdv removeAllObjects];
                [weakSelf.arrayZTAdv removeAllObjects];
                [weakSelf queryData];
                [weakSelf queryBannerAdv];
                [weakSelf queryZTAdv];
                [weakSelf queryNotification];
                [weakSelf queryBuyNow];
            }else
                [weakSelf.collectionView.mj_header endRefreshing];
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  UICollectionView 协议实现

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.arrayData.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    MStore* empty = self.arrayData[section];
    return empty.arrayGoods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = (HomeCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
    MStore* empty = self.arrayData[indexPath.section];
    cell.entity = empty.arrayGoods[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(indexPath.section == 0){
            if(self.arrayBannerAdv.count>0 && self.arrayZTAdv.count >0){
                UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeHeaderAll" forIndexPath:indexPath];
                HomeHeaderAll* emptyHeader = (HomeHeaderAll*)reusableView;
                MStore* emptyStore = self.arrayData[indexPath.section];
                [emptyHeader.btnSection setTitle:emptyStore.storeName forState:UIControlStateNormal];
                emptyHeader.btnSection.tag = indexPath.section;
                emptyHeader.delegate = self;
                self.emptyTxt = emptyHeader.txtSearch;
                self.emptyTxt.returnKeyType=UIReturnKeyDone;
                self.emptyTxt.delegate = self;
                [emptyHeader loadAdvWithTop:self.arrayBannerAdv];
                [emptyHeader loadAdvWithBottom:self.arrayZTAdv];
                [emptyHeader loadNotice:self.notice];
                [emptyHeader loadBuyNow:self.itemBuyNow fightGroup:self.itemFightGroup];
                return reusableView;
            }else if(self.arrayBannerAdv.count>0){
                UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeHeaderBanner" forIndexPath:indexPath];
                HomeHeaderBanner* emptyHeader = (HomeHeaderBanner*)reusableView;
                MStore* emptyStore = self.arrayData[indexPath.section];
                [emptyHeader.btnSection setTitle:emptyStore.storeName forState:UIControlStateNormal];
                emptyHeader.btnSection.tag = indexPath.section;
                emptyHeader.delegate = self;
                self.emptyTxt = emptyHeader.txtSearch;
                self.emptyTxt.returnKeyType=UIReturnKeyDone;
                self.emptyTxt.delegate = self;
                [emptyHeader loadAdvWithTop:self.arrayBannerAdv];
                [emptyHeader loadNotice:self.notice];
                [emptyHeader loadBuyNow:self.itemBuyNow fightGroup:self.itemFightGroup];
                return reusableView;
            }else if (self.arrayZTAdv.count>0){
                UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeHeaerZT" forIndexPath:indexPath];
                HomeHeaerZT* emptyHeader = (HomeHeaerZT*)reusableView;
                MStore* emptyStore = self.arrayData[indexPath.section];
                [emptyHeader.btnSection setTitle:emptyStore.storeName forState:UIControlStateNormal];
                emptyHeader.btnSection.tag = indexPath.section;
                emptyHeader.delegate = self;
                self.emptyTxt = emptyHeader.txtSearch;
                self.emptyTxt.returnKeyType=UIReturnKeyDone;
                self.emptyTxt.delegate = self;
                [emptyHeader loadAdvWithBottom:self.arrayZTAdv];
                [emptyHeader loadNotice:self.notice];
                [emptyHeader loadBuyNow:self.itemBuyNow fightGroup:self.itemFightGroup];
                return reusableView;
                
            }else{
                UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeHeader" forIndexPath:indexPath];
                HomeHeader* emptyHeader = (HomeHeader*)reusableView;
                MStore* emptyStore = self.arrayData[indexPath.section];
                [emptyHeader.btnSection setTitle:emptyStore.storeName forState:UIControlStateNormal];
                emptyHeader.btnSection.tag = indexPath.section;
                emptyHeader.delegate = self;
                [emptyHeader loadNotice:self.notice];
                [emptyHeader loadBuyNow:self.itemBuyNow fightGroup:self.itemFightGroup];
                self.emptyTxt = emptyHeader.txtSearch;
                self.emptyTxt.returnKeyType=UIReturnKeyDone;
                self.emptyTxt.delegate = self;
                return reusableView;
            }
        }else{
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HomeSection" forIndexPath:indexPath];
            HomeSection* emptyHeader = (HomeSection*)reusableView;
            MStore* emptyStore = self.arrayData[indexPath.section];
            [emptyHeader.btnSection setTitle:emptyStore.storeName forState:UIControlStateNormal];
            emptyHeader.btnSection.tag = indexPath.section;
            emptyHeader.delegate = self;
            return reusableView;
        }
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MStore* empty = self.arrayData[indexPath.section];
    MGoods* item =  empty.arrayGoods[indexPath.row];
    Goods* controller = [[Goods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH-1.5)/3;
    CGFloat imgHeight = width - 20;
    CGFloat height  = 10+imgHeight+5+40+20;
    return CGSizeMake(width, height);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0.5f, 0.f, 0.f, 0.5f);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section ==0){
        CGFloat height = 235.f;
        if([WMHelper isNULLOrnil:self.itemBuyNow]&&[WMHelper isNULLOrnil:self.itemFightGroup]){
            height+=0.f;
        }else{
            height+=180.f;
        }
        if(self.arrayBannerAdv.count>0)
            height+=ADVHEIGHT;
        if(self.arrayZTAdv.count>0)
            height+=ADVHEIGHT;
        if(self.notice)
            height+=40.f;
        return CGSizeMake(SCREEN_WIDTH, height);
    }else
        return CGSizeMake(SCREEN_WIDTH, 35);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f; //相邻两个 item 间距
}

#pragma mark =====================================================  DZEmptyData 协议实现
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    return [[NSAttributedString alloc] initWithString:tipEmptyDataTitle attributes:@{NSFontAttributeName :[UIFont boldSystemFontOfSize:17.0],NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    return  [[NSMutableAttributedString alloc] initWithString:tipEmptyDataDescription attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraph}];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -roundf(self.collectionView.frame.size.height/10);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([WMHelper isEmptyOrNULLOrnil:textField.text]){
        [textField resignFirstResponder];
        [self alertHUD:@"请输入关键词!"];
        return NO;
    }
    SearchGoods* controller = [[SearchGoods alloc]initWithKeyword:textField.text];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
    return YES;
}

#pragma mark =====================================================  HomeSection 协议实现
-(void)homeSectionSearch:(NSString *)keyWord{
    if([WMHelper isEmptyOrNULLOrnil:keyWord]){
        [self.emptyTxt resignFirstResponder];
        [self alertHUD:@"请输入关键词!"];
        return;
    }
    SearchGoods* controller = [[SearchGoods alloc]initWithKeyword:keyWord];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}
-(void)sectionTouch:(id)sender{
    MStore* item = self.arrayData[((UIButton*)sender).tag];
    Store* controller = [[Store alloc]initWithItem:item];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}

-(void)didSelectType:(id)sender{
    NSInteger index =[(UIButton*)sender tag];
    NSInteger categoryID,isSelf;
    categoryID = 0;
    isSelf = 0;
    switch (index) {
        case 0://超市
        {
            categoryID = 1;
        }
            break;
        case 1://新鲜水果
        {
            categoryID = 2;
        }
            break;
        case 2://美食外卖
        {
            categoryID = 3;
        }
            break;
        case 3://鲜花蛋糕
        {
            categoryID = 4;
        }
            break;
        case 4://生活用品  秒杀活动
        {
            
            categoryID =3;
            BuyNow* controller  = [[BuyNow alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 5://母婴专区  预约产品
        {
            if(self.Identity.location.mapLat && self.Identity.location.mapLng){
                if(self.Identity.userInfo.isLogin){
                    categoryID =62;
                    RandomBuy* controller = [[RandomBuy alloc]init];
                    controller.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:controller animated:YES];
                }else{
                    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
                    [self presentViewController:nav animated:YES completion:nil];
                }
                
            }else{
                [self selectLocation:nil];
            }
        }
            break;
        case 6://自营  拼团购
        {
            isSelf =1;
            PintuangouVC* controller = [[PintuangouVC alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 7://精品酒水
        {
            categoryID =25;
            WineList* controller = [[WineList alloc]initWithCategoryID:categoryID];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        default:
            break;
    }
    if(index ==2 || index==3){
        StoreList* controller = [[StoreList alloc]initWithCategory:categoryID:@"店铺"];
        controller.hidesBottomBarWhenPushed = YES;
        controller.navigationItem.title = @"店铺";
        [self.navigationController pushViewController:controller animated:YES];
    }else if (index == 4 || index == 5 || index == 6 || index == 7){
        
    }else if (index == 1){
        FruitList* controller = [[FruitList alloc]initWithCategoryID:categoryID];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        GoodsList* controller = [[GoodsList alloc]initWithCategoryID:categoryID isSelf:isSelf];
        controller.navigationItem.title = @"一页快购";
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    [self cancelEdit];
}

-(void)didSelectBannerPhoto:(NSInteger)index{
    MAdv* item = self.arrayBannerAdv[index];
    
    NSURL *URL = [NSURL URLWithString:item.bannerUrl];
    SVWebViewController *controller = [[SVWebViewController alloc] initWithURL:URL];
    controller.hidesBottomBarWhenPushed = YES;
    controller.defTitle = NO;
    controller.navigationItem.title = item.title;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}
-(void)didSelectSpecialPhoto:(NSInteger)index{
    
    MAdv* item = self.arrayZTAdv[index];
    SpecialGoods* controller = [[SpecialGoods alloc]initWithItem:item headerSize:CGSizeMake(SCREEN_WIDTH, 120)];
    controller.hidesBottomBarWhenPushed = YES;
    controller.navigationItem.title = item.title;

    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}


#pragma mark =====================================================  SEL, 私有方法
-(void)selectLocation:(UIButton*)sender{
    self.firstLoad = YES;
    if(self.constraint){
        [self.labelTitle removeConstraint:self.constraint];
    }
    MapLocation* controller = [[MapLocation alloc]init];
    // Location* controller = [[Location alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    [self cancelEdit];
}

-(void)cancelEdit{
    if(self.emptyTxt){
        self.emptyTxt.text = @"";
    }
    [self.view endEditing:YES];
}

#pragma mark =====================================================  通知
-(void)againSingleNotification:(NSNotification*)notification{
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.tabBarController.selectedIndex = 0;
        NSString* storeID = [notification object];
        NSArray* array = [storeID componentsSeparatedByString:@","];
        MStore* item =[[MStore alloc]init];
        item.rowID =array[0];
        Store* controller = [[Store alloc]initWithItem:item];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    });
    
}

-(void)avtivityPartNotification:(NSNotification*)notification{
    NSInteger tag = [notification.object integerValue];
    if(tag == 55){
        BuyNow* conroller = [[BuyNow alloc]init];
        conroller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:conroller animated:YES];
    }else if (tag == 56){
        if(self.itemFightGroup){
            FightGroupItem* conroller = [[FightGroupItem alloc]initWithRowID:self.itemFightGroup.rowID];
            conroller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:conroller animated:YES];
        }else{
            PintuangouVC* controller = [[PintuangouVC alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark =====================================================  绑定极光推送

-(void)registerTagsWithAlias:(NSString*)userID{
    
    __autoreleasing NSMutableSet *tags = [NSMutableSet set];
    __autoreleasing NSString *alias = userID;
    [self analyseInput:&alias tags:&tags];
    
    [JPUSHService setTags:tags alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"TagsAlias回调:\n iResCode:%d  iAlias:%@",iResCode,iAlias);
        if(iResCode == 0){
            
        }else{
            /* UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:@"消息推送注册失败,请退出后再登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [alert show];*/
        }
    }];
}

- (void)setTags:(NSMutableSet **)tags addTag:(NSString *)tag {
    [*tags addObject:tag];
}

- (void)analyseInput:(NSString **)alias tags:(NSSet **)tags {
    // alias analyse
    if (![*alias length]) {
        // ignore alias
        *alias = nil;
    }
    // tags analyse
    if (![*tags count]) {
        *tags = nil;
    } else {
        __block int emptyStringCount = 0;
        [*tags enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop) {
            if ([tag isEqualToString:@""]) {
                emptyStringCount++;
            } else {
                emptyStringCount = 0;
                *stop = YES;
            }
        }];
        if (emptyStringCount == [*tags count]) {
            *tags = nil;
        }
    }
}

#pragma mark =====================================================  属性封装
-(NSMutableArray *)arrayData{
    if(!_arrayData)
        _arrayData = [[NSMutableArray alloc]init];
    return _arrayData;
}

-(NSMutableArray *)arrayBannerAdv{
    if(!_arrayBannerAdv)
        _arrayBannerAdv = [[NSMutableArray alloc]init];
    return _arrayBannerAdv;
}

-(NSMutableArray *)arrayZTAdv{
    if(!_arrayZTAdv)
        _arrayZTAdv = [[NSMutableArray alloc]init];
    return _arrayZTAdv;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.emptyDataSetSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeCell"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHeader class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeader"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHeaderBanner class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderBanner"];
        //[self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHeaerZT class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaerZT"];
        [_collectionView registerClass:[HomeHeaerZT class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaerZT"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeHeaderAll class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeHeaderAll"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeSection class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeSection"];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

-(UIView *)emptyView{
    if(!_emptyView){
        _emptyView = [[UIView alloc]init];
        _emptyView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _emptyView;
}

-(UIImageView *)emptyImage{
    if(!_emptyImage){
        _emptyImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-not-stores"]];
        _emptyImage.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _emptyImage;
}


-(UIButton *)btnRight{
    if(!_btnRight){
        _btnRight =[UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.backgroundColor = [UIColor colorWithRed:205/255.f green:142/255.f blue:30/255.f alpha:1.0];
        _btnRight.layer.masksToBounds = YES;
        _btnRight.layer.cornerRadius = 15.f;
        [_btnRight addTarget:self action:@selector(selectLocation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

-(UIImageView *)rightIcon{
    if(!_rightIcon){
        _rightIcon = [[UIImageView alloc]init];
        [_rightIcon setImage:[UIImage imageNamed: @"icon-arrow-bottom"]];
        _rightIcon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return  _rightIcon;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font= [UIFont systemFontOfSize:14.f];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.lineBreakMode = NSLineBreakByClipping;
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UIImageView *)leftIcon{
    if(!_leftIcon){
        _leftIcon = [[UIImageView alloc]init];
        [_leftIcon setImage:[UIImage imageNamed: @"icon-locate-white"]];
        _leftIcon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _leftIcon;
}


@end
