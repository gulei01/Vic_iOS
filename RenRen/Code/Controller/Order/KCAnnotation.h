//
//  KCAnnotation.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface KCAnnotation : NSObject<MKAnnotation,MAAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

#pragma mark 自定义一个图片属性在创建大头针视图时使用
@property (nonatomic,strong) UIImage *image;

@end

@interface KYAnnotation : NSObject<MAAnnotation>

@property (assign, nonatomic) CLLocationCoordinate2D coordinate; //poi的平均位置
@property (assign, nonatomic) NSInteger count;
@property (nonatomic, strong) NSMutableArray *pois;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;


- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate count:(NSInteger)count;

@end
