//
//  RandomMap.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/20.
//
//

#import "RandomMap.h"

@interface RandomMap ()<MAMapViewDelegate>
@property(nonatomic,strong) MAMapView* mapView;
@property(nonatomic,strong) NSMutableArray* arrayData;
@end

@implementation RandomMap

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstLoad = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutUI];
    [self queryData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title =  @"附近的骑士";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    CGRect rect=[UIScreen mainScreen].bounds;
    self.mapView=[[MAMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    self.mapView.delegate = self;
    self.mapView.userTrackingMode=MKUserTrackingModeNone;
    self.mapView.mapType=MKMapTypeStandard;
    self.mapView.zoomLevel = 13;
      [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([self.Identity.location.mapLat floatValue], [self.Identity.location.mapLng floatValue]) animated:YES];
}

#pragma mark =====================================================  Data Source
-(void)queryData{
    NetRepositories* respositories = [[NetRepositories alloc]init];
    NSDictionary* arg = @{ @"ince": @"get_emp_list", @"lat":self.Identity.location.mapLat, @"lng":self.Identity.location.mapLng};
    [respositories randomNetConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        if(react == 1){
            NSArray* data = [response objectForKey: @"data"];
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.arrayData addObject:obj];
            }];
            [self addAnnotation];
        }else{
            [self alertHUD:message];
        }
    }];
}

#pragma mark =====================================================  private method
-(void)addAnnotation{
    for (NSDictionary* item in self.arrayData) {
        CLLocationCoordinate2D location=CLLocationCoordinate2DMake([[item objectForKey: @"lat"] floatValue],[[item objectForKey: @"lng"] floatValue]);
        MAPointAnnotation *annotation=[[MAPointAnnotation alloc]init];
        annotation.coordinate=location;
        annotation.title = [item objectForKey: @"realname"];
        [self.mapView addAnnotation:annotation];
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout               = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
       // annotationView.pinColor                     = [self.annotations indexOfObject:annotation] % 3;
        annotationView.image = [UIImage imageNamed: @"icon-delivery"];
        return annotationView;
    }
    return nil;
}

#pragma mark =====================================================  property package
-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
