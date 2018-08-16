//
//  MAddress.m
//  KYRR
//
//  Created by kyjun on 15/11/3.
//
//

#import "MAddress.h"

@implementation MAddress

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"item_id"];
        self.zoneID= [item objectForKey:@"zone_id"];
        self.zoneName= [item objectForKey:@"zone_name"];
        self.areaName= [item objectForKey:@"area_name"];
        self.userName= [item objectForKey:@"uname"];
        self.phoneNum= [item objectForKey:@"phone"];
        self.address = [item objectForKey:@"address"];
        self.isDefault= [[item objectForKey:@"is_default"] boolValue];
        
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"item_id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"zone_id"]){
            _zoneID = value;
        }else if ([key isEqualToString:@"zone_name"]){
            _zoneName = value;
        }else if ([key isEqualToString:@"area_name"]){
            _areaName = value;
        }else if ([key isEqualToString:@"uname"]){
            _userName = value;
        }else if ([key isEqualToString:@"phone"]){
            _phoneNum = value;
        }else if ([key isEqualToString:@"address"]){
            _address = value;
        }else if ([key isEqualToString:@"is_default"]){
            _isDefault = [value boolValue];
        }else if ([key isEqualToString:@"map_number"]){
            _mapNumber = value;
        }else if ([key isEqualToString:@"map_addr"]){
            _mapAddress= value;
        }else if ([key isEqualToString:@"lat"]){
            _mapLat = value;
        }else if ([key isEqualToString:@"lng"]){
            _mapLng = value;
        }else if([key isEqualToString: @"map_location"]){
            _mapLocation = value;
        }
    }
}

-(NSString *)mapLng{
    if([WMHelper isEmptyOrNULLOrnil:_mapLng]){
        return  @"";
    }
    return _mapLng;
}

-(NSString *)mapLat{
    if([WMHelper isEmptyOrNULLOrnil:_mapLat]){
        return   @"";
    }
    return _mapLat;
}

-(NSString *)mapAddress{
    if([WMHelper isEmptyOrNULLOrnil:_mapAddress]){
        return _address;
    }
    return _mapAddress;
}

-(NSString *)mapNumber{
    if([WMHelper isEmptyOrNULLOrnil:_mapNumber]){
        return _address;
    }
    return _mapNumber;
}

-(NSString *)mapLocation{
    if([WMHelper isEmptyOrNULLOrnil:_mapLocation]){
        return  @"";
    }
    return _mapLocation;
}


@end
