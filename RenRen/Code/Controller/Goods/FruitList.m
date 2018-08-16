//
//  FruitList.m
//  KYRR
//
//  Created by kuyuZJ on 16/7/20.
//
//

#import "FruitList.h"
#import "Car.h"
#import "FruitListCell.h"
#import "NetRepositories.h"
#import "FruitInfo.h"

@interface FruitList ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,GoodsCellDelegate>

@property(nonatomic,strong) UIScrollView* topView;
@property(nonatomic,strong) UILabel* labelLine;
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) UIView* carView;

@property(nonatomic,copy) NSString* cellIdentifer;

@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) NetPage* page;

@property(nonatomic,assign) CGFloat contentWidth;
@property(nonatomic,assign) NSInteger categoryID;
@property(nonatomic,strong) NSString* storeID;
@property(nonatomic,assign) NSInteger subCategoryID;
@property(nonatomic,strong) NSMutableArray* arraySubCategory;
@property(nonatomic,strong) NSMutableArray* arrayMenu;
@property(nonatomic,assign) NSInteger menuIndex;

@end

@implementation FruitList

-(instancetype)initWithCategoryID:(NSInteger)categoryID{
    self = [super init];
    if(self){
        _categoryID = categoryID;
    }
    return self;
}

-(instancetype)initWithCategoryID:(NSInteger)categoryID storeID:(NSString*)storeID{
    self = [super init];
    if(self){
        _categoryID = categoryID;
        _storeID = storeID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cellIdentifer =  @"FruitListCell";
    self.view.backgroundColor = [UIColor whiteColor];
    self.subCategoryID = 0;
    self.contentWidth = SCREEN_WIDTH;
    [self layoutUI];
    [self layoutConstraints];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self querySubCategory];
    [self refreshDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCell:) name:NotificationrefReshFruitCell object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"新鲜水果";
    self.topView.contentSize = CGSizeMake(self.contentWidth, 0.f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    Car* car = [[Car alloc]init];
    [self addChildViewController:car];
    self.carView = car.view;
    [self.view addSubview:self.carView];
}

-(void)layoutConstraints{
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.carView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.carView addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.carView addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.carView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.carView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    
    NSDictionary* arg = @{@"ince":@"get_market_fruit_food_list",@"zoneid":self.Identity.location.circleID,@"pcate":[WMHelper integerConvertToString:self.categoryID],@"cate":[WMHelper integerConvertToString:self.subCategoryID], @"sid":self.storeID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    NetRepositories* reposiories = [[NetRepositories alloc]init];
//    未完成的任务1
    [reposiories queryGoods:arg page:self.page complete:^(NSInteger react, NSArray *list, NSString *message,NSArray *groupArray) {
        if(self.page.pageIndex == 1){
            [self.arrayData removeAllObjects];
        }
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            //[self alertHUD:message];
        }
        [self.collectionView reloadData];
        if(self.page.pageCount<=self.page.pageIndex){
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
        if(self.page.pageIndex==1){
            [self.collectionView.mj_header endRefreshing];
        }
        
    }];
    
}

-(void)querySubCategory{
    NSDictionary* arg = @{@"ince":@"get_market_fruit_cate_pcate",@"zoneid":self.Identity.location.circleID,@"pcate":[WMHelper integerConvertToString:self.categoryID], @"sid":self.storeID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories querySubType:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arraySubCategory removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arraySubCategory addObject:obj];
            }];
            [self loadMenu];
        } else if(react == 400){
            [self alertHUD:message];
        }else {
            //[self alertHUD:message];
        }
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.collectionView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                [weakSelf.arrayData removeAllObjects];
                weakSelf.page.pageIndex = 1;
                [weakSelf queryData];
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

#pragma mark =====================================================  <UICollectionViewDataSource>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.arrayData.count>0)
        return 1;
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FruitListCell* cell = (FruitListCell*)[collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifer forIndexPath:indexPath];
    cell.entity = self.arrayData[indexPath.row];
    cell.delegate = self;
    cell.tag =0;
    cell.tag = indexPath.row+100;
    return cell;
}

#pragma mark =====================================================  <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FruitInfo *controller = [[FruitInfo alloc]initWithItem:self.arrayData[indexPath.row]];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoods* item = self.arrayData[indexPath.row];
    if(CGSizeEqualToSize(item.thumbnailsSize, CGSizeZero)){
        CGFloat height = 90+SCREEN_WIDTH/2;
        return  CGSizeMake(SCREEN_WIDTH, height);
    }else{
        CGFloat height = 90+item.thumbnailsSize.height;
        return  CGSizeMake(SCREEN_WIDTH, height);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
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

#pragma mark =====================================================  GoodsCell 协议实现
-(void)addToShopCar:(MGoods *)item{
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

#pragma mark =====================================================  <UIScrollView>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == self.collectionView)
        return;
    NSInteger page=scrollView.contentOffset.x / scrollView.frame.size.width;
    if (page!=self.menuIndex) {
        self.menuIndex=page;
        
        [self selectPage:self.menuIndex];
    }
}
#pragma mark =====================================================  Notification
-(void)refreshCell:(NSNotification*)notifiction{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath* indexPath = notifiction.object;
        if(indexPath.row>=100){
            NSInteger index = indexPath.row-100;
            if(index<self.arrayData.count){
                if(index<self.arrayData.count && indexPath.section == 0){
                    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
                }
            }            
        }
    });
}
#pragma mark =====================================================  SEL
- (void)menuAction:(UIButton*)button{
    if( self.collectionView.mj_header.state != MJRefreshStateIdle){
        [self.collectionView.mj_header endRefreshing];
    }
    if(self.collectionView.mj_footer.state != MJRefreshStateIdle){
        [self.collectionView.mj_footer endRefreshing];
    }
    self.menuIndex=button.tag;
    MSubType* empty = self.arraySubCategory[self.menuIndex];
    [self selectPage:button.tag];
    self.subCategoryID = [empty.rowID integerValue];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)selectPage:(NSInteger)page{
    [self.arrayMenu makeObjectsPerformSelector:@selector(setSelected:) withObject:[NSNumber numberWithBool:NO]];
    for (UIButton* item in self.arrayMenu) {
        item.selected = NO;
    }
    [self.arrayMenu[page] setSelected:YES];
    [self adjustMenuFrame];
}

#pragma mark =====================================================  private method
-(void)loadMenu{
    float x=0;
    float width=SCREEN_WIDTH/4;
    
    for (int i=0; i<self.arraySubCategory.count; i++) {
        MSubType *item = self.arraySubCategory[i];
        
        UIButton *menuButton=[[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, 40.f)];
        menuButton.backgroundColor = [UIColor whiteColor];
        NSString* str = [NSString stringWithFormat: @"%@ ",item.categoryName];
        [menuButton setTitle:str forState:UIControlStateNormal];
        menuButton.tag=i;
        [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuButton setTitleColor:theme_navigation_color forState:UIControlStateSelected];
        menuButton.titleLabel.font=[UIFont systemFontOfSize:15.f];
        [menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.topView addSubview:menuButton];
        [self.arrayMenu addObject:menuButton];
        x+=1;
        x+=width;
        self.contentWidth = x;
    }
    self.labelLine.frame = CGRectMake(0, 47, width, 3);
    [self.topView addSubview:self.labelLine];
    [self.arrayMenu[0] setSelected:YES];
    self.topView.contentSize=CGSizeMake(x, 0);
}

- (void)adjustMenuFrame{
    [UIView animateWithDuration:0.2 animations:^{
        self.labelLine.frame = CGRectMake(self.menuIndex*((SCREEN_WIDTH/4)), 47, (SCREEN_WIDTH/4), 3);
    }];
}

#pragma mark =====================================================  property package
-(UIScrollView *)topView{
    if(!_topView){
        _topView = [[UIScrollView alloc]init];
        _topView.alwaysBounceVertical = NO;
        _topView.showsHorizontalScrollIndicator=NO;
        _topView.showsVerticalScrollIndicator=NO;
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

-(UILabel *)labelLine{
    if(!_labelLine){
        _labelLine = [[UILabel alloc]init];
        _labelLine.backgroundColor = [UIColor colorWithRed:247/255.f green:155/255.f blue:21/255.f alpha:1.0];
    }
    return _labelLine;
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.backgroundColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        [_collectionView registerClass:[FruitListCell class] forCellWithReuseIdentifier:self.cellIdentifer];
    }
    return _collectionView;
}

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

-(NetPage *)page{
    if(!_page){
        _page = [[NetPage alloc]init];
        _page.pageIndex = 1;
    }
    return _page;
}

-(NSMutableArray *)arraySubCategory{
    if(!_arraySubCategory){
        _arraySubCategory = [[NSMutableArray alloc]init];
    }
    return _arraySubCategory;
}

-(NSMutableArray *)arrayMenu{
    if(!_arrayMenu){
        _arrayMenu = [[NSMutableArray alloc]init];
    }
    return _arrayMenu;
}

@end
