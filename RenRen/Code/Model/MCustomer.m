//
//  MCustomer.m
//  KYRR
//
//  Created by kyjun on 16/6/14.
//
//

#import "MCustomer.h"

@implementation MCustomer


-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:item];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"uid"]){
            _userID = value;
        }else if ([key isEqualToString:@"uname"]){
            _userName = value;
        }else if ([key isEqualToString:@"order_id"]){
            _orderID = value;
        }else if ([key isEqualToString:@"head"]){
            _avatar = value;
        }else if ([key isEqualToString:@"add_time"]){
            _createDate = value;
        }

    }
}

@end
