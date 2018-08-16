//
//  ExchangeRecord.m
//  KYRR
//
//  Created by kyjun on 16/5/10.
//
//

#import "ExchangeRecord.h"
#import "ExchangeRecordCell.h"

@interface ExchangeRecord ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong) NSString* cellIdentifier;
@property(nonatomic,strong) NetPage* page;
@property(nonatomic,strong) NSMutableArray* arrayData;


@end

@implementation ExchangeRecord

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellIdentifier = @"ExchangeRecordCell";
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    [self.tableView registerClass:[ExchangeRecordCell class] forCellReuseIdentifier:self.cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"兑换记录";    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  Data Soruce
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_jifen_order_list",@"uid":self.Identity.userInfo.userID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    [reposiories queryPointExchange:arg page:self.page complete:^(NSInteger react, NSArray *list, NSString *message) {
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
        [self.tableView reloadData];
        if(self.page.pageCount<=self.page.pageIndex){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        if(self.page.pageIndex==1){
            [self.tableView.mj_header endRefreshing];
        }
    }];
}


-(void)refreshDataSource{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page.pageIndex = 1;
        [weakSelf queryData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page.pageIndex ++;
        [weakSelf queryData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
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
    return roundf(self.tableView.frame.size.height/10.0);
}
#pragma mark =====================================================  <DZNEmptyDataSetDelegate>
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
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
