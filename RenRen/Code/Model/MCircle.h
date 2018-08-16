//
//  MCircle.h
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
/**
 *  商业圈 实体模型
 */
@interface MCircle : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

-(instancetype)initWithItem:(NSDictionary*)item  location:(CLLocationCoordinate2D)location;

-(void)calculateDistinceWithLocation:(CLLocationCoordinate2D)location;

/**
 *  商业圈编号
 */
@property(nonatomic,copy) NSString* circleID;

/**
 *  商业圈名称
 */
@property(nonatomic,copy) NSString* circleName;
/**
 *  商业圈所在区域编号
 */
@property(nonatomic,copy) NSString* areaID;
/**
 *区域名称
 */
@property(nonatomic,copy) NSString* areaName;
/**
 *  当前商业圈状态 0 为未开通   1 为开通
 */
@property(nonatomic,copy) NSString* status;
/**
 *  经度
 */
@property(nonatomic,copy) NSString* longitude;
/**
 *  维度
 */
@property(nonatomic,copy) NSString* latitude;

/**
 *  经纬度 逗号分隔 第一个为经度，第二个为维度
 */
@property(nonatomic,copy) NSString* location;

@property(nonatomic,assign) BOOL allowLocation;

@property(nonatomic,assign) float range;



@end
