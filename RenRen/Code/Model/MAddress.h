//
//  MAddress.h
//  KYRR
//
//  Created by kyjun on 15/11/3.
//
//

#import <Foundation/Foundation.h>

@interface MAddress : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,copy) NSString* zoneID;
@property(nonatomic,copy) NSString* zoneName;
@property(nonatomic,copy) NSString* areaName;
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* phoneNum;
@property(nonatomic,copy) NSString* address;
@property(nonatomic,assign) BOOL    isDefault;
@property(nonatomic,copy) NSString* mapAddress;
@property(nonatomic,copy) NSString* mapNumber;
@property(nonatomic,copy) NSString* mapLat;
@property(nonatomic,copy) NSString* mapLng;
@property(nonatomic,copy) NSString* mapLocation;

@end
