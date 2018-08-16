//
//  PintuangouVC.m
//  KYRR
//
//  Created by ios on 17/5/29.
//
//

#import "PintuangouVC.h"
#import "PintuangouCVC.h"
#import "FightGroup.h"

@interface PintuangouVC ()<UICollectionViewDelegate,UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *customLayout;

@property(nonatomic,copy) NSString* cellIdentifier;
@property(nonatomic,strong) NetPage* page;
@property(nonatomic,strong) NSMutableArray* arrayData;

@end

@implementation PintuangouVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.cellIdentifier = @"PintuangouCollectionCell";
    
    [self layoutUI];
    
    [self refreshDataSource];
    
//      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFightGroupCell:) name:NotificationrefReshFightGroupCell object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryPintuangouVC:@{@"ince":@"get_pintuan_list",@"zone_id":self.Identity.location.circleID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]} page:self.page complte:^(NSInteger react, NSArray *list, NSString *message) {
        if(react == 1){
            if(self.page.pageIndex == 1)
                [self.arrayData removeAllObjects];
            [list enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        [self.collectionView reloadData];
        if(self.page.pageCount<=self.page.pageIndex || list.count<self.page.pageSize){
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
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.page.pageIndex ++;
        [weakSelf queryData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)layoutUI {

    self.navigationItem.title = @"拼团购";
    
    _customLayout = [[UICollectionViewFlowLayout alloc]init];
    
    _customLayout.minimumInteritemSpacing = 10;
    
    _customLayout.minimumLineSpacing = 10;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:_customLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[PintuangouCVC class] forCellWithReuseIdentifier:_cellIdentifier];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.arrayData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PintuangouCVC *cell=[collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = theme_table_bg_color;
    MFightGroup* item = self.arrayData[indexPath.row];
    cell.entity = item;
    cell.tag = indexPath.row;
    
    return cell;
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2, 220);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MFightGroup* item = self.arrayData[indexPath.row];
    FightGroup* controller = [[FightGroup alloc]initWithRowID:item.rowID];
    [self.navigationController pushViewController:controller animated:YES];
    

}

#pragma mark =====================================================  DZEmptyData 协议实现

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    return  [[NSMutableAttributedString alloc] initWithString:@"没有查询到相关数据" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSParagraphStyleAttributeName:paragraph}];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:kDefaultImage];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 0;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}


//#pragma mark =====================================================  Notification
//-(void)refreshFightGroupCell:(NSNotification*)notification{
//    NSIndexPath *indexPath = notification.object;
//    [_collectionView reloadData];
//}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
