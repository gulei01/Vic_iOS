//
//  RandomOrder.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/18.
//
//

#import "RandomOrder.h"
#import "RandomOrderCell.h"
#import "RandomOrderInfo.h"
#import "RandomOrderPay.h"

@interface RandomOrder ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,RandomOrderCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong) UICollectionView* collectionView;
@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) NetPage* page;

@end
static NSString* const cellIdentifier = @"RandomOrderCell";

@implementation RandomOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    
    for (NSString* format in @[ @"H:|-defEdge-[collectionView]-defEdge-|", @"V:|-defEdge-[collectionView]-defEdge-|"]) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:@{ @"defEdge":@(0)} views:@{ @"collectionView":self.collectionView}];
        [self.view addConstraints:constraints];
    }
    
    [self refreshDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderList:) name:NotificationRandomPayFinishRefreshOrder object:nil];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshOrderList:) name:NotificationRandomRefreshOrder object:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"订单列表";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    NSDictionary* arg = @{ @"ince": @"get_order_list", @"uid":self.Identity.userInfo.userID};
    
    [repositories queryRandomOrder:arg page:self.page complete:^(NSInteger react, NSArray *list, NSString *message) {
        if(self.page.pageIndex ==1){
            [self.arrayData removeAllObjects];
        }
        if(react ==1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else{
            [self alertHUD:message];
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

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page.pageIndex = 1;
        [weakSelf queryData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page.pageIndex ++;
        [weakSelf queryData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrayData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RandomOrderCell* cell = (RandomOrderCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.item = self.arrayData[indexPath.row];
    cell.delegate = self;
    return cell;
}


#pragma mark =====================================================  <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, 110);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return  0.1f;
}

#pragma mark =====================================================  <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RandomOrderInfo* controller = [[RandomOrderInfo alloc]initWithOrderID:[self.arrayData[indexPath.row] objectForKey: @"order_id"]];
    [self.navigationController pushViewController:controller animated:YES];
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

#pragma mark =====================================================  <RandomOrderCellDelegate>
-(void)fromOrderPay:(NSDictionary *)item{
    NSString* orderID = [item objectForKey: @"order_id"];
    NSString* goodsName = [item objectForKey: @"title"];
    CGFloat money = [[item objectForKey: @"total_fee"] floatValue];
    RandomOrderPay* controller = [[RandomOrderPay alloc]initWithOrderID: orderID money:money goodsName:goodsName fromOrder:YES];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [nav.navigationBar setBackgroundColor:theme_navigation_color];
    [nav.navigationBar setBarTintColor:theme_navigation_color];
    [nav.navigationBar setTintColor:theme_default_color];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark =====================================================  notification
-(void)refreshOrderList:(NSNotification*)notification{
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  property package

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout* block = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:block];
        _collectionView.backgroundColor = theme_table_bg_color;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.emptyDataSetSource = self;
        _collectionView.emptyDataSetDelegate = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[RandomOrderCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
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

@end
