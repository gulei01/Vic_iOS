//
//  SearchGoods.m
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import "SearchGoods.h"
#import "Pager.h"
#import "GoodsCell.h"
#import "Goods.h"
#import "GoodsFooter.h"
#import "MStore.h"
#import "Car.h"
#import "AppDelegate.h"
#import "FruitInfo.h"

@interface SearchGoods ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,GoodsCellDelegate>

@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIView* carView;

@property(nonatomic,strong) NetPage* netPage;
@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,copy) NSString* keyword;
@end

@implementation SearchGoods

-(instancetype)initWithKeyword:(NSString *)keyword{
    self = [super init];
    if(self){
        _keyword = keyword;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = theme_table_bg_color;
    [self layoutUI];
    [self refreshDataSource];
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShopCarChangeNotification:) name:NotificationShopCarChange object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoutNotification:) name:NotificationLogout object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = self.keyword;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI 布局
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
    
    NSDictionary* arg = @{@"ince":@"search_list",@"zoneid":self.Identity.location.circleID,@"keyword":self.keyword,@"page":[WMHelper integerConvertToString:self.netPage.pageIndex]};
    
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    [reposiories queryGoodsWithSearch:arg page:self.netPage complete:^(NSInteger react, NSArray *list, NSString *message) {
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
        weakSelf.netPage.pageIndex=1;
        [weakSelf queryData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        weakSelf.netPage.pageIndex++;
        [weakSelf queryData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark =====================================================  UICollectionView 协议实现
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if(self.arrayData.count>0)
        return 1;
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell *cell = (GoodsCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoods* item =  self.arrayData[indexPath.row];
    //Goods* controller = [[Goods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
    FruitInfo* controller = [[FruitInfo alloc]initWithItem:item];
    [self.navigationController pushViewController:controller animated:YES];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH-4)/3;
    CGFloat imgHeight = width - 20;
    CGFloat height  = 10+imgHeight+5+40+20+20;
    return CGSizeMake(width, height);
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
    if(self.Identity.userInfo.isLogin){
        
        NSDictionary* arg = @{@"ince":@"addcart",@"fid":item.rowID,@"uid":self.Identity.userInfo.userID,@"num":@"1"};
        
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories updateShopCar:arg complete:^(NSInteger react, id obj, NSString *message) {
            if(react == 1){
                [self alertHUD:@"添加成功!"];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshShopCar object:nil];
            }else if(react == 400){
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

#pragma mark =====================================================  SEL
-(IBAction)goShopCar:(id)sender{
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationGoClearing object:nil];
    self.tabBarController.selectedIndex=1;
}
#pragma mark =====================================================  通知
-(void)logoutNotification:(NSNotification*)notification{
    [self.collectionView.mj_header beginRefreshing];
}
#pragma mark =====================================================  属性封装
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
        self.collectionView.emptyDataSetDelegate = self;
        self.collectionView.emptyDataSetSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellWithReuseIdentifier:@"GoodsCell"];
       // [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsFooter class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"GoodsFooter"];
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
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
