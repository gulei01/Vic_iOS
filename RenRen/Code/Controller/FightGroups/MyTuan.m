//
//  MyTuan.m
//  KYRR
//
//  Created by kuyuZJ on 16/6/29.
//
//

#import "MyTuan.h"
#import "MyTuanCell.h"
#import "MyTuanInfo.h"

@interface MyTuan ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,copy) NSString* cellIdentifier;
@property(nonatomic,strong) NetPage* page;
@property(nonatomic,strong) NSMutableArray* arrayData;

@end

@implementation MyTuan



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellIdentifier = @"MyTuanCell";
    
    [self layoutUI];
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
       self.navigationItem.title = @"我的团";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutUI{
    [self.tableView registerClass:[MyTuanCell class] forCellReuseIdentifier:self.cellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_own_tuan", @"uid":self.Identity.userInfo.userID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryMyFightGroup:arg page:self.page complte:^(NSInteger react, NSDictionary *response, NSString *message) {
        NSArray* empty = nil;
        if(react == 1){
            if(self.page.pageIndex == 1)
                [self.arrayData removeAllObjects];
            empty = [response objectForKey: @"tuans"];
            if(![WMHelper isNULLOrnil:empty])
                [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.arrayData addObject:obj];
                }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        [self.tableView reloadData];
        if(self.page.pageCount<=self.page.pageIndex || empty.count<self.page.pageSize){
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTuanCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.item =  self.arrayData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90+SCREEN_WIDTH*7/15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* item = self.arrayData[indexPath.row];
    MyTuanInfo* controller = [[MyTuanInfo alloc]initWithRowID:[item objectForKey: @"tuan_id"] orderID:[item objectForKey: @"order_id"] tuanStatus:[item objectForKey: @"status"]];
    [self.navigationController pushViewController:controller animated:YES];
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
