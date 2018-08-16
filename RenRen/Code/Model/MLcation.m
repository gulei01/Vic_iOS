//
//  MLcation.m
//  XYRR
//
//  Created by kyjun on 15/10/17.
//
//

#import "MLcation.h"

@implementation MLcation



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.cityName = [aDecoder decodeObjectForKey:@"cityName"];
        self.areaID = [aDecoder decodeObjectForKey:@"areaID"];
        self.areaName = [aDecoder decodeObjectForKey:@"areaName"];
        self.circleID = [aDecoder decodeObjectForKey:@"circleID"];
        self.circleName = [aDecoder decodeObjectForKey:@"circleName"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.mapLat = [aDecoder decodeObjectForKey:@"mapLat"];
        self.mapLng = [aDecoder decodeObjectForKey:@"mapLng"];
        self.isOpen = [[aDecoder decodeObjectForKey:@"isOpen"] boolValue];
        return self;
    }else{
        return nil;
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeObject:self.areaID forKey:@"areaID"];
    [aCoder encodeObject:self.areaName forKey:@"areaName"];
    [aCoder encodeObject:self.circleID forKey:@"circleID"];
    [aCoder encodeObject:self.circleName forKey:@"circleName"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.mapLat forKey:@"mapLat"];
    [aCoder encodeObject:self.mapLng forKey:@"mapLng"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isOpen]forKey:@"isOpen"];
}

/**
 商圈编号 对应 zone_id

 @return NSString 商圈编号
 */
-(NSString *)circleID{
    if([WMHelper isEmptyOrNULLOrnil:_circleID]){
        return  @"";
    }
    return _circleID;
}

@end
