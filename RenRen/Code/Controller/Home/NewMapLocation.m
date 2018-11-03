//
//  NewMapLocation.m
//  RenRen
//
//  Created by Garfunkel on 2018/9/21.
//

#import "NewMapLocation.h"
#import "MapLocationAddressCell.h"
#import "MapLocationNearCell.h"
#import "MapLocationHeader.h"
#import "EmptyController.h"
#import "MapLocationCurrentCell.h"
#import <GooglePlaces/GooglePlaces.h>

@interface NewMapLocation ()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate,GMSAutocompleteResultsViewControllerDelegate>

@property(nonatomic,strong) CLLocation* currentLocation;
@property(nonatomic,strong) NSString* keyWords;
@property(nonatomic,assign) BOOL isKeyWords;

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UISearchBar* searchBar;
@property(nonatomic,strong) UISearchDisplayController* dispalyController;
@property(nonatomic,strong) UITableView* addressTableView;
@property(nonatomic,strong) NSString* sectionIdentifier;
@property(nonatomic,strong) NSString* cellIdenterSection0;
@property(nonatomic,strong) NSString* cellIdenterSection1;
@property(nonatomic,strong) NSString* cellIdenterSection2;
@property(nonatomic,strong) NSString* cellResultIdentifier;


@property(nonatomic,strong) NSMutableArray* arrayLocation;
@property(nonatomic,strong) NSMutableArray* arrayNear;
@property(nonatomic,strong) NSMutableArray* arraySearch;
@property(nonatomic,strong) NSMutableArray* arrayAddress;

@property(nonatomic,strong) MLcation* mapLocation;
@property(nonatomic,strong) MLcation* Mylocation;

@property(nonatomic,strong) UIButton *selectBtn;

@property(nonatomic,strong) GMSPlacesClient* placesClient;

@property(nonatomic,strong) GMSAutocompleteResultsViewController* resultsController;
@property(nonatomic,strong) UISearchController* searchController;

@end

@implementation NewMapLocation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _placesClient = [GMSPlacesClient sharedClient];
    _resultsController = [[GMSAutocompleteResultsViewController alloc]init];
    _resultsController.delegate = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterAddress;
    _resultsController.autocompleteFilter = filter;
    
    self.sectionIdentifier =  @"MapLocationHeader";
    self.cellIdenterSection0 =  @"MapLocationCurrentCell";
    self.cellIdenterSection1 =  @"MapLocationAddress";
    self.cellIdenterSection2 =  @"EditAddressMapCell";
    self.cellResultIdentifier =  @"EditAddressMapCell2";
    [self layoutUI];
    [self layoutConstraints];
    
    [self getAddressByGoogle];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MLcation *)Mylocation {
    if (_Mylocation == nil) {
        _Mylocation = [[MLcation alloc]init];
    }
    
    return _Mylocation;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_selectBtn removeFromSuperview];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationItem.title =  @"选择地址";
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.topView];
    //[self.topView addSubview:self.searchBar];
    [self.topView addSubview:self.searchController.searchBar];
    [self.view addSubview:self.addressTableView];
    
    self.dispalyController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.dispalyController.delegate = self;
    [self.dispalyController.searchResultsTableView registerClass:[MapLocationNearCell class] forCellReuseIdentifier:self.cellResultIdentifier];
    self.dispalyController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dispalyController.searchResultsDelegate = self;
    self.dispalyController.searchResultsDataSource = self;
    
}

-(void)layoutConstraints{
    NSArray* formats =@[ @"H:|-0-[topView]-0-|" , @"H:|-0-[addressTableView]-0-|",
                         @"V:[top][topView(==topViewHeight)][addressTableView][bottom]"
                         ];
    
    NSDictionary* metorics = @{ @"topViewHeight":@(44.f),
                                @"searchBarHeight":@(44.f)
                                };
    NSDictionary* views = @{ @"top":self.topLayoutGuide,
                             @"topView":self.topView,
                             @"addressTableView":self.addressTableView,
                             @"bottom":self.bottomLayoutGuide,
                             @"searchBar":self.searchBar
                             };
    
    for (NSString* format in formats) {
        // NSLog( @"%@",format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metorics views:views];
        [self.view addConstraints:constraints];
    }
    
}

-(void)getAddressByGoogle{
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        
        [self.arrayLocation removeAllObjects];
        GMSPlaceLikelihood* thood = [likelihoodList.likelihoods objectAtIndex:0];
        [self.arrayLocation addObject:thood.place];
        //NSLog(@"garfunkel_log:address--Name:%@",[[self.arrayLocation firstObject] objectForKey:@"name"]);
        
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
            GMSPlace* place = likelihood.place;
            [self.arrayNear addObject:place];
        }
        
        CLLocationCoordinate2D neBoundsCorner = thood.place.coordinate;
        CLLocationCoordinate2D swBoundsCorner = thood.place.coordinate;
        GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:neBoundsCorner
                                                                           coordinate:swBoundsCorner];
        self.resultsController.autocompleteBounds = bounds;
        [self queryAddress];
    }];
}

#pragma mark =====================================================  <UIAlertViewDelegate>{
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        // UIApplicationOpenSettingsURLString
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark =====================================================  <UISearchBarDelegate>
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _selectBtn.alpha = 0;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    _selectBtn.alpha = 1.0;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    self.isKeyWords = YES;
    [self.arraySearch removeAllObjects];
    self.keyWords = searchText;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar                     // called when cancel button pressed
{
    self.isKeyWords = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    _selectBtn.alpha = 0;
    
}

#pragma mark =====================================================  <UISearchDisplayDelegate>
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString {
    //NSLog( @"shouldReloadTableForSearchString");
    [self queryKeywords];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    //NSLog( @"shouldReloadTableForSearchScope");
    return YES;
}

#pragma mark =====================================================  <GMSAutocompleteViewControllerDelegate>

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
    _searchController.active = NO;
    // Do something with the selected place.
//    NSLog(@"Place name %@", place.name);
//    NSLog(@"Place address %@", place.formattedAddress);
//    NSLog(@"Place attributions %@", place.attributions.string);
    
    self.mapLocation.address = place.name;
    self.mapLocation.mapLat = [NSString stringWithFormat:@"%0.6f",place.coordinate.latitude];
    self.mapLocation.mapLng = [NSString stringWithFormat:@"%0.6f",place.coordinate.longitude];
    self.mapLocation.isOpen = YES;
    Boolean flag= [NSKeyedArchiver archiveRootObject:self.mapLocation toFile:[WMHelper archiverMapLocationPath]];
    if(flag){
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMapLocationChangePosition object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self alertHUD: @"定位失败请重试!"];
    }
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

- (void)didRequestAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark =====================================================  <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == self.addressTableView){
        if(self.arrayAddress.count>0 && self.arrayNear.count>0){
            return 3;
        }else if(self.arrayAddress.count>0 || self.arrayNear.count>0){
            return 2;
        }else{
            return 1;
        }
    }else if(tableView == self.dispalyController.searchResultsTableView){
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.addressTableView){
        if(section == 0){
            return self.arrayLocation.count;
        }else if (section == 1){
            if(self.arrayAddress.count>0){
                return self.arrayAddress.count;
            }else{
                return self.arrayNear.count;
            }
        }else if (section == 2){
            return self.arrayNear.count;
        }
        return 0;
    }else if(tableView == self.dispalyController.searchResultsTableView){
        return self.arraySearch.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.addressTableView){
        if(indexPath.section == 0){
            return 50.f;
        }else if (indexPath.section == 1){
            if(self.arrayAddress.count>0){
                return 60.f;
            }else{
                return 50.f;
            }
        }else if (indexPath.section == 2){
            return 50.f;
        }
        return 0;
    }else if(tableView == self.dispalyController.searchResultsTableView){
        return 50.f;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"garfunkel_log:tableView Refresh");
    if(tableView == self.addressTableView){
        if(indexPath.section == 0){
            MapLocationCurrentCell* cell = (MapLocationCurrentCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdenterSection0 forIndexPath:indexPath];
            GMSPlace* item = [self.arrayLocation firstObject];
            //NSLog(@"garfunkel_log:addressName:%@",item.name);
            [cell loadDataTitle:item.name];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.section == 1){
            if(self.arrayAddress.count>0){
                MapLocationAddressCell* cell = (MapLocationAddressCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdenterSection1 forIndexPath:indexPath];
                MAddress* item = self.arrayAddress[indexPath.row];
                cell.entity = item;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                MapLocationNearCell* cell = (MapLocationNearCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdenterSection2 forIndexPath:indexPath];
                GMSPlace* item = self.arrayNear[indexPath.row];
                [cell loadData:item.name subTitle:item.formattedAddress];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }else if (indexPath.section == 2){
            MapLocationNearCell* cell = (MapLocationNearCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdenterSection2 forIndexPath:indexPath];
            GMSPlace* item = self.arrayNear[indexPath.row];
            [cell loadData:item.name subTitle:item.formattedAddress];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        return nil;
    }else if(tableView == self.dispalyController.searchResultsTableView){
        MapLocationNearCell* cell = (MapLocationNearCell*)[tableView dequeueReusableCellWithIdentifier:self.cellResultIdentifier forIndexPath:indexPath];
        GMSPlace* item = self.arraySearch[indexPath.row];
        [cell loadData:item.name subTitle:item.formattedAddress];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark =====================================================  <UITableViewDelegate>
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView == self.addressTableView){
        MapLocationHeader* header = (MapLocationHeader*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:self.sectionIdentifier];
        if(section == 0){
            return [[UIView alloc]init];
        }else if (section == 1){
            if(self.arrayAddress.count>0){
                [header loadDataWithTitle: @"收货地址" imageName: @"icon-history"];
                return  header;
            }else{
                [header loadDataWithTitle: @"附近地址" imageName: @"icon-locate"];
                return  header;
            }
        }else if (section == 2){
            [header loadDataWithTitle: @"附近地址" imageName: @"icon-locate"];
            return  header;
        }
        return nil;
    }else if (tableView == self.dispalyController.searchContentsController){
        return nil;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == self.addressTableView){
        if(section == 0){
            return 10.f;
        }else if (section == 1){
            return  40.f;
        }else if (section == 2){
            return  40.f;
        }
        return 0.1f;
    }
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.addressTableView){
        if(indexPath.section == 0){
            //if(self.currentLocation && [CLLocationManager locationServicesEnabled]){
            if([CLLocationManager locationServicesEnabled]){
                GMSPlace* item = [self.arrayLocation firstObject];
                self.mapLocation.address = item.name;
            }else{
                [self.arrayLocation removeAllObjects];
                AMapPOI* item =  [[AMapPOI alloc]init];
                item.name =  @"定位失败、请在网络良好时重试!";
                [self.arrayLocation addObject:item];
                [self.addressTableView reloadData];
            }
        }else if(indexPath.section ==1){
            if(self.arrayAddress.count>0){
                MAddress* item = self.arrayAddress[indexPath.row];
                self.mapLocation.address = item.mapAddress;
//                [self uploadLocationWithLat:item.mapLat lng:item.mapLng addresID:item.rowID];
                self.mapLocation.mapLng = item.mapLng;
                self.mapLocation.mapLat = item.mapLat;
            }else{
                GMSPlace* item = self.arrayNear[indexPath.row];
                self.mapLocation.address = item.name;
                NSString* lng = [NSString stringWithFormat:@"%0.6f",item.coordinate.longitude];
                NSString* lat = [NSString stringWithFormat:@"%0.6f",item.coordinate.latitude];
                self.mapLocation.mapLng = lng;
                self.mapLocation.mapLat = lat;
//                [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",item.location.latitude] lng:[NSString stringWithFormat:@"%.6f",item.location.longitude] addresID:@""];
            }
        }else if(indexPath.section == 2){
            GMSPlace* item = self.arrayNear[indexPath.row];
            self.mapLocation.address = item.name;
            NSString* lng = [NSString stringWithFormat:@"%0.6f",item.coordinate.longitude];
            NSString* lat = [NSString stringWithFormat:@"%0.6f",item.coordinate.latitude];
            self.mapLocation.mapLng = lng;
            self.mapLocation.mapLat = lat;
            
//            [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",item.location.latitude] lng:[NSString stringWithFormat:@"%.6f",item.location.longitude] addresID:@""];
        }
    }else{
        AMapPOI* item = self.arraySearch[indexPath.row];
        //NSLog(@"garfunkel_log:address:%@",item.name);
        self.mapLocation.address = item.name;
//        [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",item.location.latitude] lng:[NSString stringWithFormat:@"%.6f",item.location.longitude] addresID:@""];
    }
    self.mapLocation.isOpen = YES;
    Boolean flag= [NSKeyedArchiver archiveRootObject:self.mapLocation toFile:[WMHelper archiverMapLocationPath]];
    if(flag){
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMapLocationChangePosition object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self alertHUD: @"定位失败请重试!"];
    }
}


#pragma mark =====================================================  DataSource
-(void)queryAddress{
    if(self.Identity.userInfo.isLogin){
        //NSDictionary* arg = @{@"ince":@"get_user_addr_lat",@"uid":self.Identity.userInfo.userID,@"is_default":@"0"};
        NSDictionary* arg = @{@"a":@"getUserAddress",@"uid":self.Identity.userInfo.userID,@"is_default":@"0"};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories queryAddress:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
            [self.arrayAddress removeAllObjects];
            if(react == 1){
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.arrayAddress addObject:obj];
                }];
            }else if(react == 400){
                AMapPOI* item =  [self.arrayLocation firstObject];
                item.name =  @"定位失败、请在网络良好时重试!";
//                [self stopLocationIng];
            }else{
                // [self alertHUD:message];
            }
            [self.addressTableView reloadData];
        }];
    }else{
//        [[AFNetworkReachabilityManager sharedManager]startMonitoring];
//        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            if(status == AFNetworkReachabilityStatusNotReachable){
//                AMapPOI* item =  [self.arrayLocation firstObject];
//                item.name =  @"定位失败、请在网络良好时重试!";
//                [self stopLocationIng];
//                [self.addressTableView reloadData];
//            }
//        }];
    }
}

//自己更改城市5
//定位城市
-(void)queryKeywords{
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterAddress;
    
    CLLocationCoordinate2D neBoundsCorner = CLLocationCoordinate2DMake([self.mapLocation.mapLat floatValue], [self.mapLocation.mapLng floatValue]);
    CLLocationCoordinate2D swBoundsCorner = CLLocationCoordinate2DMake([self.mapLocation.mapLat floatValue] + 0.05, [self.mapLocation.mapLng floatValue] + 0.05);
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:neBoundsCorner
                                                                       coordinate:swBoundsCorner];


    [_placesClient autocompleteQuery:self.keyWords bounds:bounds filter:filter callback:^(NSArray<GMSAutocompletePrediction *> * _Nullable results, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Autocomplete error %@", [error localizedDescription]);
            return;
        }
        
        for (GMSAutocompletePrediction* result in results) {
            NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
        }
    }];
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UISearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.f);
        _searchBar.delegate = self;
        _searchBar.placeholder =  @"请输入收货地址";
        UIImage* searchBarBg = [WMHelper makeImageWithColor:[UIColor whiteColor] width:0.1 height:32.f];
        [_searchBar setBackgroundImage:searchBarBg];
        [_searchBar setBackgroundColor:[UIColor whiteColor]];
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.textColor = [UIColor grayColor];
        searchField.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0];
        [searchField setValue:[UIColor colorWithRed:213/255.f green:213/255.f blue:213/255.f alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
        searchField.layer.masksToBounds = YES;
        searchField.layer.cornerRadius = 5.f;
    }
    return _searchBar;
}

-(UITableView *)addressTableView{
    if(!_addressTableView){
        _addressTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _addressTableView.delegate = self;
        _addressTableView.dataSource = self;
        [_addressTableView registerClass:[MapLocationCurrentCell class] forCellReuseIdentifier:self.cellIdenterSection0];
        [_addressTableView registerClass:[MapLocationAddressCell class] forCellReuseIdentifier:self.cellIdenterSection1];
        [_addressTableView registerClass:[MapLocationNearCell class] forCellReuseIdentifier:self.cellIdenterSection2];
        [_addressTableView registerClass:[MapLocationHeader class] forHeaderFooterViewReuseIdentifier:self.sectionIdentifier];
        _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _addressTableView.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _addressTableView;
}

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

-(NSMutableArray *)arrayAddress{
    if(!_arrayAddress){
        _arrayAddress = [[NSMutableArray alloc]init];
    }
    return _arrayAddress;
}

-(NSArray *)arrayLocation{
    if(!_arrayLocation){
        AMapPOI* item =  [[AMapPOI alloc]init];
        item.name =  @"正在定位中.....";
        _arrayLocation = [[NSMutableArray alloc]initWithObjects:item, nil];
    }
    
    return _arrayLocation;
}

-(UISearchController *)searchController{
    if(!_searchController){
        _searchController = [[UISearchController alloc]initWithSearchResultsController:_resultsController];
        _searchController.searchResultsUpdater = _resultsController;
        [_searchController.searchBar sizeToFit];
        
        _searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.f);
    }
    
    return _searchController;
}

//定位当前位置
-(MLcation *)mapLocation{
    if(!_mapLocation){
        MLcation* empty = self.Identity.location;
        self.Mylocation = empty;
        //        NSLog(@"我的location是：%@,%@",self.Mylocation.cityName,empty.areaName);
        
        //        NSLog(@"我的location是：%@,%@,***%@**",self.Identity.location.cityName,self.Identity.location.areaName,self.Identity.userInfo.userName);
        
        if(empty){
            _mapLocation = empty;
        }else{
            _mapLocation = [[MLcation alloc]init];
        }
    }
    return _mapLocation;
}

@end
