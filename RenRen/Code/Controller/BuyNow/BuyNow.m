//
//  BuyNow.m
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import "BuyNow.h"
#import "BuyNowSection.h"
#import "BuyNowCell.h"
#import "BuyNowInfo.h"
#import "Store.h"


@interface BuyNow ()<BuyNowCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIImageView* photo;

@property(nonatomic,copy) NSString* cellIdentifier;

@property(nonatomic,strong) NetPage* page;

@property(nonatomic,strong) NSMutableArray* arrayData;

@end

@implementation BuyNow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cellIdentifier = @"BuyNowCell";     
    [self layoutUI];
    [self refreshDataSoruce];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"秒杀活动";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutUI{
    [self.tableView registerClass:[BuyNowCell class] forCellReuseIdentifier:self.cellIdentifier];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200.f);
    self.photo.frame = CGRectMake(0, 0, SCREEN_WIDTH, 195.f);
    [self.headerView addSubview:self.photo];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [[UIView alloc]init];
}


#pragma mark =====================================================  Data Source
-(void)queryData{
    NSDictionary* arg =@{@"ince":@"get_miaosha_list",@"zone_id":self.Identity.location.circleID,@"page":[WMHelper integerConvertToString:self.page.pageIndex]};
    NetRepositories* reposistories = [[NetRepositories alloc]init];
    [reposistories queryBuyNow:arg page:self.page complete:^(NSInteger react, NSArray *list, NSString *message) {
        if(react == 1){
            if(self.page.pageIndex == 1)
                [self.arrayData removeAllObjects];
            [list enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
            [self.photo sd_setImageWithURL:[NSURL URLWithString:self.page.headerImage] placeholderImage:[UIImage imageNamed: @"default-640x300"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGSize orSize = image.size;
                CGFloat height = orSize.height/orSize.width*SCREEN_WIDTH;
                self.photo.frame =  CGRectMake(0, 0, SCREEN_WIDTH, height);
                self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height+5);
                self.tableView.tableHeaderView = self.headerView;
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        [self.tableView reloadData];
        if(self.page.pageCount<=self.page.pageIndex || list.count<self.page.pageSize){
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        if(self.page.pageIndex==1){
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

-(void)refreshDataSoruce{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page.pageIndex = 1;
        [weakSelf queryData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        weakSelf.page.pageIndex++;
        [weakSelf queryData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark =====================================================  <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyNowCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.entity = self.arrayData[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 148.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MBuyNow* item = self.arrayData[indexPath.row];
   [self pushToStore:item];
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
    return roundf(self.tableView.frame.size.height/10.0);
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

#pragma mark =====================================================  <BuyNowCellDelegate>
-(void)buyNowStore:(MBuyNow *)sender{
 [self pushToStore:sender];
}

-(void)buyNowGo:(MBuyNow *)sender{
    [self pushToStore:sender];
}

-(void)pushToStore:(MBuyNow*)item{
    MStore* store = [[MStore alloc]init];
    store.rowID = item.storeID;
    MGoods* gitem = [[MGoods alloc]init];
    gitem.rowID = item.rowID;
    Store* controller = [[Store alloc]initWithItem:store goods:gitem];
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

-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}

-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
    }
    return _photo;
}


@end
