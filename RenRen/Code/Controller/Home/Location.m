//
//  Location.m
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import "Location.h"
#import "LocationAreaCell.h"
#import "LocationCircleCell.h"
#import "LocationSection.h"
#import "LocationHeader.h"
#import "MLcation.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"



@interface Location ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,CLLocationManagerDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) CLLocationManager* locationManager;

@property(nonatomic,strong) NSArray* arraySection;
@property(nonatomic,strong) NSMutableArray* arrayCity;
@property(nonatomic,strong) NSMutableArray* arrayArea;
@property(nonatomic,strong) NSMutableArray* arrayCircle;

@property(nonatomic,assign) CLLocationCoordinate2D location;
/**
 *  是否允许定位 默认为NO 不允许定位
 */
@property(nonatomic,assign) BOOL allowLocation;

@property(nonatomic,strong) LocationHeader* headerView;

@property(nonatomic,strong) MLcation* circleLocation;

@property(nonatomic,copy) NSString* currentCity;
@property(nonatomic,copy) NSString* currentArea;
@property(nonatomic,copy) NSString* currentCircle;


@end

@implementation Location{
    NSString* address;
}

-(instancetype)init{
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择商圈";
    self.circleLocation.areaID = @"0";
    address = @"";
    self.arraySection = @[@"当前城市",@"所在区域",@"所在商圈"];
    self.allowLocation = NO;
    
    [self layoutUI];
    [self layoutConstraints];
    
    [self startLocation];
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
            if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
                [weakSelf queryArea];
                [weakSelf queryCircle];
            }else
                [weakSelf.collectionView.mj_header endRefreshing];
        }];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutUI{
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LocationAreaCell class]) bundle:nil] forCellWithReuseIdentifier:@"LocationAreaCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LocationCircleCell class]) bundle:nil] forCellWithReuseIdentifier:@"LocationCircleCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LocationSection class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LocationSection"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LocationHeader class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LocationHeader"];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)layoutConstraints{
    self.collectionView.translatesAutoresizingMaskIntoConstraints =NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
}


#pragma mark =====================================================  数据源
-(void)queryArea{
    
    NSDictionary* arg = @{@"ince":@"get_area_ince"};
    NetRepositories* reposistories = [[NetRepositories alloc]init];
    [reposistories queryArea:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayArea removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayArea addObject:obj];
            }];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        
    }];
}
-(void)queryCircle{
    
    NSDictionary* arg = @{@"ince":@"get_zone_ince",@"areaid":self.circleLocation.areaID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories queryCircle:arg complete:^(NSInteger react, NSArray *list, NSString *message) {
        [self.arrayCircle removeAllObjects];
        if(react == 1){
            [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MCircle* item =(MCircle*)obj;
                if(self.allowLocation){
                    [item calculateDistinceWithLocation:self.location];
                }
                [self.arrayCircle addObject:item];
            }];
            NSArray *sortDescriptors = nil;
            NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"status" ascending:YES];
            if(self.allowLocation){
                NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:@"range" ascending:YES];
                sortDescriptors = [NSArray arrayWithObjects:firstDescriptor,secondDescriptor, nil];
            }else{
                sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
            }
            
            self.arrayCircle =[NSMutableArray arrayWithArray:[self.arrayCircle sortedArrayUsingDescriptors:sortDescriptors]];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
            [self.collectionView reloadData];
            
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
        
    }];
}

#pragma mark =====================================================  UICollectionView 协议实现

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section==0)
        return self.arrayCity.count;
    else if (section == 1)
        return self.arrayArea.count;
    return self.arrayCircle.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section== 0){
        LocationAreaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocationAreaCell" forIndexPath:indexPath];
        [cell setCity: self.arrayCity[indexPath.row]];
        return cell;
    }else if (indexPath.section ==1 ){
        LocationAreaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocationAreaCell" forIndexPath:indexPath];
        cell.entity =self.arrayArea[indexPath.row];
        
        return cell;
    }else{
        LocationCircleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocationCircleCell" forIndexPath:indexPath];
        cell.entity = self.arrayCircle[indexPath.row];
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==1){
        for (int i=0; i<self.arrayArea.count; i++) {
            if(i!=indexPath.row) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:1];
                [self collectionView:collectionView didDeselectItemAtIndexPath:index ];
            }
        }
        LocationAreaCell* cell = (LocationAreaCell*)[self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];
        cell.selected = YES;
        MArea* item = self.arrayArea[indexPath.row];
        self.circleLocation.areaID = item.areaID;
        self.circleLocation.areaName = item.areaName;
        self.currentArea = item.areaName;
        [self queryCircle];
        
    }else if (indexPath.section == 2){
        
        MCircle* item = self.arrayCircle[indexPath.row];
        self.circleLocation.areaID = item.areaID;
        self.circleLocation.areaName = item.areaName;
        self.circleLocation.circleID  = item.circleID;
        self.circleLocation.circleName = item.circleName;
        Boolean flag= [NSKeyedArchiver archiveRootObject:self.circleLocation toFile:[WMHelper archiverLocationCirclePath]];
        if(flag){
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //NSLog(@"%@",@"归档失败!");
        }
        
    }else {
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [self collectionView:collectionView didDeselectItemAtIndexPath:index ];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if(indexPath.section ==0){
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LocationHeader" forIndexPath:indexPath];
            LocationHeader *header = (LocationHeader *) reusableView;
            self.headerView = header;
            [header setSectionWith:self.arraySection[indexPath.section] address:[WMHelper isEmptyOrNULLOrnil:address]?@"正在定位":address];
            return reusableView;
        }else{
            UICollectionReusableView  *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LocationSection" forIndexPath:indexPath];
            LocationSection *header = (LocationSection *) reusableView;
            [header setSectTitle:self.arraySection[indexPath.section]];
            return reusableView;
        }
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH-35)/4;
    if(indexPath.section == 0)
        return CGSizeMake(width, 35);
    else if (indexPath.section ==1)
        return CGSizeMake(width, 35);
    return CGSizeMake(SCREEN_WIDTH, 40);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0){
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }else if (section == 1){
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section==0)
        return CGSizeMake(SCREEN_WIDTH, 70);
    return CGSizeMake(SCREEN_WIDTH, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section ==1)
        return 5.f; /// 行与行之间的间隔距离
    return 0.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5.f; //相邻两个 item 间距
}



#pragma mark =====================================================  私有方法
-(void)startLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest; //控制定位精度,越高耗电量越大。
        _locationManager.distanceFilter = 100; //控制定位服务更新频率。单位是“米”
        [_locationManager startUpdatingLocation];
        //在ios 8.0下要授权
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            [_locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
    }else{
       // NSLog(@"=====");
    }
    
}


#pragma mark =====================================================  CLLocationManager 协议实现
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.locationManager stopUpdatingLocation];
    self.location = newLocation.coordinate;
    [self.collectionView.mj_header beginRefreshing];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *dict = [placemark addressDictionary];
            NSString* emptyCity = [dict objectForKey:@"City"];
            self.circleLocation.cityName = emptyCity;
            if(![WMHelper isNULLOrnil:emptyCity]){
                [self.arrayCity removeAllObjects];
                [self.arrayCity addObject:emptyCity];
                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            }
            id obj = [dict objectForKey:@"FormattedAddressLines"];
            if(![WMHelper isNULLOrnil:obj]){
                NSString* emptyAddress = obj[0];
                if(![WMHelper isEmptyOrNULLOrnil:emptyAddress])
                {
                    address=emptyAddress;
                }else{
                    NSString* emptyArea= [dict objectForKey:@"SubLocality"];
                    NSString* emptyStreet = [dict objectForKey:@"Street"];
                    address =[NSString stringWithFormat:@"%@%@%@",emptyCity,emptyArea,emptyStreet];
                }
                [self.headerView setSectionWith:@"当前城市" address:address];
            }
        }
    }];
}

//自己更改城市0
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            self.allowLocation = YES;
        }
            
            break;
        case kCLAuthorizationStatusDenied: //用户不允许定位则选用默认地址定位
        {
            self.allowLocation = NO;
            [self.collectionView.mj_header beginRefreshing];
            [self.arrayCity removeAllObjects];
            self.circleLocation.cityName = [[NSUserDefaults standardUserDefaults] objectForKey:SelectedCityName];
            [self.arrayCity addObject:[[NSUserDefaults standardUserDefaults] objectForKey:SelectedCityName]];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            [self.headerView setSectionWith:@"当前城市" address:[[NSUserDefaults standardUserDefaults] objectForKey:SelectedCityName]];
        }
            break;
            
        default:
        {
            
        }
            break;
    }
    
    //NSLog(@"%d",status);
}
#pragma mark =====================================================  属性封装

-(MLcation *)circleLocation{
    if(!_circleLocation)
        _circleLocation = [[MLcation alloc]init];
    return _circleLocation;
}
-(NSMutableArray *)arrayCity{
    if(!_arrayCity)
        _arrayCity = [[NSMutableArray alloc]init];
    return _arrayCity;
}

-(NSMutableArray *)arrayArea{
    if(!_arrayArea)
        _arrayArea = [[NSMutableArray alloc]init];
    return _arrayArea;
}

-(NSMutableArray *)arrayCircle{
    if(!_arrayCircle)
        _arrayCircle = [[NSMutableArray alloc]init];
    return _arrayCircle;
}


@end
