//
//  MCheckOrder.m
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import "MCheckOrder.h"

@implementation MCheckOrder

-(instancetype)initWithPresale:(NSDictionary *)item{
    self = [super init];
    if(self){
        _isPresale = YES;
        [self setValuesForKeysWithDictionary:item];
    }
    return self;
}

-(instancetype)initWithFightGroup:(NSDictionary *)item{
    self = [super init];
    if(self){
        _isPresale = NO;
        [self setValuesForKeysWithDictionary:item];
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"ship_fee"]){
            _shipFee = value;
        }else if([key isEqualToString:@"packing_fee"]){
            _packingFee = value;
        }else if([key isEqualToString:@"addr"]){
            
            NSDictionary* empty = value;
            if(![WMHelper isNULLOrnil:empty]){
                self.address = [[MAddress alloc]init];
                [self.address setValuesForKeysWithDictionary:empty];
            }
            
        }else if([key isEqualToString:@"info"]){
            NSDictionary* empty = value;
            if(![WMHelper isNULLOrnil:empty]){
                if(_isPresale){
                    self.presale = [[MPresale alloc]initWithItem:empty];
                }else{
                    self.fightGroup = [[MFightGroup alloc]initWithItem:empty];
                }
            }
        }else if([key isEqualToString:@"tuanid"]){
            _tuanID = value;
        }
    }
}


@end
