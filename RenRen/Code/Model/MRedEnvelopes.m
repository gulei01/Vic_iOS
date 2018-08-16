//
//  MRedEnvelopes.m
//  KYRR
//
//  Created by kyjun on 15/11/10.
//
//

#import "MRedEnvelopes.h"

@implementation MRedEnvelopes

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowiID = [item objectForKey:@"item_id"];
        self.name = [item objectForKey:@"type_name"];
        self.type = [item objectForKey:@"type"];
        self.status = [item objectForKey:@"order_status"];
        self.beginDate = [item objectForKey: @"use_start_date"];
        self.endDate = [item objectForKey:@"use_end_date"];
        self.money = [item objectForKey:@"type_money"];
        self.limitMoney = [item objectForKey:@"limit_money"];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"item_id"]){
            _rowiID = value;
        }else if ([key isEqualToString:@"type_name"]){
            _name = value;
        }else if ([key isEqualToString:@"type"]){
            _type = value;
        }else if ([key isEqualToString:@"order_status"]){
            _status = value;
        }else if ([key isEqualToString:@"use_start_date"]){
            _beginDate = value;
        }else if ([key isEqualToString:@"use_end_date"]){
            _endDate = value;
        }else if ([key isEqualToString:@"type_money"]){
            _money = value;
        }else if ([key isEqualToString: @"limit_money"]){
            _limitMoney = value;
        }
    }
}


@end
