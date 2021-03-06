//
//  StoreList.m
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import "StoreList.h"
#import "MStore.h"
#import "StoreListCell.h"
#import "MSubType.h"
#import "SubCategoryCell.h"
//#import "StoreGoods.h"
#import "AppDelegate.h"
#import "Store.h"
#import "StorelistHeader.h"

@interface StoreList ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray* arrayData;
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) NSLayoutConstraint* topConstraints;
@property(nonatomic,strong) NSMutableArray* arraySearch;
@property(nonatomic,strong) UISearchBar* searchBar;
@property(nonatomic,strong) UISearchDisplayController* dispalyController;

@property(nonatomic,strong) NSString* keyword;
@property(nonatomic,assign) NSInteger categoryID;

@property(nonatomic,strong) NSString*rankStore;
@property(nonatomic,strong) NSString* category_title;
@property(nonatomic,assign) NSInteger cate_id;
@property(nonatomic,strong) NetPage* page;

@property(nonatomic,strong) UIScrollView* categoryView;
@property(nonatomic,strong) NSMutableArray* categoryList;
@property(nonatomic,strong) UIBarButtonItem* leftBarItem;

@end

@implementation StoreList

-(instancetype)initWithCategory:(NSInteger)categoryID :(NSString*)title{
    self = [super init];
    if(self){
        _categoryID = categoryID;
        _category_title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.leftBarButtonItem = self.leftBarItem;
    //初始化子分类id
    self.cate_id = 0;
    self.rankStore = @"1";
    [self layoutUI];
    [self layoutConstraints];
    [self refreshDataSource];
    [self queryCategory];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    if(self.categoryID == 3)
//        self.navigationItem.title = @"美食外卖";
//    else
//        self.navigationItem.title = @"鲜花蛋糕";
    self.navigationItem.title = _category_title;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"icon-search-store"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarTouch:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  试图布局
-(void)layoutUI{
    [self.view addSubview:self.tableView];
    self.dispalyController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    
    self.dispalyController.delegate = self;
    [self.dispalyController.searchResultsTableView registerClass:[StoreListTableCell class] forCellReuseIdentifier: @"searchCell"];
    self.dispalyController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dispalyController.searchResultsDelegate = self;
    self.dispalyController.searchResultsDataSource = self;
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake( 0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
//    NSArray *ary = @[@"综合排序",@"销量排序"];
//    for (int i = 0; i < 2; i ++) {
//        UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, 0, SCREEN_WIDTH/2, 50)];
//        [btn setTitle:ary[i] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:16];
//        btn.selected = !i;
//        btn.backgroundColor = [UIColor whiteColor];
//        [btn setTitleColor:theme_title_color forState:UIControlStateNormal];
//        [btn setTitleColor:theme_navigation_color forState:UIControlStateSelected];
//        [btn setTitleColor:theme_title_color forState:UIControlStateHighlighted];
//        [btn setTitleColor:theme_navigation_color forState:UIControlStateSelected | UIControlStateHighlighted];
//        btn.tag = 100 + i;
//        [bgView addSubview:btn];
//
//        [btn addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    self.categoryView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [bgView addSubview:self.categoryView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = theme_line_color;
    [bgView addSubview:lineView];
    [self.view addSubview:bgView];
}

- (void)segmentAction:(UIButton *)btn {
    UIButton *button = [self.view viewWithTag:btn.tag>100?100:101];
    if (btn.selected == YES) {

    }else {
        btn.selected = YES;
        button.selected = NO;
        switch (btn.tag) {
            case 100:
            {
                NSLog(@"综合排序");
                self.rankStore = @"1";
                
            }
                break;
            case 101:
            {
                NSLog(@"价格排序");
                self.rankStore = @"2";
                
            }
                break;
            default:
                break;
        }

    }
    [self queryData];
    [self autoFirstCell];
}

- (void)autoFirstCell {
    //自动调整到第一行
    if(self.page.recordCount > 0)
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

-(void)layoutConstraints{
    NSArray* formats = @[@"H:|-defEdge-[tableView]-defEdge-|", @"V:|-50-[tableView]-defEdge-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0)};
    NSDictionary* views = @{ @"tableView":self.tableView};
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
    self.topConstraints = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
    [self.view addConstraint:self.topConstraints];
}

#pragma mark =====================================================  数据源
-(void)queryData{
    //NSDictionary* arg = @{@"ince":@"get_shop_by_cate",@"zoneid":self.Identity.location.circleID,@"shopcategory":[WMHelper integerConvertToString:self.categoryID],@"order":self.rankStore};
    NSDictionary* arg = @{@"a":@"getShopByCategory",@"category":[WMHelper integerConvertToString:self.categoryID],
                          @"cate_id":[WMHelper integerConvertToString:self.cate_id],
                          @"lat":self.Identity.location.mapLat,@"lng":self.Identity.location.mapLng,
                          @"page":[NSString stringWithFormat:@"%ld",(long)self.page.pageIndex]};
//,@"order":self.rankStore
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [self showHUD];
    [repositories queryStore:arg complete:^(NSInteger react, NSArray *list,NSInteger count, NSString *message) {
        if(self.page.pageIndex == 1)
            [self.arrayData removeAllObjects];
        
        self.page.recordCount = count;
        self.page.pageSize = 10;
        
        if(self.page.recordCount%self.page.pageSize == 0){
            self.page.pageCount = self.page.recordCount/self.page.pageSize;
        }else{
            self.page.pageCount = (self.page.recordCount/self.page.pageSize)+1;
        }
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
            [self hidHUD];
            
            if(self.page.pageCount<=self.page.pageIndex){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            if(self.page.pageIndex==1){
                [self.tableView.mj_header endRefreshing];
            }
        }else if(react == 400){
            [self hidHUD:message];
        }else{
            [self hidHUD:message];
        }
        
        self.tableView.tableHeaderView = self.searchBar;
        self.searchBar.hidden = YES;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)queryCategory{
    [self showHUD];
    NSDictionary* arg = @{@"a":@"getCategorySubList",@"category":[WMHelper integerConvertToString:self.categoryID]};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message){
        if(react == 1){
            [self showList:[response objectForKey:@"info"]];
            [self hidHUD];
        }else if(react == 400){
            [self hidHUD:message];
        }else{
            [self hidHUD:message];
        }
    }];
}

-(void)querySearch{
    NSDictionary* arg = @{@"ince":@"get_shop_by_cate_keyword",@"zoneid":self.Identity.location.circleID,@"shopcategory":[WMHelper integerConvertToString:self.categoryID], @"keyword":self.keyword,@"page":[NSString stringWithFormat:@"%ld",(long)self.page.pageIndex]};
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryStore:arg complete:^(NSInteger react, NSArray *list,NSInteger count, NSString *message) {
        [self.arraySearch removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arraySearch addObject:obj];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            // [self alertHUD:message];
        }
        [self.dispalyController.searchResultsTableView reloadData];
    }];
}

-(void)refreshDataSource{
    __weak typeof(self) weakSelf = (id)self;
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                weakSelf.page.pageIndex = 1;
                [weakSelf queryData];
            }else
                [weakSelf.tableView.mj_header endRefreshing];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        weakSelf.page.pageIndex ++;
        [weakSelf queryData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)showList:(NSArray*)list{
    self.categoryList = [[NSMutableArray alloc]init];
    NSInteger all_width = 0;
    NSInteger margin_left = 10;
    for(NSDictionary* cate in list){
        NSLog(@"garfunkel_log:%@---",[cate objectForKey:@"cat_name"]);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = [[cate objectForKey:@"cat_id"] integerValue];
        NSString* cat_name = [cate objectForKey:@"cat_name"];
        NSInteger name_len = [cat_name lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSInteger singe_width = 5;
        if([cat_name length] == name_len){
            singe_width = 8;
        }
        NSInteger btn_width = name_len * singe_width + 20;
        btn.frame = CGRectMake(all_width + margin_left, 0, btn_width, 50);
        
        all_width += btn_width + margin_left;
        [btn setTitle:cat_name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn addTarget:self action:@selector(selectCate:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.categoryList addObject:btn];
        [self.categoryView addSubview:btn];
    }
    self.categoryView.contentSize = CGSizeMake(all_width,50);
    [self changeBtnColor];
}

-(void)changeBtnColor{
    NSLog(@"changeBtnColor");
    for(UIButton* btn in self.categoryList){
        NSLog(@"garfunkel_log:%li",btn.tag);
        if(btn.tag == self.cate_id){
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}

-(IBAction)selectCate:(UIButton*)sender{
    if (sender.tag != self.cate_id) {
        [self autoFirstCell];
        self.page.pageIndex = 1;
        self.cate_id = sender.tag;
        [self queryData];
        [self changeBtnColor];
    }
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y<=-110){
        [self.view removeConstraint:self.topConstraints];
        self.topConstraints = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        self.topConstraints.priority = 999;
        [self.view addConstraint:self.topConstraints];
    }
    if(scrollView.contentOffset.y>44){
        [self.view removeConstraint:self.topConstraints];
        self.topConstraints = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:-44];
        self.topConstraints.priority =999;
        [self.view addConstraint:self.topConstraints];
    }
    // NSLog( @"%lf,%lf,%lf,%lf",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

#pragma mark =====================================================  <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.tableView){
        return self.arrayData.count;
    }else{
        return self.arraySearch.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableView){
        StoreListTableCell* cell = [tableView dequeueReusableCellWithIdentifier: @"StoreListTableCell" forIndexPath:indexPath];
        cell.entity = self.arrayData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        StoreListTableCell* cell = [tableView dequeueReusableCellWithIdentifier: @"searchCell" forIndexPath:indexPath];
        cell.entity = self.arraySearch[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableView){
        MStore* item = self.arrayData[indexPath.row];
        CGFloat height = 105.f+item.arrayActive.count*25+5;
        return height;
    }else{
        MStore* item = self.arraySearch[indexPath.row];
        CGFloat height = 105.f+item.arrayActive.count*25+5;
        return height;
    }
}

#pragma mark =====================================================  <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableView){
        Store* controller = [[Store alloc]initWithItem:self.arrayData[indexPath.row]];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        
        [self.dispalyController setActive:NO animated:YES];
        Store* controller = [[Store alloc]initWithItem:self.arraySearch[indexPath.row]];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
}


#pragma mark =====================================================  <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    [self.arraySearch removeAllObjects];
    self.keyword = searchText;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar                     // called when cancel button pressed
{
    
}



#pragma mark =====================================================  <UISearchDisplayDelegate>
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString {
    //NSLog( @"shouldReloadTableForSearchString");
    [self querySearch];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    //NSLog( @"shouldReloadTableForSearchScope");
    return YES;
}

#pragma mark =====================================================  SEL
-(IBAction)rightBarTouch:(id)sender{
    //[self.dispalyController setActive:YES animated:YES];
    [self.searchBar becomeFirstResponder];
}

#pragma mark =====================================================  属性封装
-(NSMutableArray *)arrayData{
    if(!_arrayData)
        _arrayData = [[NSMutableArray alloc]init];
    return _arrayData;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //_tableView.emptyDataSetSource = self;
        //_tableView.emptyDataSetDelegate = self;
        [_tableView registerClass:[StoreListTableCell class] forCellReuseIdentifier: @"StoreListTableCell"];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tableView;
}


-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.f);
        _searchBar.delegate = self;
        _searchBar.placeholder =  @"";
        UIImage* searchBarBg = [WMHelper makeImageWithColor:[UIColor whiteColor] width:0.1 height:32.f];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:[UIColor whiteColor]];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor grayColor];
        searchField.backgroundColor =theme_line_color;// [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0];
        [searchField setValue:[UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
        searchField.layer.masksToBounds = YES;
        searchField.layer.cornerRadius = 5.f;
    }
    return _searchBar;
}


-(NSMutableArray *)arraySearch{
    if(!_arraySearch){
        _arraySearch = [[NSMutableArray alloc]init];
    }
    return _arraySearch;
}

-(NetPage *)page{
    if(!_page){
        _page = [[NetPage alloc]init];
        _page.pageIndex = 1;
    }
    return _page;
}

-(UIBarButtonItem *)leftBarItem{
    if(!_leftBarItem){
        UIButton* btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(-200, 0, 44, 44);
        [btn setImage:[UIImage imageNamed: @"icon-back-white"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftBarItem =  [[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
    return _leftBarItem;
}
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
