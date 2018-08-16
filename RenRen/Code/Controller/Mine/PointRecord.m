//
//  PointRecord.m
//  KYRR
//
//  Created by kyjun on 16/5/10.
//
//

#import "PointRecord.h"
#import "PointRecordCell.h"

@interface PointRecord ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UILabel* labelMark;
@property(nonatomic,strong) UILabel* labelPoint;
@property(nonatomic,strong) UILabel* labelDate;
@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) NSString* cellIdentifier;
@property(nonatomic,strong) NetPage* page;
@property(nonatomic,strong) NSMutableArray* arrayData;

@end

@implementation PointRecord
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellIdentifier = @"PointRecordCell";
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"积分记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutUI{
    
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.labelMark];
    [self.topView addSubview:self.labelPoint];
    [self.topView addSubview:self.labelDate];
    [self.view addSubview:self.tableView];
}

-(void)layoutConstraints{
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPoint.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelMark addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/5]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelPoint addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/5]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelMark attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/5]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDate attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelPoint attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    
    [self.tableView addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  Data Soruce
-(void)queryData{
    NSDictionary* arg = @{@"ince":@"get_user_credit_list",@"uid":self.Identity.userInfo.userID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    NetRepositories* reposiories = [[NetRepositories alloc]init];
    [reposiories queryPointRecord:arg page:self.page complete:^(NSInteger react, NSArray *list, NSString *message) {
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
    PointRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.entity = self.arrayData[indexPath.row];
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
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
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor colorWithRed:248/255.f green:249/255.f blue:251/255.f alpha:1.0];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 49.f, SCREEN_WIDTH, 1.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_topView.layer addSublayer:border];
    }
    return _topView;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.textColor = [UIColor colorWithRed:41/255.f green:41/255.f blue:41/255.f alpha:1.0];
        _labelMark.text =  @"详情";
        _labelMark.textAlignment = NSTextAlignmentCenter;
        _labelMark.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelMark;
}

-(UILabel *)labelPoint{
    if(!_labelPoint){
        _labelPoint = [[UILabel alloc]init];
        _labelPoint.textColor = [UIColor colorWithRed:41/255.f green:41/255.f blue:41/255.f alpha:1.0];
        _labelPoint.text =  @"积分";
        _labelPoint.textAlignment = NSTextAlignmentCenter;
        _labelPoint.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelPoint;
}

-(UILabel *)labelDate{
    if(!_labelDate){
        _labelDate = [[UILabel alloc]init];
        _labelDate.textColor = [UIColor colorWithRed:41/255.f green:41/255.f blue:41/255.f alpha:1.0];
        _labelDate.text =  @"日期";
        _labelDate.textAlignment = NSTextAlignmentCenter;
        _labelDate.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelDate;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PointRecordCell class] forCellReuseIdentifier:self.cellIdentifier];
    }
    return _tableView;
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
