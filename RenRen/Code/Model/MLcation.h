//
//  MLcation.h
//  XYRR
//
//  Created by kyjun on 15/10/17.
//
//

#import <Foundation/Foundation.h>

@interface MLcation : NSObject<NSCoding>

@property(nonatomic,copy) NSString* cityName;
@property(nonatomic,copy) NSString* areaID;
@property(nonatomic,copy) NSString* areaName;
/**
 *  对应 zone_id
 */
@property(nonatomic,copy) NSString* circleID;
@property(nonatomic,copy) NSString* circleName;
@property(nonatomic,copy) NSString* address;
@property(nonatomic,copy) NSString* mapLat;
@property(nonatomic,copy) NSString* mapLng;
@property(nonatomic,assign) BOOL isOpen;

@end
