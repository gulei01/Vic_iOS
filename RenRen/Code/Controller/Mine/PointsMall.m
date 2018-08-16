//
//  PointsMall.m
//  KYRR
//
//  Created by kyjun on 16/5/9.
//
//

#import "PointsMall.h"
#import "PointsMallCell.h"
#import "PointsMallHeader.h"
#import "ExchangeRecord.h"
#import "PointRecord.h"
#import "PointGoods.h"
#import <SVWebViewController/SVWebViewController.h>

@interface PointsMall ()<PointsMallHeaderDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong) NetPage* page;
@property(nonatomic,strong) MPointIndex* entity;
@property(nonatomic,strong) NSMutableArray* arrayData;
@end

@implementation PointsMall

static NSString * const reuseIdentifier = @"PointsMallCell";
static NSString * const reuseHeaderIdentifier = @"PointsMallHeader";

-(instancetype)init{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate =self;
    [self.collectionView registerClass:[PointsMallCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[PointsMallHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:NotificationRefreshPoints object:nil];
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"积分商城";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  Data Soruce
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_jifen_index",@"uid":self.Identity.userInfo.userID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    [reposiories queryPointMallIndex:arg page:self.page complete:^(NSInteger react, id obj, NSString *message) {
        if(self.page.pageIndex == 1){
            [self.arrayData removeAllObjects];
        }
        if(react == 1){
            self.entity = (MPointIndex*)obj;
            [self.entity.arrayData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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

#pragma mark =====================================================  UICollectionView 协议实现
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.entity){
        return 1;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PointsMallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
        PointsMallHeader* header = (PointsMallHeader*)reusableView;
        header.delegate = self;
        [header loadData:self.entity.points topImg:self.entity.topImg];
        return reusableView;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MPoint* item = (MPoint*)self.arrayData[indexPath.row];
    PointGoods* controller = [[PointGoods alloc]initWithRowID:item.rowID andPoints:self.entity.points];
    [self.navigationController pushViewController: controller animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    return CGSizeMake(SCREEN_WIDTH/2-2.f, SCREEN_WIDTH/2+60);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 250.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 4.f; /// 行与行之间的间隔距离
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1.f; //相邻两个 item 间距
}

#pragma mark =====================================================  <PointsMallHeaderDelegate>
-(void)pointsRecord{
    PointRecord* controller = [[PointRecord alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)pointExchange{
    ExchangeRecord* controller = [[ExchangeRecord alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)pointsRule{
    NSURL *URL = [NSURL URLWithString:self.entity.ruleUrl];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}


#pragma mark =====================================================  <DZNEmptyDataSetSource>
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
#pragma mark =====================================================  <DZNEmptyDataSetDelegate>
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark =====================================================  Notificarion
-(void)refreshData:(NSNotification*)notification{
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark =====================================================  property package
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
