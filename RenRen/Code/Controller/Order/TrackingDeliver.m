//
//  TrackingDeliver.m
//  RenRen
//
//  Created by Garfunkel on 2019/1/10.
//

#import "TrackingDeliver.h"
#import <GoogleMaps/GoogleMaps.h>
@interface TrackingDeliver ()

@end

@implementation TrackingDeliver

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _item.deliver_name;
    self.view.backgroundColor = theme_default_color;
    
    [self loadMap];
}
-(void)loadMap{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.item.deliver_lat floatValue]
                                                            longitude:[self.item.deliver_lng floatValue]
                                                                 zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([self.item.deliver_lat floatValue], [self.item.deliver_lng floatValue]);
    marker.title = self.item.deliver_name;
    //    marker.snippet = @"Australia";
    marker.map = mapView;
}

@end
