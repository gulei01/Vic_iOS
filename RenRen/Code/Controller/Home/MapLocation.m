//
//  MapLocation.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/12.
//
//

#import "MapLocation.h"
#import "MapLocationAddressCell.h"
#import "MapLocationNearCell.h"
#import "MapLocationHeader.h"
#import "EmptyController.h"
#import "MapLocationCurrentCell.h"
#import "CityViewController.h"
#import <GooglePlaces/GooglePlaces.h>

@interface MapLocation ()<AMapLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate,AMapSearchDelegate>
@property(nonatomic,strong) AMapLocationManager* locationManager;
@property(nonatomic,strong) CLLocation* currentLocation;
@property(nonatomic,strong) NSString* keyWords;
@property(nonatomic,assign) BOOL isKeyWords;
@property (nonatomic, strong) AMapSearchAPI *mapSearch;

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UISearchBar* searchBar;
@property(nonatomic,strong) UISearchDisplayController* dispalyController;
@property(nonatomic,strong) UITableView* addressTableView;
@property(nonatomic,strong) NSString* sectionIdentifier;
@property(nonatomic,strong) NSString* cellIdenterSection0;
@property(nonatomic,strong) NSString* cellIdenterSection1;
@property(nonatomic,strong) NSString* cellIdenterSection2;
@property(nonatomic,strong) NSString* cellResultIdentifier;


@property(nonatomic,strong) NSArray* arrayLocation;
@property(nonatomic,strong) NSMutableArray* arrayNear;
@property(nonatomic,strong) NSMutableArray* arraySearch;
@property(nonatomic,strong) NSMutableArray* arrayAddress;

@property(nonatomic,strong) MLcation* mapLocation;
@property(nonatomic,strong) MLcation* Mylocation;

@property(nonatomic,strong) UIButton *selectBtn;

@property(nonatomic,strong) GMSPlacesClient* placesClient;
@end

@implementation MapLocation

//自己更改5
- (void)viewDidLoad {
    [super viewDidLoad];
    _placesClient = [GMSPlacesClient sharedClient];
    [self createMySelectedCity];

//
    
    // Do any additional setup after loading the view.
    
    self.sectionIdentifier =  @"MapLocationHeader";
    self.cellIdenterSection0 =  @"MapLocationCurrentCell";
    self.cellIdenterSection1 =  @"MapLocationAddress";
    self.cellIdenterSection2 =  @"EditAddressMapCell";
    self.cellResultIdentifier =  @"EditAddressMapCell2";
    [self layoutUI];
    [self layoutConstraints];
    [self startLocationing];
    [self configLocationManager];
    [self queryAddress];
    //garfunkel add
    [self getAddressByGoogle];
}

- (void)viewWillAppear:(BOOL)animated {
    if (_selectBtn) {
        [_selectBtn removeFromSuperview];
    }
    [self createMySelectedCity];
}

-(void)getAddressByGoogle{
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
            GMSPlace* place = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", place.formattedAddress);
            NSLog(@"Current Place attributions %@", place.attributions);
            NSLog(@"Current PlaceID %@", place.placeID);
        }
    }];
}

- (void)selectedMyCity {
    CityViewController *controller = [[CityViewController alloc] init];
    controller.currentCityString = @"杭州";
    controller.selectString = ^(NSString *string){
        
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:SelectedCityName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self createMySelectedCity];
        
    };
    [self presentViewController:controller animated:YES completion:nil];

    
}

- (void)createMySelectedCity {


    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _selectBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 27, 75, 30);
    _selectBtn.backgroundColor = [UIColor clearColor];
    
    NSString *str;
    if (![[NSUserDefaults standardUserDefaults]objectForKey:SelectedCityName]) {
        str = @"选择城市";
    }else {
    
        str = [[NSUserDefaults standardUserDefaults]objectForKey:SelectedCityName];
    }
    
    [_selectBtn setTitle:str forState:UIControlStateNormal];
    _selectBtn.titleLabel.textColor = [UIColor whiteColor];
    [_selectBtn addTarget:self action:@selector(selectedMyCity) forControlEvents:UIControlEventTouchUpInside];
    
    _selectBtn.tag = 1234;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_selectBtn];



}

//自己更改到此为止

//懒加载自己定义的地址
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.searchBar];
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

- (void)configLocationManager
{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[AMapLocationManager alloc] init];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        [self.locationManager setDelegate:self];
        self.locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为10s
        self.locationManager.reGeocodeTimeout = 2;
        [self.locationManager setPausesLocationUpdatesAutomatically:NO];
        [self.locationManager startUpdatingLocation];
        
    }else{
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle: @"定位服务未开启" message: @"请在系统设置中开启定位服务\n设置->隐私->定位服务->外卖郎" delegate:self cancelButtonTitle: @"设置" otherButtonTitles: @"确认",nil];
        [alert show];
        AMapPOI* item =  [self.arrayLocation firstObject];
        item.name =  @"定位服务未开启";
        [self stopLocationIng];
        [self.addressTableView reloadData];
    }
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
#pragma mark =====================================================  <AMapSearchDelegate>
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
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
            [self.dispalyController.searchResultsTableView reloadData];
        }else{
            [self.addressTableView reloadData];
        }
    });
}

#pragma mark =====================================================  <AMapLocationManagerDelegate>

- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    AMapPOI* item =  [self.arrayLocation firstObject];
    item.name =  @"定位失败、请在网络良好时重试!";
    [self stopLocationIng];
    [self.addressTableView reloadData];
    NSLog( @"%@",error);
}

//自己更改（定位自己当前城市的代码）
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            //NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            AMapPOI* item =  [self.arrayLocation firstObject];
//            item.name =  @"定位失败、请在网络良好时重试!";
//            [self stopLocationIng];
//            [self.addressTableView reloadData];
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        //NSLog(@"location:%@", location);
        
        
        if (regeocode)
        {
            AMapPOI* item =  [self.arrayLocation firstObject];
            self.currentLocation = location;
            item.name = regeocode.POIName;
            self.mapLocation.cityName = regeocode.city;
            item.location = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
            [self queryNear];
            //NSLog(@"reGeocode:%@", regeocode);
            [self stopLocationIng];
        }
    }];
    
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
    if(tableView == self.addressTableView){
        if(indexPath.section == 0){
            MapLocationCurrentCell* cell = (MapLocationCurrentCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdenterSection0 forIndexPath:indexPath];
            AMapPOI* item = [self.arrayLocation firstObject];
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
                AMapPOI* item = self.arrayNear[indexPath.row];
                [cell loadData:item.name subTitle:item.address];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }else if (indexPath.section == 2){
            MapLocationNearCell* cell = (MapLocationNearCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdenterSection2 forIndexPath:indexPath];
            AMapPOI* item = self.arrayNear[indexPath.row];
            [cell loadData:item.name subTitle:item.address];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        return nil;
    }else if(tableView == self.dispalyController.searchResultsTableView){
        MapLocationNearCell* cell = (MapLocationNearCell*)[tableView dequeueReusableCellWithIdentifier:self.cellResultIdentifier forIndexPath:indexPath];
        AMapPOI* item = self.arraySearch[indexPath.row];
        [cell loadData:item.name subTitle:item.address];
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
    }else if (tableView == self.dispalyController.searchResultsTableView){
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
            if(self.currentLocation && [CLLocationManager locationServicesEnabled]){
                AMapPOI* item = [self.arrayLocation firstObject];
                self.mapLocation.address = item.name;
                [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",item.location.latitude] lng:[NSString stringWithFormat:@"%.6f",item.location.longitude] addresID:@""];
            }else{
                [[AFNetworkReachabilityManager sharedManager]startMonitoring];
                [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                    if(status == AFNetworkReachabilityStatusNotReachable){
                        AMapPOI* item =  [self.arrayLocation firstObject];
                        item.name =  @"定位失败、请在网络良好时重试!";
                        [self.addressTableView reloadData];
                        [self hidHUD];
                        [self alertHUD: @"定位失败、请在网络良好时重试!"];
                    }else{
                        if ([CLLocationManager locationServicesEnabled]) {
                            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
                                [self.locationManager startUpdatingLocation];
                                AMapPOI* item =  [self.arrayLocation firstObject];
                                [self startLocationing];
                                item.name =  @"正在定位中.....";
                                [self.addressTableView reloadData];
                            }else{
                                
                                UIAlertView* alert = [[UIAlertView alloc]initWithTitle: @"定位服务开启" message: @"请在系统设置中开启定位服务\n设置->隐私->定位服务->外卖郎" delegate:nil cancelButtonTitle: @"知道了" otherButtonTitles:nil];
                                [alert show];
                                [self stopLocationIng];
                            }
                        }else{
                            UIAlertView* alert = [[UIAlertView alloc]initWithTitle: @"定位服务未开启" message: @"请在系统设置中开启定位服务\n设置->隐私->定位服务->外卖郎" delegate:nil cancelButtonTitle: @"知道了" otherButtonTitles:nil];
                            [alert show];
                            [self stopLocationIng];
                        }
                        
                    }
                }];
            }
        }else if(indexPath.section ==1){
            if(self.arrayAddress.count>0){
                MAddress* item = self.arrayAddress[indexPath.row];
                self.mapLocation.address = item.mapAddress;
                [self uploadLocationWithLat:item.mapLat lng:item.mapLng addresID:item.rowID];
            }else{
                AMapPOI* item = self.arrayNear[indexPath.row];
                self.mapLocation.address = item.name;
                [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",item.location.latitude] lng:[NSString stringWithFormat:@"%.6f",item.location.longitude] addresID:@""];
            }
        }else if(indexPath.section == 2){
            AMapPOI* item = self.arrayNear[indexPath.row];
            self.mapLocation.address = item.name;
            [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",item.location.latitude] lng:[NSString stringWithFormat:@"%.6f",item.location.longitude] addresID:@""];
        }
    }else{
        AMapPOI* item = self.arraySearch[indexPath.row];
        NSLog(@"garfunkel_log:address:%@",item.name);
        self.mapLocation.address = item.name;
        [self uploadLocationWithLat:[NSString stringWithFormat:@"%.6f",item.location.latitude] lng:[NSString stringWithFormat:@"%.6f",item.location.longitude] addresID:@""];
    }
}


#pragma mark =====================================================  DataSource
-(void)queryAddress{
    if(self.Identity.userInfo.isLogin){
        if(![CLLocationManager locationServicesEnabled]){
            [self stopLocationIng];
            [self showHUD];
        }
//        NSDictionary* arg = @{@"ince":@"get_user_addr_lat",@"uid":self.Identity.userInfo.userID,@"is_default":@"0"};
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
                [self stopLocationIng];
            }else{
                // [self alertHUD:message];
            }
            if(![CLLocationManager locationServicesEnabled]){
                [self stopLocationIng];
            }
            [self.addressTableView reloadData];
        }];
    }else{
        [[AFNetworkReachabilityManager sharedManager]startMonitoring];
        [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if(status == AFNetworkReachabilityStatusNotReachable){
                AMapPOI* item =  [self.arrayLocation firstObject];
                item.name =  @"定位失败、请在网络良好时重试!";
                [self stopLocationIng];
                [self.addressTableView reloadData];
            }
        }];
    }
}

//自己更改城市5
//定位城市
-(void)queryKeywords{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        request.keywords            = self.keyWords;
//        self.Identity.location.cityName
        request.city                = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedCityName];
        NSLog(@"garfunkel_log:%@",request.city);
        request.types               = @"商务住宅|学校信息|生活服务|公司企业|餐饮服务|购物服务|住宿服务|交通设施服务|娱乐场所|医院类型|银行类型|风景名胜|科教文化服务|汽车服务";
        request.requireExtension    = YES;
        request.offset              = 20;
        //  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。
        request.sortrule            = 0;
        request.cityLimit           = YES;
        request.requireSubPOIs      = YES;
        [self.mapSearch AMapPOIKeywordsSearch:request];
    }];
    
}

-(void)queryNear{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:self.currentLocation.coordinate.latitude longitude:self.currentLocation.coordinate.longitude];
    request.types               = @"商务住宅|学校信息|生活服务|公司企业|餐饮服务|购物服务|住宿服务|交通设施服务|娱乐场所|医院类型|银行类型|风景名胜|科教文化服务|汽车服务";
    request.radius              = 1000;
    request.offset              = 15;
    request.page                = 1;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    [self.mapSearch AMapPOIAroundSearch:request];
}

-(void)uploadLocationWithLat:(NSString*)lat lng:(NSString*)lng addresID:(NSString*)addressID{
    [self showHUD];
    NSDictionary* arg = @{@"ince":@"select_user_addr",@"lng":lng,@"lat":lat,@"addr":addressID};
    NSLog(@"garfunkel_log:req:%@",arg);
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            [self hidHUD];
            self.mapLocation.circleID = [response objectForKey:@"zone_id"];
            self.mapLocation.areaID = [response objectForKey:@"area_id"];
            self.mapLocation.mapLng = lng;
            self.mapLocation.mapLat = lat;
            self.mapLocation.isOpen = YES;
            
            Boolean flag= [NSKeyedArchiver archiveRootObject:self.mapLocation toFile:[WMHelper archiverMapLocationPath]];
            if(flag){
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMapLocationChangePosition object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self alertHUD: @"定位失败请重试!"];
            }
            
        }else if(react == 400){
            self.mapLocation.isOpen = NO;
            [self hidHUD:message];
        }else{
            [self hidHUD];
            self.mapLocation.isOpen = NO;
            Boolean flag= [NSKeyedArchiver archiveRootObject:self.mapLocation toFile:[WMHelper archiverMapLocationPath]];
            if(flag){
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMapLocationChangePosition object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [self alertHUD: @"定位失败请重试!"];
            }
        }
        
    }];
}

-(void)startLocationing{
    [self showHUD: @"正在定位...."];
}

-(void)stopLocationIng{
    [self hidHUD];
}

#pragma mark =====================================================  property package

-(AMapSearchAPI *)mapSearch{
    if(!_mapSearch){
        _mapSearch = [[AMapSearchAPI alloc] init];
        _mapSearch.delegate = self;
    }
    return _mapSearch;
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
        _arrayLocation = [[NSArray alloc]initWithObjects:item, nil];
    }
    
    return _arrayLocation;
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
