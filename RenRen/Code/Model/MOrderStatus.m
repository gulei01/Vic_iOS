//
//  MStoreStatus.m
//  KYRR
//
//  Created by kyjun on 16/4/18.
//
//

#import "MOrderStatus.h"

@implementation MOrderStatus

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        _status = [item objectForKey:@"status"];
        _mark = [item objectForKey:@"mark"];
        _name = [item objectForKey:@"name"];
        _createDate = [item objectForKey:@"date"];
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"status"]){
            _status = value;
        }else if ([key isEqualToString:@"mark"]){
            _mark = value;
        }else if ([key isEqualToString:@"name"]){
            _name = value;
        }else if ([key isEqualToString:@"date"]){
            _createDate = value;
        }
    }
}

@end
