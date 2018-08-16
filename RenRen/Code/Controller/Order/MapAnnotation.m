//
//  MapAnnotation.m
//  KYRR
//
//  Created by kuyuZJ on 16/7/19.
//
//

#import "MapAnnotation.h"

@interface MapAnnotation ()<MKMapViewDelegate>
@property(nonatomic,strong) MKMapView* mapView;
@property(nonatomic,strong) CLLocation* fromLocation;
@property(nonatomic,strong) CLGeocoder* fromGeocoder;

@property(nonatomic,strong) MKPolyline* navigationPath;
@property(nonatomic,assign) double lng;
@property(nonatomic,assign) double lat;

@property(nonatomic,strong) MOrderStatus* entity;
@end

@implementation MapAnnotation

-(instancetype)initWith:(double)lng lat:(double)lat entity:(MOrderStatus *)entity{
    self = [super init];
    if(self){
        _lng = lng;
        _lat = lat;
        _entity = entity;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"订单位置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout

-(void)layoutUI{
    CGRect rect=[UIScreen mainScreen].bounds;
    self.mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    self.mapView.delegate=self;
    self.mapView.userTrackingMode=MKUserTrackingModeFollow;
    self.mapView.mapType=MKMapTypeStandard;
    [self addAnnotation];
    
}

#pragma mark 添加大头针

#pragma mark =====================================================  <MKMapViewDelegate>
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    // NSLog(@"la---%f, lo---%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        self.fromLocation = userLocation.location;
        MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
        [_mapView setRegion:region animated:true];
        [self goNavigation];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1=@"AnnotationKey1";
        MKAnnotationView *annotationView=[_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            annotationView.canShowCallout=true;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe"]];//定义详情左侧视图
        }
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((KCAnnotation *)annotation).image;//设置大头针视图的图片
        
        return annotationView;
    }else {
        return nil;
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 3.0;
    return  renderer;
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}

#pragma mark =====================================================  private method

-(void)refreshNavigation{
    // CLLocation* toLocation = [[CLLocation alloc] initWithLatitude:self.lat longitude:self.lng];
    [self.fromGeocoder reverseGeocodeLocation:self.fromLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count>0){
            [self.mapView removeOverlay:self.navigationPath];
            MKDirectionsRequest* request = [[MKDirectionsRequest alloc]init];
            request.source = [MKMapItem mapItemForCurrentLocation];
            CLPlacemark* pl = placemarks[0];
            CLPlacemark* pk = [[CLPlacemark alloc]initWithPlacemark:pl];
            MKPlacemark* mk = [[MKPlacemark alloc]initWithPlacemark:pk];
            request.destination = [[MKMapItem alloc]initWithPlacemark:mk];
            MKDirections* directions = [[MKDirections alloc]initWithRequest:request];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
                MKRoute* route = response.routes[0];
                self.navigationPath = route.polyline;
                [self.mapView addOverlay:self.navigationPath level:MKOverlayLevelAboveLabels];
            }];
        }
    }];
}

-(void)goNavigation{
    CLLocationCoordinate2D fromCoordinate = self.fromLocation.coordinate;
    CLLocationCoordinate2D toCoordinate   = CLLocationCoordinate2DMake(self.lat,  self.lng);
    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:fromCoordinate addressDictionary:nil];
    
    MKPlacemark *toPlacemark   = [[MKPlacemark alloc] initWithCoordinate:toCoordinate  addressDictionary:nil];
    
    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    
    MKMapItem *toItem   = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    
    
    [self findDirectionsFrom:fromItem to:toItem];
}



- (void)findDirectionsFrom:(MKMapItem *)source  to:(MKMapItem *)destination

{
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = source;
    
    request.destination = destination;
    
    request.requestsAlternateRoutes = YES;
    
    
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    
    
    [directions calculateDirectionsWithCompletionHandler: ^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
           // NSLog(@"error:%@", error);
        }
        
        else {
            MKRoute *route = response.routes[0];
            [self.mapView addOverlay:route.polyline];
        }
    }];
    
}

-(void)addAnnotation{
    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(self.lat,self.lng);
    KCAnnotation *annotation1=[[KCAnnotation alloc]init];
    
    annotation1.coordinate=location1;
    annotation1.image=[UIImage imageNamed:@"icon-express"];
    [_mapView addAnnotation:annotation1];
}

#pragma mark =====================================================  property package
-(CLGeocoder *)fromGeocoder{
    if(!_fromGeocoder){
        _fromGeocoder = [[CLGeocoder alloc]init];
    }
    return _fromGeocoder;
}
@end
