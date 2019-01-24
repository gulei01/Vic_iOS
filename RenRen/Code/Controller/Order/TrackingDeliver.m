//
//  TrackingDeliver.m
//  RenRen
//
//  Created by Garfunkel on 2019/1/10.
//

#import "TrackingDeliver.h"
#import <GoogleMaps/GoogleMaps.h>
@interface TrackingDeliver ()
@property(nonatomic,strong) NSTimer* timer;
@property(nonatomic,strong) GMSMapView* mapView;
@property(nonatomic,strong) GMSMarker* marker;
@end

@implementation TrackingDeliver

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _item.deliver_name;
    self.view.backgroundColor = theme_default_color;
    __weak id weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        //NSLog(@"block %@",weakSelf);
        [self Timered:self.timer];
    }];
    [self loadMap];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

-(void)loadMap{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.item.deliver_lat floatValue]
                                                            longitude:[self.item.deliver_lng floatValue]
                                                                 zoom:16];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    
    // Creates a marker in the center of the map.
    self.marker = [[GMSMarker alloc] init];
    self.marker.position = CLLocationCoordinate2DMake([self.item.deliver_lat floatValue], [self.item.deliver_lng floatValue]);
    self.marker.title = self.item.deliver_name;
    //    marker.snippet = @"Australia";
    self.marker.map = self.mapView;
}

- (void)Timered:(NSTimer*)timer {
    NSLog(@"timer called");
    NSDictionary* arg = @{@"a":@"getDeliverPosition",@"order_id":self.item.order_id};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message){
        if(react == 1){
            NSDictionary* deliver = [response objectForKey:@"info"];
            self.marker.position = CLLocationCoordinate2DMake([[deliver objectForKey:@"deliver_lat"] floatValue], [[deliver objectForKey:@"deliver_lng"] floatValue]);
            [self.mapView moveCamera:[GMSCameraUpdate setTarget:CLLocationCoordinate2DMake([[deliver objectForKey:@"deliver_lat"] floatValue], [[deliver objectForKey:@"deliver_lng"] floatValue])]];
            //[self hidHUD];
        }else if(react == 400){
            //[self hidHUD:message];
        }else{
            //[self hidHUD:message];
        }
    }];
}

@end
@implementation NSTimer(BlockTimer)
+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats blockTimer:(void (^)(NSTimer *))block{
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timered:) userInfo:[block copy] repeats:repeats];
    return timer;
}

+ (void)timered:(NSTimer*)timer {
    void (^block)(NSTimer *timer)  = timer.userInfo;
    block(timer);
}


@end
