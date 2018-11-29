//
//  StoreMap.m
//  RenRen
//
//  Created by Garfunkel on 2018/11/20.
//

#import "StoreMap.h"
#import <GoogleMaps/GoogleMaps.h>

@interface StoreMap ()

@end

@implementation StoreMap

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _store.storeName;
    self.view.backgroundColor = theme_default_color;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:Localized(@"Cancel_txt") style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
    
    [self loadMap];
}

-(void)loadMap{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.store.lat floatValue]
                                                            longitude:[self.store.lng floatValue]
                                                                 zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([self.store.lat floatValue], [self.store.lng floatValue]);
    marker.title = self.store.storeName;
//    marker.snippet = @"Australia";
    marker.map = mapView;
}

-(IBAction)cancelTouch:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setStore:(MStore *)store{
    if(store){
        _store = store;
    }
}

@end
