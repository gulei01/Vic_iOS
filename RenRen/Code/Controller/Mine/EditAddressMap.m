//
//  EditAddressMap.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/8.
//
//

#import "EditAddressMap.h"
#import "SearchAddress.h"
#import "EditAddressMapCell.h"
#import "KCAnnotation.h"

@interface EditAddressMap ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>



@property(nonatomic,strong) UIView* headerView;
@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) MAMapView *mapView;
@property(nonatomic,strong) CLLocation* currentLocation;
@property(nonatomic,strong) NSString* keyWords;
@property(nonatomic,assign) BOOL isKeyWords;
@property (nonatomic, strong) AMapSearchAPI *search;

@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,assign) NSInteger keyWordPageIndex;
@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) NSMutableArray* arrayNear;
@property(nonatomic,strong) NSMutableArray* arraySearch;
@property (nonatomic, strong) SearchAddress *resultsTableController;

@property(nonatomic,strong) NSString* cellIdentifier;

@property(nonatomic,strong) CLLocation* centerLocation;

@property(nonatomic,strong) UIImageView* iconCenter;
/**
 *  地图中心的经纬度
 */
@property(nonatomic,strong) CLLocation* mapCenter;


@end

@implementation EditAddressMap

-(instancetype)initWith:(CLLocation *)location{
    self = [super init];
    if(self){
        _centerLocation = location;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageIndex = 1;
    self.keyWordPageIndex = 1;
    self.keyWords =  @"";
    self.cellIdentifier =  @"EditAddressMapCell";
    self.isKeyWords = NO;
    [self layoutUI];
    [self layoutConstraints];
    self.firstLoad =YES;
    [self refershDataSoruce];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"编辑地址";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.searchController.searchBar];
    [self.headerView addSubview:self.mapView];
    [self.mapView addSubview:self.iconCenter];
    [self.view addSubview:self.tableView];
    self.definesPresentationContext = YES;
}

-(void)layoutConstraints{
    
    NSArray* formats = @[ @"H:|-0-[headerView]-0-|", @"H:|-0-[tableView]-0-|",
                          @"V:[topView][headerView(==headerHeight)][tableView][bottomView]",
                          @"H:|-0-[mapView]-0-|", @"V:[mapView(==height)]-0-|",
                          @"H:[iconCenter(==centerWidth)]", @"V:[iconCenter(==centerHeight)]"];
    
    NSDictionary* metorics = @{ @"headerHeight":@(SCREEN_WIDTH), @"searchHeight":@(44.f), @"height":@(SCREEN_WIDTH-54.f), @"centerWidth":@(22.f), @"centerHeight":@(30.f)};
    NSDictionary* views = @{ @"headerView":self.headerView, @"searchView":self.searchController.searchBar, @"mapView":self.mapView, @"tableView":self.tableView, @"topView":self.topLayoutGuide, @"bottomView":self.bottomLayoutGuide, @"iconCenter":self.iconCenter};
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self.view addConstraints:constraints];
    }
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.iconCenter attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.mapView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.];
    [self.mapView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.iconCenter attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.mapView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f];
    [self.mapView addConstraint:constraint];
}


#pragma mark - UISearchBarDelegate (which you use ,which you choose!!)
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar                   // return NO to not become first responder
{
    
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar                    // called when text starts editing
{
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar                       // return NO to not resign first responder
{
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar                     // called when text ends editing
{
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    self.isKeyWords = YES;
    [self.arraySearch removeAllObjects];
    self.keyWords = searchText;
    
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0) // called before text changes
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                    // called when keyboard search button pressed
{
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar                   // called when bookmark button pressed
{
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar                     // called when cancel button pressed
{
    self.isKeyWords = NO;
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) // called when search results button pressed
{
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0){
    
}

#pragma mark - UISearchControllerDelegate  (which you use ,which you choose!!)
// These methods are called when automatic presentation or dismissal occurs. They will not be called if you present or dismiss the search controller yourself.
- (void)willPresentSearchController:(UISearchController *)searchController{
    // do something before the search controller is presented
}
- (void)didPresentSearchController:(UISearchController *)searchController{
    
}
- (void)willDismissSearchController:(UISearchController *)searchController{
    
}
- (void)didDismissSearchController:(UISearchController *)searchController{
    
}

// Called after the search controller's search bar has agreed to begin editing or when 'active' is set to YES. If you choose not to present the controller yourself or do not implement this method, a default presentation is performed on your behalf.
- (void)presentSearchController:(UISearchController *)searchController{
    
}
#pragma mark - UISearchResultsUpdating  (which you use ,which you choose!!)
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // update the filtered array based on the search text
    
    [self queryKeyWorkds];
}


#pragma mark =====================================================  <MAMapViewDelegate>
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if(self.firstLoad){
        self.firstLoad = NO;
        self.currentLocation = userLocation.location;
        if(self.centerLocation){
            [mapView setCenterCoordinate:self.centerLocation.coordinate animated:YES];
            KCAnnotation *annotation1=[[KCAnnotation alloc]init];
            annotation1.coordinate=self.centerLocation.coordinate;
            annotation1.image=[UIImage imageNamed:@"icon_pin_floating"];
            [mapView addAnnotation:annotation1];
        }
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    if(wasUserAction){
        [self.arrayNear removeAllObjects];
        CLLocationCoordinate2D empty = [mapView convertPoint:self.mapView.center toCoordinateFromView:self.mapView];
        self.mapCenter = [[CLLocation alloc]initWithLatitude:empty.latitude longitude:empty.longitude];
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark =====================================================  <AMapSearchDelegate>
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        [self.arraySearch removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.isKeyWords){
                self.resultsTableController.arrayResult = self.arraySearch;
                [self.resultsTableController.tableView reloadData];
            }else{
                [self.tableView reloadData];
                if(self.pageIndex == 1){
                    [self.tableView.mj_header endRefreshing];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
                if(response.pois.count<20){
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        });
        
        return;
    }
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        if(self.isKeyWords){
            [self.arraySearch addObject:obj];
        }else{
            [self.arrayNear addObject:obj];
        }
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.isKeyWords){
            self.resultsTableController.arrayResult = self.arraySearch;
            [self.resultsTableController.tableView reloadData];
        }else{
            [self.tableView reloadData];
            if(self.pageIndex == 1){
                [self.tableView.mj_header endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            if(response.pois.count<20){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
    });
}

#pragma mark =====================================================  <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayNear.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditAddressMapCell* cell = (EditAddressMapCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    AMapPOI* item = self.arrayNear[indexPath.row];
    [cell loadData:item.name subTitle:item.address];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark =====================================================  <UITableViewDelegate>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapPOI* item;
    if(tableView == self.resultsTableController.tableView){
        item = self.arraySearch[indexPath.row];
    }else{
        item = self.arrayNear[indexPath.row];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationSelecteMapAddress object:item];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark =====================================================  range
-(void)queryAround{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    if(self.centerLocation){
        if(self.mapCenter){
            request.location            = [AMapGeoPoint locationWithLatitude:self.mapCenter.coordinate.latitude longitude:self.mapCenter.coordinate.longitude];
        }else{
            request.location            = [AMapGeoPoint locationWithLatitude:self.centerLocation.coordinate.latitude longitude:self.centerLocation.coordinate.longitude];
        }
    }else{
        if(self.mapCenter){
            request.location            = [AMapGeoPoint locationWithLatitude:self.mapCenter.coordinate.latitude longitude:self.mapCenter.coordinate.longitude];
        }else{
            request.location            = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
        }
    }
    request.types               = @"商务住宅|学校信息|生活服务|公司企业|餐饮服务|购物服务|住宿服务|交通设施服务|娱乐场所|医院类型|银行类型|风景名胜|科教文化服务|汽车服务";
    request.radius              = 1000;
    request.offset              = 20;
    request.page                = self.pageIndex;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.search AMapPOIAroundSearch:request];
}

//自己更改城市3

-(void)queryKeyWorkds{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = self.keyWords;
    request.city                = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedCityName];
    request.types               = @"商务住宅|学校信息|生活服务|公司企业|餐饮服务|购物服务|住宿服务|交通设施服务|娱乐场所|医院类型|银行类型|风景名胜|科教文化服务|汽车服务";
    request.requireExtension    = YES;
    request.offset              = 20;
    
    //  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。
    request.sortrule            = 0;
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [self.search AMapPOIKeywordsSearch:request];
}

-(void)refershDataSoruce{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex =1;
        [weakSelf queryAround];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf queryAround];
    }];
}

#pragma mark =====================================================  property package
-(NSMutableArray *)arrayNear{
    if(!_arrayNear){
        _arrayNear = [[NSMutableArray alloc]init];
    }
    return _arrayNear;
}

-(NSMutableArray *)arraySearch{
    if(!_arraySearch){
        _arraySearch = [[NSMutableArray alloc]init];
    }
    return _arraySearch;
}

-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _headerView;
}

-(UISearchController *)searchController{
    if(!_searchController){
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.placeholder =  @"小区/大厦/学校等";
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = NO; // default is YES
        _searchController.searchBar.delegate = self; // so we can monitor text changes + others
    }
    return _searchController;
}


-(SearchAddress *)resultsTableController{
    if(!_resultsTableController){
        _resultsTableController = [[SearchAddress alloc]init];
        _resultsTableController.tableView.delegate = self;
    }
    return _resultsTableController;
}

-(MAMapView *)mapView{
    if(!_mapView){
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH-44.f)];
        _mapView.translatesAutoresizingMaskIntoConstraints = NO;
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapView setZoomLevel:18.5];
    }
    return _mapView;
}

-(UIImageView *)iconCenter{
    if(!_iconCenter){
        _iconCenter = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon_pin_floating"]];
        _iconCenter.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconCenter;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50.f;
        [_tableView registerClass:[EditAddressMapCell class] forCellReuseIdentifier:self.cellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(AMapSearchAPI *)search{
    if(!_search){
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}



@end
