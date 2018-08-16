//
//  MCircle.m
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import "MCircle.h"

@implementation MCircle
-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.circleID = [item objectForKey:@"zone_id"];
        self.circleName = [item objectForKey:@"name"];
        self.areaID = [item objectForKey:@"area_id"];
        self.areaName = [item objectForKey:@"area_name"];
        self.status = [item objectForKey:@"status"];
        self.latitude = [item objectForKey:@"lati"];
        self.longitude = [item objectForKey:@"longi"];
        self.location = [item objectForKey:@"location"];
        self.allowLocation = NO;         
    }
    return self;
}

-(instancetype)initWithItem:(NSDictionary *)item location:(CLLocationCoordinate2D)location{
    self = [super init];
    if(self){
        self.circleID = [item objectForKey:@"zone_id"];
        self.circleName = [item objectForKey:@"name"];
        self.areaID = [item objectForKey:@"area_id"];
        self.areaName = [item objectForKey:@"area_name"];
        self.status = [item objectForKey:@"status"];
        self.latitude = [item objectForKey:@"lati"];
        self.longitude = [item objectForKey:@"longi"];
        self.location = [item objectForKey:@"location"];
        double distince =   [self distanceBetweenOrderBy:[self.latitude doubleValue] :location.latitude :[self.longitude doubleValue] :location.longitude ];
        self.range =[[NSString stringWithFormat:@"%.2f",distince] floatValue];
        self.allowLocation = YES;
        
    }
    return self;
}

-(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
         return  distance/1000;
    
    //返回 m
    //return   distance;
    
}


-(void)calculateDistinceWithLocation:(CLLocationCoordinate2D)location{
    double distince =   [self distanceBetweenOrderBy:[self.latitude doubleValue] :location.latitude :[self.longitude doubleValue] :location.longitude ];
    self.range =[[NSString stringWithFormat:@"%.2f",distince] floatValue];
    self.allowLocation = YES;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"zone_id"]){
            _circleID = value;
        }else if ([key isEqualToString:@"name"]){
            _circleName = value;
        }else if ([key isEqualToString:@"area_id"]){
            _areaID = value;
        }else if ([key isEqualToString:@"area_name"]){
            _areaName = value;
        }else if ([key isEqualToString:@"status"]){
            _status = value;
        }else if ([key isEqualToString:@"lati"]){
            _latitude = value;
        }else if ([key isEqualToString:@"longi"]){
            _longitude = value;
        }else if ([key isEqualToString:@"location"]){
            _location = value;
        }
    }
}

@end
