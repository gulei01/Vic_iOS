//
//  StoreGoods.m
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import "StoreGoods.h"
#import "Pager.h"
#import "GoodsCell.h"
#import "MSubType.h"
#import "SubCategoryCell.h"
#import "Goods.h"
#import "GoodsFooter.h"
#import "MStore.h"
#import "AppDelegate.h"
#import "FruitInfo.h"

@interface StoreGoods ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UITableViewDataSource,UITableViewDelegate,GoodsCellDelegate>
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIView* bottomView;
/**
 *  总价
 */
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
@property(nonatomic,strong) UILabel* labelSumCount;

@property(nonatomic,strong) NSMutableArray* arrayShopCar;

@property(nonatomic,assign) float shopCarSumPrice;

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) NSMutableArray* arraySubCategory;
@property(nonatomic,strong) NSMutableArray* arrayOrder;
@property(nonatomic,strong) NSMutableArray* arrayPrice;
@property(nonatomic,strong) NSMutableArray* arrayCurrent;


@property(nonatomic,strong) Pager* page;

@property(nonatomic,assign) NSInteger subCategoryID;
@property(nonatomic,assign) NSInteger price;
@property(nonatomic,assign) NSInteger order;
@property(nonatomic,assign) NSInteger isSelf;

@property(nonatomic,strong) NSMutableArray* arrayFilter;

@property(nonatomic,strong) UIButton* btnShadow;

@property(nonatomic,strong) NetPage* netPage;
@property(nonatomic,strong) NSMutableArray* arrayData;

@end

@implementation StoreGoods



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.subCategoryID = 0;
    self.price = 0;
    self.order = 0;
    
    [self layoutUI];
    [self layoutConstraints];
    self.firstLoad = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShopCarChangeNotification:) name:NotificationShopCarChange object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.firstLoad){
        [self refreshDataSource];
        self.firstLoad = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.backgroundColor = theme_table_bg_color;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellWithReuseIdentifier:@"GoodsCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsFooter class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"GoodsFooter"];
    [self.view addSubview:self.collectionView];
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor blackColor];
    self.bottomView.alpha=0.7f;
    [self.view addSubview:self.bottomView];
    
    
    self.labelSumPrice = [[UILabel alloc]init];
    self.labelSumPrice.backgroundColor = [UIColor blackColor];
    self.labelSumPrice.alpha=0.7f;
    self.labelSumPrice.textColor = [UIColor whiteColor];
    self.labelSumPrice.text =@"共$0.00 元  ";
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
    
    self.labelSumCount = [[UILabel alloc]init];
    self.labelSumCount.layer.masksToBounds = YES;
    self.labelSumCount.layer.cornerRadius = 10;
    self.labelSumCount.backgroundColor = [UIColor redColor];
    self.labelSumCount.textColor = [UIColor whiteColor];
    self.labelSumCount.text = @"0";
    self.labelSumCount.textAlignment = NSTextAlignmentCenter;
    self.labelSumCount.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:self.labelSumCount];
    
    
    
    self.btnShadow = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnShadow.frame = SCREEN;
    self.btnShadow.hidden = YES;
    self.btnShadow.backgroundColor = [UIColor blackColor];
    self.btnShadow.alpha = 0.4f;
    [self.btnShadow addTarget:self action:@selector(hideShadowTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnShadow];
    
    
    
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 35.f)];
    self.topView.backgroundColor = theme_dropdown_bg_color;
    [self.view addSubview:self.topView];
    NSArray* arrayEmpty = @[@"全部商品",@"综合排序",@"筛选"];
    float emptyWidth = SCREEN_WIDTH/3;
    for (int i =0 ; i<3; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame =CGRectMake(emptyWidth*i, 0, emptyWidth, 35.f);
        [btn addTarget:self action:@selector(selectTypeTouch:) forControlEvents:UIControlEventTouchUpInside];
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(5, 0, emptyWidth-25, 35);
        label.tag = 100;
        label.textColor = theme_title_color;
        label.font = [UIFont systemFontOfSize:14.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.text=arrayEmpty[i];
        [btn addSubview:label];
        
        UIImageView* img = [[UIImageView alloc]init];
        img.frame = CGRectMake(CGRectGetMaxX(label.frame), (35-5)/2, 10, 5);
        img.tag = 200;
        img.image =[UIImage imageNamed:@"icon-arrow-bottom-default"];
        [btn addSubview:img];
        [self.topView addSubview:btn];
        [self.arrayFilter addObject:btn];
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, 0) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.tableFooterView =[[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:self.tableView belowSubview:self.topView];
    
}

-(void)layoutConstraints{
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumCount.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBuy.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOtherPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoCar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:44.f-9]];
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
    
    [self.labelSumCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelSumCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumCount attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumCount attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f+50/2]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumCount attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-45.f]];
    
    
    
}

#pragma mark =====================================================  数据源
-(void)queryData{
   
    NSDictionary* arg = @{@"ince":@"get_shop_food",@"sid":self.storeID,@"cate":[WMHelper integerConvertToString:self.subCategoryID],@"price":[WMHelper integerConvertToString:self.price],@"order":[WMHelper integerConvertToString:self.order],@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
  
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    
//    未完成的任务2
    [reposiories queryGoods:arg page:self.netPage complete:^(NSInteger react, NSArray *list, NSString *message,NSArray *groupArray) {
        if(self.netPage.pageIndex == 1){
            [self.arrayData removeAllObjects];
        }
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        [self.collectionView reloadData];
        if(self.netPage.pageCount<=self.netPage.pageIndex){
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
        if(self.netPage.pageIndex==1){
            [self.collectionView.mj_header endRefreshing];
        }
        
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
                        self.labelSumCount.text = [WMHelper integerConvertToString:sumCount];
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
    self.labelSumCount.text =[WMHelper integerConvertToString:sumCount];
    self.labelSumPrice.text =[NSString stringWithFormat:@"共￥%.2f 元  ",sumPrice];
    self.labelSumPrice.frame = CGRectMake(0, 0, SCREEN_WIDTH/2-10, 45.f);
    self.labelOtherPrice.hidden = NO;
    self.btnBuy.hidden = YES;
    self.labelOtherPrice.text =@"差9.00元送货";
}

-(void)querySubCategory{
    
    NSDictionary* arg = @{@"ince":@"get_shop_cate",@"siteid":self.storeID};
   
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories querySubType:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arraySubCategory removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arraySubCategory addObject:obj];
            }];
        }else{
            [self alertHUD:message];
        }
    }];

}
-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.collectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.page.pageIndex = 1;
                [weakSelf queryData];
                [weakSelf querySubCategory];
                [weakSelf queryShopCar];
            }else
                [weakSelf.collectionView.mj_header endRefreshing];
        }];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.page.pageIndex++;
                [weakSelf queryData];
            }else
                [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  UICollectionView 协议实现
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.page.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell *cell = (GoodsCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
    cell.entity = self.page.arrayData[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GoodsFooter" forIndexPath:indexPath];
        return reusableView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoods* item =  self.page.arrayData[indexPath.row];
   // Goods* controller = [[Goods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
    FruitInfo* controller = [[FruitInfo alloc]initWithItem:item];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH-4)/3;
    CGFloat imgHeight = width - 20;
    CGFloat height  = 10+imgHeight+5+40+20+20;
    return CGSizeMake(width, height);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 45.f);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(1.0f, 0.5f, 0.f, 0.5f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f; //相邻两个 item 间距
}


#pragma mark =====================================================  GoodsCell 协议实现
-(void)addToShopCar:(MGoods *)item{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            if(self.Identity.userInfo.isLogin){
                [self showHUD];
                NSDictionary* arg = @{@"ince":@"addcart",@"fid":item.rowID,@"uid":self.Identity.userInfo.userID,@"num":@"1"};
                NetRepositories* repositories = [[NetRepositories alloc]init];
                [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
                    if(react == 1){
                        [self alertHUD:@"添加成功!"];
                        [self queryShopCar];
                    }else if(react == 400){
                        [self alertHUD:message];
                    }else{
                        [self alertHUD:message];
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
    }];
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
    return roundf(self.collectionView.frame.size.height/10.0);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
#pragma mark =====================================================   UITableView 协议实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayCurrent.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIndentifier = @"SubCategoryCell";
    SubCategoryCell* cell =(SubCategoryCell*) [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(!cell)
        cell = [[SubCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    cell.entity = self.arrayCurrent[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIButton* btn= nil;
    MSubType* item = self.arrayCurrent[indexPath.row];
    if(self.arrayCurrent == self.arraySubCategory){
        btn =  self.arrayFilter[0];
        self.subCategoryID = [item.rowID integerValue];
    }else if (self.arrayCurrent == self.arrayOrder){
        btn =  self.arrayFilter[1];
        self.order = [item.rowID integerValue];
    }else{
        btn =  self.arrayFilter[2];
        self.price = [item.rowID integerValue];
    }
    UILabel* label = (UILabel*)[btn viewWithTag:100];
    label.text =item.categoryName;
    [self hideShadowTouch:nil];
    [self.collectionView.mj_header beginRefreshing];
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    footer.backgroundColor = theme_navigation_color;
    return footer;
}*/

#pragma mark =====================================================  SEL
-(IBAction)selectTypeTouch:(id)sender{
    NSInteger index =[(UIButton*)sender tag];
    UIButton* btn = self.arrayFilter[index];
    btn.selected = !btn.selected;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame)-40, SCREEN_WIDTH, 0);
        __block NSInteger hideCount=0;
        [self.arrayFilter enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(((UIButton*)obj).selected)
                *stop = YES;
            hideCount++;
        }];
        if(hideCount== self.arrayFilter.count)
            self.btnShadow.hidden = YES;
    } completion:^(BOOL finished) {
        [self.arrayFilter enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(index!=idx){
                UIButton* emptyBtn =(UIButton*)obj;
                emptyBtn.selected = NO;
                [UIView animateWithDuration:0.5 animations:^{
                    UIImageView* img = (UIImageView*)[emptyBtn viewWithTag:200];
                    img.transform = CGAffineTransformMakeRotation(0);
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                if(btn.selected){
                    [UIView animateWithDuration:0.5 animations:^{
                        UIImageView* img = (UIImageView*)[btn viewWithTag:200];
                        img.transform = CGAffineTransformMakeRotation(M_PI);
                        self.arrayCurrent = idx==0?self.arraySubCategory:idx==1?self.arrayOrder:self.arrayPrice;
                        CGFloat height = self.arrayCurrent.count>7?40*7:40*(self.arrayCurrent.count+1);
                        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, height);
                        self.btnShadow.hidden = NO;
                        [self.tableView reloadData];
                    } completion:^(BOOL finished) {
                        
                    }];
                }
            }
        }];
    }];
}
-(IBAction)hideShadowTouch:(id)sender{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame)-40, SCREEN_WIDTH, 0);
        [self.arrayFilter enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton* emptyBtn= (UIButton*)obj;
            emptyBtn.selected=NO;
            UIImageView* img = (UIImageView*)[emptyBtn viewWithTag:200];
            img.transform = CGAffineTransformMakeRotation(0);
        }];
    }completion:^(BOOL finished) {
        self.btnShadow.hidden = YES;
    }];
}

-(IBAction)goShopCar:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGoClearing object:nil];
    if(self.tabBarController.selectedIndex==1)
        [self.navigationController popViewControllerAnimated:YES];
    else
        self.tabBarController.selectedIndex=1;
}

#pragma mark =====================================================  通知
-(void)ShopCarChangeNotification:(NSNotification*)notification{
    self.firstLoad = YES;
}
-(void)logoutNotification:(NSNotification*)notification{
    self.firstLoad = YES;
}
#pragma mark =====================================================  属性封装
-(Pager *)page{
    if(!_page)
        _page = [[Pager alloc]init];
    return _page;
}

-(NSMutableArray *)arrayFilter{
    if(!_arrayFilter)
        _arrayFilter = [[NSMutableArray alloc]init];
    return _arrayFilter;
}
-(NSMutableArray *)arraySubCategory{
    if(!_arraySubCategory)
        _arraySubCategory = [[NSMutableArray alloc]init];
    return _arraySubCategory;
}

-(NSMutableArray *)arrayShopCar{
    if(!_arrayShopCar)
        _arrayShopCar = [[NSMutableArray alloc]init];
    return _arrayShopCar;
}

-(NSMutableArray *)arrayPrice{
    if(!_arrayPrice){
        _arrayPrice = [[NSMutableArray alloc]init];
        [_arrayPrice addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"0",@"cate_name" : @"默认",@"num" :@"0" }]];
        [_arrayPrice addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"1",@"cate_name" : @"0-10元",@"num" :@"0" }]];
        [_arrayPrice addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"2",@"cate_name" : @"10-100元",@"num" :@"0" }]];
        [_arrayPrice addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"3",@"cate_name" : @"100元以上",@"num" :@"0" }]];
    }
    return _arrayPrice;
}
-(NSMutableArray *)arrayOrder{
    if(!_arrayOrder){
        _arrayOrder = [[NSMutableArray alloc]init];
        [_arrayOrder addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"1",@"cate_name" : @"默认",@"num" :@"0" }]];
        [_arrayOrder addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"2",@"cate_name" : @"销售降序",@"num" :@"0" }]];
        [_arrayOrder addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"3",@"cate_name" : @"价格降序",@"num" :@"0" }]];
        [_arrayOrder addObject:[[MSubType alloc]initWithItem:@{@"cate_id" : @"4",@"cate_name" : @"价格升序",@"num" :@"0" }]];
    }
    return _arrayOrder;
}

-(NetPage *)netPage{
    if(!_netPage){
        _netPage = [[NetPage alloc]init];
        _netPage.pageIndex = 1;
    }
    return _netPage;
}

@end
