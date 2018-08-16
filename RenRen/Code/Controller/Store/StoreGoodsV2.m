//
//  StoreGoodsV2.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/20.
//
//

#import "StoreGoodsV2.h"
#import "GoodsV2Cell.h"
#import "Goods.h"
#import "Car.h"

@interface StoreGoodsV2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GoodsCellDelegate>

@property(nonatomic,strong) NSString* storeID;

@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIView* carView;

@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) NetPage* netPage;

@end

@implementation StoreGoodsV2

-(instancetype)initWithStoreID:(NSString *)storeID{
    self = [super init];
    if(self){
        _storeID = storeID;
    }
    return self;
}

static NSString * const reuseIdentifier = @"GoodsV2Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
    [self refreshDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.carView];
    
    NSArray* formats = @[@"H:|-defEdge-[collectionView]-defEdge-|",@"H:|-defEdge-[carView]-defEdge-|", @"V:|-defEdge-[collectionView][carView(==carHeight)]-defEdge-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"carHeight":@(45)};
    NSDictionary* views = @{ @"collectionView":self.collectionView, @"carView":self.carView};
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
}

#pragma mark =====================================================  数据源
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_shop_food_miao",@"sid":self.storeID,@"cate":@"0",@"price":@"0",@"order":@"0",@"page":[WMHelper integerConvertToString:self.netPage.pageIndex]};
    
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    [reposiories queryGoods:arg page:self.netPage complete:^(NSInteger react, NSArray *list, NSString *message) {
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

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.collectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.netPage.pageIndex = 1;
                [weakSelf queryData];
            }else
                [weakSelf.collectionView.mj_header endRefreshing];
        }];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.netPage.pageIndex++;
                [weakSelf queryData];
            }else
                [weakSelf.collectionView.mj_footer endRefreshing];
        }];
        
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark =====================================================  <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsV2Cell *cell = (GoodsV2Cell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoods* item =  self.arrayData[indexPath.row];
    Goods* controller = [[Goods alloc]init];
    controller.goodsID = item.rowID;
    controller.title = item.goodsName;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH-4)/3;
    CGFloat imgSize = width - 20;
    CGFloat bottomHeight = 80;
    CGFloat height  = 10+imgSize+5+bottomHeight;
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f; //相邻两个 item 间距
}
#pragma mark =====================================================  GoodsCell 协议实现
-(void)addToShopCar:(MGoods *)item{
    if(self.Identity.userInfo.isLogin){
        NSDictionary* arg = @{@"ince":@"addcart",@"fid":item.rowID,@"uid":self.Identity.userInfo.userID,@"num":@"1"};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
            if(react == 1){
                [self alertHUD:@"添加成功!"];
               [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshShopCar object:nil];
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

#pragma mark =====================================================  property packge
-(UIView *)carView{
    if(!_carView){
        Car* car = [[Car alloc]init];
        [self addChildViewController:car];
        _carView = car.view;
        _carView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _carView;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[GoodsV2Cell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _collectionView;
}

-(NetPage *)netPage{
    if(!_netPage){
        _netPage = [[NetPage alloc]init];
        _netPage.pageIndex = 1;
    }
    return _netPage;
}

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData  = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}


@end
