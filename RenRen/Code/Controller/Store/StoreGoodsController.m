//
//  StoreGoodsController.m
//  KYRR
//
//  Created by kyjun on 16/4/15.
//
//

#import "StoreGoodsController.h"
#import "GoodsV2Cell.h"
#import "Goods.h"
#import "Car.h"
#import "BuyNowInfo.h"
#import "FruitInfo.h"
#import "ThrowLineTool.h"
#import "MyDesignCollectionReusableView.h"
#import "MyGroupModel.h"

@interface StoreGoodsController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GoodsCellDelegate,ThrowLineToolDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSString* storeID;
@property(nonatomic,strong) NSString* goodsID;

@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIView* carView;

@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) NetPage* netPage;

//抛物线红点
@property (strong, nonatomic) UIImageView *redView;

@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSArray* arrayText;
@property(nonatomic,strong) UILabel *kindOfLable;
@property(nonatomic,assign) int selectedTag;

@property(nonatomic,assign) int SlideState;

@property(nonatomic,strong) NSArray *tasteTabViewArr;

@property(nonatomic,strong) NSMutableArray *kindArray;

#define collectionCellWidth 90

@end

static NSString* const celV2Identifier =  @"GoodsV2Cell";


@implementation StoreGoodsController
-(instancetype)initWithStoreID:(NSString *)storeID{
    self = [super init];
    if(self){
        _storeID = storeID;
    }
    return self;
}

-(instancetype)initWithStoreID:(NSString *)storeID goodsID:(NSString*)goodsID;{
    self = [super init];
    if(self){
        _storeID = storeID;
        _goodsID = goodsID;
    }
    return self;
}
static NSString * const reuseIdentifier = @"GoodsV2Cell";

- (void)viewDidLoad {
    [ThrowLineTool sharedTool].delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FXLShoppingButton:) name:FXLShoppingSelectingBtn object:nil];
    
    [super viewDidLoad];
    
    self.tasteTabViewArr = [[NSArray alloc]init];

    self.kindArray = [[NSMutableArray alloc]init];
    
    [self refreshDataSource];
    
    [self layoutUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.collectionView];
    [self createTableView];
    [self.view addSubview:_tableView];
    [self.view addSubview:self.carView];
    
    NSArray* formats = @[@"H:|-lefEdge-[collectionView]-defEdge-|",@"H:|-defEdge-[carView]-defEdge-|", @"V:|-defEdge-[collectionView][carView(==carHeight)]-defEdge-|"];
    NSDictionary* metrics = @{ @"lefEdge":@(collectionCellWidth),@"defEdge":@(0), @"carHeight":@(45)};
    NSDictionary* views = @{ @"collectionView":self.collectionView, @"carView":self.carView};
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];

    
}
#pragma mark =====================================================  自定义tableview
- (void)createTableView {

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, collectionCellWidth, SCREEN_HEIGHT-190-45-14) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = theme_table_bg_color;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    return self.tasteTabViewArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = theme_table_bg_color;
    
    
    _kindOfLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, collectionCellWidth, 50)];
    
    _kindOfLable.backgroundColor = theme_table_bg_color;
    _kindOfLable.textColor = theme_Color(53, 53, 53);
    _kindOfLable.tag = indexPath.section+200;

    if (indexPath.section == 0) {
        _kindOfLable.textColor = theme_navigation_color;
        _kindOfLable.backgroundColor = [UIColor whiteColor];

    }
    
    MyGroupModel *myModel = self.tasteTabViewArr[indexPath.section];
    _kindOfLable.text = myModel.title;
    _kindOfLable.textAlignment = NSTextAlignmentCenter;
    
    if (_tasteTabViewArr.count) {
        
        [cell.contentView addSubview:_kindOfLable];

    }
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, collectionCellWidth, 1)];
    lineView.backgroundColor =  theme_line_color;
    [cell.contentView addSubview:lineView];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (_selectedTag == indexPath.section) {

        return;
    }else {
        
        UILabel *lable = [self.view viewWithTag:(int)indexPath.section+200];
        lable.textColor = theme_navigation_color;
        lable.backgroundColor = [UIColor whiteColor];
        
        UILabel *lable1 = [self.view viewWithTag:_selectedTag+200];
        lable1.textColor = theme_Color(53, 53, 53);
        lable1.backgroundColor = theme_table_bg_color;
    }
    
    _selectedTag = (int)indexPath.section;
    
    [self slideCollection];
}

- (void)slideCollection {

//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:_selectedTag];
//    
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    NSIndexPath* cellIndexPath = [NSIndexPath indexPathForItem:0 inSection:_selectedTag];
    UICollectionViewLayoutAttributes* attr = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:cellIndexPath];
    UIEdgeInsets insets = self.collectionView.scrollIndicatorInsets;
    
    CGRect rect = attr.frame;
    rect.size = self.collectionView.frame.size;
    rect.size.height -= insets.top + insets.bottom + 43;
    CGFloat offset = (rect.origin.y + rect.size.height) - self.collectionView.contentSize.height;
    if ( offset > 0.0 ) rect = CGRectOffset(rect, 0, -offset);
    
    _SlideState = 0;
    
    [self.collectionView scrollRectToVisible:rect animated:YES];
    
}

#pragma mark =====================================================  数据源
//自己更改分组数据
-(void)queryData{
    
    NSDictionary* arg = @{@"ince":@"get_shop_food_miao",@"sid":self.storeID,@"cate":@"0",@"price":@"0",@"order":@"0", @"fid":(self.goodsID==nil)?@"0":self.goodsID ,@"page":[WMHelper integerConvertToString:self.netPage.pageIndex]};
    
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    
    
    [reposiories queryGoods:arg page:self.netPage complete:^(NSInteger react, NSArray *list, NSString *message,NSArray *groupArray) {
        if(self.netPage.pageIndex == 1){
            [self.arrayData removeAllObjects];
        }
        self.tasteTabViewArr = [NSArray arrayWithArray:groupArray];

//        for (MyGroupModel *tempModel in _tasteTabViewArr) {
//            
//            NSLog(@"我的变态数组(%ld)（%@）",tempModel.saveKindArray.count,tempModel.title);
//            
//        }
        
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
                
            }];

            

        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        
        [self.tableView reloadData];
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
    
    MyGroupModel *tempModel = _tasteTabViewArr[section];
  
    return tempModel.saveKindArray.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 
    return _tasteTabViewArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsV2Cell *cell = (GoodsV2Cell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    MyGroupModel *model = _tasteTabViewArr[indexPath.section];
    
    cell.entity = model.saveKindArray[indexPath.row];
    
    return cell;
}

/*
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoods* item =  self.arrayData[indexPath.row];
    if(item.isMiaoSha){
        MBuyNow* empty = [[MBuyNow alloc]init];
        empty.rowID = item.rowID;
        empty.storeID = self.storeID;
        empty.storeStatus = item.storeStatus;
        empty.goodsName = item.goodsName;
        BuyNowInfo* controller = [[BuyNowInfo alloc]initWithItem:empty];
        controller.storeName = self.storeName;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        Goods* controller = [[Goods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat width = (SCREEN_WIDTH-4)/3;
//    CGFloat imgSize = width - 20;
//    CGFloat bottomHeight = 80;
//    CGFloat height  = 10+imgSize+5+bottomHeight;
    
    CGFloat width = SCREEN_WIDTH-collectionCellWidth;
  
    CGFloat height  = 80;
    
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f; //相邻两个 item 间距
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = nil;
    reusableView.backgroundColor = theme_dropdown_bg_color;
    if (kind == UICollectionElementKindSectionHeader) {
        MyDesignCollectionReusableView *myView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionReusableView" forIndexPath:indexPath];
      
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10 , 0,SCREEN_WIDTH - collectionCellWidth-20, 30)];
        
        NSLog(@"我的组数%ld",indexPath.section);
        
        MyGroupModel *model = _tasteTabViewArr[indexPath.section];
            
        label.text = model.title;
        
        label.backgroundColor = theme_dropdown_bg_color;
        label.textColor = theme_Color(153, 153, 153);
        label.textAlignment = NSTextAlignmentLeft;
        
        [myView addSubview:label];
        
        reusableView = myView;
    }
    
//    if (_SlideState) {
//        
//        [self slideTableview:indexPath];
//        
//    }
//    _SlideState = 1;
    
    return reusableView;
}


//- (void)slideTableview:(NSIndexPath *)indexPath {
//    
//    
//    [UIView animateWithDuration:0.1 animations:^{
//        
//
//        UILabel *lable = [self.view viewWithTag:indexPath.section+200];
//        lable.textColor = theme_navigation_color;
//        lable.backgroundColor = [UIColor whiteColor];
//        
//        UILabel *lable1 = [self.view viewWithTag:_selectedTag+200];
//        lable1.textColor = theme_Color(53, 53, 53);
//        lable1.backgroundColor = theme_table_bg_color;
//        
//        _selectedTag = (int)indexPath.section;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//
//}

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


#pragma mark ==========================================================自己更改

//自己更改添加购物车动画
- (void)FXLShoppingButton:(NSNotification *)sender {
    
    _redView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 0, 20, 20)];
    _redView.image = [UIImage imageNamed:@"adddetail"];
    _redView.tag = 12345;
    _redView.layer.cornerRadius = 10;
    
    UIButton *button = sender.userInfo[@"fxlShoppingSelectingBtn"];

    GoodsV2Cell *cell = (GoodsV2Cell *)[button superview];
    
    CGRect parentRectA = [cell convertRect:button.frame toView:self.view];
       
    CGRect parentRectB = CGRectMake(15, 392, 40, 40);
    
    /**
     *  是否执行添加的动画
     */
    [self.view addSubview:self.redView];
    [[ThrowLineTool sharedTool] throwObject:_redView from:parentRectA.origin to:parentRectB.origin];

}

/**
 *  抛物线小红点
 *
 *  @return
 */

#pragma mark - 设置购物车动画
- (void)animationDidFinish {
    
    for (UIImageView *tempView in self.view.subviews) {
        if (tempView.tag == 12345) {
            [tempView removeFromSuperview];
        }
    }
    
    for (UIView *tempView in _carView.subviews) {
        
        if (tempView.tag == 1994) {
            
            for (UIImageView *tempView2 in tempView.subviews) {
                if (tempView2.tag == 1117) {
                    
                    [UIView animateWithDuration:0.1 animations:^{
                        
                        tempView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                        
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            
                            tempView.transform = CGAffineTransformMakeScale(1, 1);
                            
                        } completion:^(BOOL finished) {
                            
                        }];
                        
                    }];
                    
                }
            }
           
        }
    }



}

//-(void)didSelectGoodPhoto:(MGoods *)item{
//    if(item.isMiaoSha){
//        MBuyNow* empty = [[MBuyNow alloc]init];
//        empty.rowID = item.rowID;
//        empty.storeID = self.storeID;
//        empty.storeStatus = item.storeStatus;
//        empty.goodsName = item.goodsName;
//        BuyNowInfo* controller = [[BuyNowInfo alloc]initWithItem:empty];
//        controller.storeName = self.storeName;
//        [self.navigationController pushViewController:controller animated:YES];
//    }else{
//        //Goods* controller = [[Goods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
//        FruitInfo* controller = [[FruitInfo alloc]initWithItem:item];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//
//}

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
        
        UICollectionViewFlowLayout *layout =  [[UICollectionViewFlowLayout alloc]init];
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH - collectionCellWidth, 30);
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = theme_dropdown_bg_color;
        [_collectionView registerClass:[GoodsV2Cell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        [_collectionView registerClass:[MyDesignCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionReusableView"];
        
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
