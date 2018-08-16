//
//  Goods.m
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import "Goods.h"
#import "MGoods.h"
#import "MStore.h"
#import "GoodsCell.h"
#import "GoodsHeader.h"
#import "GoodsHeaderDrug.h"
//#import "StoreGoods.h"
#import "Store.h"
#import "GoodsFooter.h"
#import <SVWebViewController/SVWebViewController.h>
#import "AppDelegate.h"
#import "NewGoods.h"



@interface Goods ()<GoodsHeaderDelegate,GoodsCellDelegate,UMSocialUIDelegate>
@property(nonatomic,strong) MGoods* entity;
@property(nonatomic,strong) NSMutableArray* arrayGoods;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelSumPrice;
@property(nonatomic,strong) UILabel* labelOtherPrice;
@property(nonatomic,strong) UIButton* btnBuy;

/**
 *  购物车图标
 */
@property(nonatomic,strong) UIImageView* photoCar;
/**
 *  商品数量
 */
@property(nonatomic,strong) UILabel* labelNum;

@property(nonatomic,strong) NSMutableArray* arrayShopCar;

@property(nonatomic,assign) float shopCarSumPrice;

@property(nonatomic,copy) NSString* goodsID;
@property(nonatomic,copy) NSString* goodsName;

@end

@implementation Goods

-(instancetype)initWithGoodsID:(NSString *)goodsID goodsName:(NSString *)goodsName{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    if(self){
        _goodsID = goodsID;
        _goodsName = goodsName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //  [self clearCache];
    // Do any additional setup after loading the view.
    
    [self layoutUI];
    [self layoutConstraints];
    [self queryData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShopCarChangeNotification:) name:NotificationShopCarChange object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoutNotification:) name:NotificationLogout object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData:) name:NotificationRefreshGoodsInfo object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self queryShopCar];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = self.goodsName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI布局
-(void)layoutUI{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellWithReuseIdentifier:@"GoodsCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsHeader class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsHeader"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsHeaderDrug class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsHeaderDrug"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsFooter class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"GoodsFooter"];
    self.collectionView.backgroundColor = theme_table_bg_color;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor blackColor];
    self.bottomView.alpha = 0.7f;
    [self.view addSubview:self.bottomView];
    
    self.labelSumPrice = [[UILabel alloc]init];
    self.labelSumPrice.backgroundColor = [UIColor blackColor];
    self.labelSumPrice.alpha=0.7f;
    self.labelSumPrice.textColor = [UIColor whiteColor];
    self.labelSumPrice.text =@"共￥0.00 元  ";
    self.labelSumPrice.textAlignment = NSTextAlignmentRight;
    self.labelSumPrice.font = [UIFont systemFontOfSize:15.f];
    [self.bottomView addSubview:self.labelSumPrice];
    
    self.labelOtherPrice = [[UILabel alloc]init];
    self.labelOtherPrice.backgroundColor = [UIColor darkGrayColor];
    self.labelOtherPrice.alpha=0.7f;
    self.labelOtherPrice.textColor = [UIColor whiteColor];
    self.labelOtherPrice.text =@"差9.00元送货";
    self.labelOtherPrice.textAlignment = NSTextAlignmentCenter;
    self.labelOtherPrice.font = [UIFont systemFontOfSize:15.f];
    self.labelOtherPrice.hidden = NO;
    [self.bottomView addSubview:self.labelOtherPrice];
    
    self.btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBuy.backgroundColor = [UIColor redColor];
    self.btnBuy.alpha = 0.7f;
    [self.btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBuy setTitle:@"去结算" forState:UIControlStateNormal];
    self.btnBuy.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.btnBuy.hidden = YES;
    self.btnBuy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.btnBuy addTarget:self action:@selector(goShopCar:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.btnBuy];
    
    self.photoCar = [[UIImageView alloc]init];
    [self.photoCar setImage:[UIImage imageNamed:@"icon-shop-car"]];
    [self.view addSubview:self.photoCar];
    
    self.labelNum = [[UILabel alloc]init];
    self.labelNum.layer.masksToBounds = YES;
    self.labelNum.layer.cornerRadius = 10;
    self.labelNum.backgroundColor = [UIColor redColor];
    self.labelNum.textColor = [UIColor whiteColor];
    self.labelNum.text = @"0";
    self.labelNum.textAlignment = NSTextAlignmentCenter;
    self.labelNum.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:self.labelNum];
}
-(void)layoutConstraints{
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelNum.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBuy.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOtherPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoCar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2-10]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelSumPrice attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.photoCar addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.photoCar addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.f]];
    
    [self.labelNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f+50/2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-45.f]];
    
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
            //[self alertHUD:message];
        }
        [self.collectionView reloadData];
        //  [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)queryShopCar{
    if(self.Identity.userInfo.isLogin){
        NSDictionary* arg = @{@"ince":@"getcart",@"zoneid":self.Identity.location.circleID,@"uid":self.Identity.userInfo.userID};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories queryShopCar:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
            [self.arrayShopCar removeAllObjects];
            if(react == 1){
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.arrayShopCar addObject:obj];
                }];
                
                __block NSInteger sumCount=0;
                __block float sumPrice = 0.f;
                [self.arrayShopCar enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MStore* item = (MStore*)obj;
                    sumCount+=item.shopCarGoodsCount;
                    sumPrice+= item.shopCarGoodsPrice;
                }];
                
                self.shopCarSumPrice = sumPrice;
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    [UIView animateWithDuration:0.7 animations:^{
                        self.labelNum.text = [WMHelper integerConvertToString:sumCount];
                        if(sumPrice>=[@"9.00" floatValue]){
                            self.labelSumPrice.frame = CGRectMake(0, 0, SCREEN_WIDTH*2/3-10, 45.f);
                            self.labelOtherPrice.hidden = YES;
                            self.btnBuy.hidden = NO;
                        }else{
                            self.labelSumPrice.frame = CGRectMake(0, 0, SCREEN_WIDTH/2-10, 45.f);
                            self.labelOtherPrice.hidden = NO;
                            self.btnBuy.hidden = YES;
                            self.labelOtherPrice.text =[NSString stringWithFormat:@"差%.2f元送货",[@"9.00" floatValue] - sumPrice];
                        }
                        self.labelSumPrice.text = [NSString stringWithFormat:@"共￥%.2f元",sumPrice];
                    }];
                });
                
            }else{
                [self loadShopCar:0 sumPrice:0.00];
            }
        }];
    }else{
        [self loadShopCar:0 sumPrice:0.00];
    }
    
}

-(void)loadShopCar:(NSInteger)sumCount sumPrice:(float)sumPrice{
    self.labelNum.text =[WMHelper integerConvertToString:sumCount];
    self.labelSumPrice.text =[NSString stringWithFormat:@"共￥%.2f 元  ",sumPrice];
    self.labelSumPrice.frame = CGRectMake(0, 0, SCREEN_WIDTH/2-10, 45.f);
    self.labelOtherPrice.hidden = NO;
    self.btnBuy.hidden = YES;
    self.labelOtherPrice.text =@"差9.00元送货";
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.collectionView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                [weakSelf queryData];
                [weakSelf queryShopCar];
            }else
                [weakSelf.collectionView.mj_header endRefreshing];
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
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
    NewGoods* controller = [[NewGoods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
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
                [self queryShopCar];
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
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
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
    [self queryShopCar];
}
-(void)logoutNotification:(NSNotification*)notification{
    [self queryData];
    [self queryShopCar];
}
#pragma mark =====================================================  属性封装
-(NSMutableArray *)arrayGoods{
    if(!_arrayGoods)
        _arrayGoods = [[NSMutableArray alloc]init];
    return _arrayGoods;
}
-(NSMutableArray *)arrayShopCar{
    if(!_arrayShopCar)
        _arrayShopCar = [[NSMutableArray alloc]init];
    return _arrayShopCar;
}
@end
