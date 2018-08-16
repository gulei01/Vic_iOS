//
//  SpecialGoods.m
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import "SpecialGoods.h"
#import "Pager.h"
#import "MStore.h"
#import "GoodsCell.h"
#import "SpecialGoodsHeader.h"
#import "Goods.h"
#import "GoodsFooter.h"
#import "AppDelegate.h"
#import "FruitInfo.h"

@interface SpecialGoods ()<UICollectionViewDelegateFlowLayout,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,GoodsCellDelegate>

/**
 *  专题对象
 */
@property(nonatomic,strong) MAdv* entity;

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
@property(nonatomic,strong) UILabel* labelSumCount;

@property(nonatomic,strong) NSMutableArray* arrayShopCar;

@property(nonatomic,assign) float shopCarSumPrice;

//@property(nonatomic,strong) Pager* page;
@property(nonatomic,strong) NetPage* netPage;
@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,assign) CGSize headerSize;

@end

@implementation SpecialGoods

-(instancetype)initWithItem:(MAdv *)item headerSize:(CGSize)headerSize{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    if(self){
        _entity = item;
        _headerSize = headerSize;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShopCarChangeNotification:) name:NotificationShopCarChange object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoutNotification:) name:NotificationLogout object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = self.entity.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.backgroundColor = theme_table_bg_color;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsCell class]) bundle:nil] forCellWithReuseIdentifier:@"GoodsCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SpecialGoodsHeader class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpecialGoodsHeader"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsFooter class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"GoodsFooter"];
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor blackColor];
    self.bottomView.alpha=0.7f;
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
    
    self.labelSumCount = [[UILabel alloc]init];
    self.labelSumCount.layer.masksToBounds = YES;
    self.labelSumCount.layer.cornerRadius = 10;
    self.labelSumCount.backgroundColor = [UIColor redColor];
    self.labelSumCount.textColor = [UIColor whiteColor];
    self.labelSumCount.text = @"0";
    self.labelSumCount.textAlignment = NSTextAlignmentCenter;
    self.labelSumCount.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:self.labelSumCount];
}

-(void)layoutConstraints{
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumCount.translatesAutoresizingMaskIntoConstraints = NO;
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
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelSumPrice attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
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
    
    
        NSDictionary* arg = @{@"ince":@"get_zt_food",@"zoneid":self.Identity.location.circleID,@"ztid":self.entity.rowID,@"page":[WMHelper integerConvertToString:self.netPage.pageIndex]};
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    
//    未完成的任务4
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
-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.collectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.netPage.pageIndex = 1;
                [weakSelf queryData];
                [weakSelf queryShopCar];
            }else
                [weakSelf.collectionView.mj_header endRefreshing];
        }];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                //weakSelf.page.pageIndex++;
                weakSelf.netPage.pageIndex ++;
                [weakSelf queryData];
            }else
                [weakSelf.collectionView.mj_footer endRefreshing];
        }];
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
    cell.entity = self.arrayData[indexPath.row];
    cell.delegate = self;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoods* item =  self.arrayData[indexPath.row];
    //Goods* controller = [[Goods alloc]initWithGoodsID:item.rowID goodsName:item.goodsName];
    FruitInfo* controller = [[FruitInfo alloc]initWithItem:item];
    [self.navigationController pushViewController:controller animated:YES];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(indexPath.section == 0){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SpecialGoodsHeader" forIndexPath:indexPath];
            SpecialGoodsHeader* emptyHeader = (SpecialGoodsHeader*)reusableView;
            emptyHeader.photoUrl = self.entity.bigPhotoUrl;
            return reusableView;
        }
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GoodsFooter" forIndexPath:indexPath];
        return reusableView;
    }     return nil;
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

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 45.f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat height = SCREEN_WIDTH/self.headerSize.width*self.headerSize.height;
    return CGSizeMake(SCREEN_WIDTH, height);
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

#pragma mark =====================================================  SEL
-(IBAction)goShopCar:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGoClearing object:nil];
    self.tabBarController.selectedIndex=1;
}
#pragma mark =====================================================  通知
-(void)ShopCarChangeNotification:(NSNotification*)notification{
     [self.collectionView.mj_header beginRefreshing];
}
-(void)logoutNotification:(NSNotification*)notification{
    [self.collectionView.mj_header beginRefreshing];
}
#pragma mark =====================================================  属性封装
-(NetPage *)netPage{
    if(!_netPage){
        _netPage = [[NetPage alloc]init];
        _netPage.pageIndex = 1;
    }
    return _netPage;
}

-(NSMutableArray *)arrayShopCar{
    if(!_arrayShopCar)
        _arrayShopCar = [[NSMutableArray alloc]init];
    return _arrayShopCar;
}

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}


@end
