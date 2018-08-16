//
//  MTuan.m
//  KYRR
//
//  Created by kyjun on 16/6/16.
//
//

#import "MTuan.h"

@implementation MTuan

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"tuan_id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"uid"]){
            _userID = value;
        }else if ([key isEqualToString:@"uname"]){
            _userName = value;
        }else if ([key isEqualToString:@"title"]){
            _title = value;
        }else if ([key isEqualToString:@"expired"]){
            _expiredDate = value;
        }else if ([key isEqualToString:@"lastnum"]){
            _lastNum = value;
        }else if ([key isEqualToString:@"successnum"]){
            _successNum = value;
        }else if ([key isEqualToString:@"head"]){
            _avatar = value;
        }else if([key isEqualToString: @"status"]){
            _tuanStatus = value;
        }
    }
}

@end



@implementation MFightGroupInfo

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"orders"]){
            NSArray* empty = value;
            if(![WMHelper isNULLOrnil:empty]){
                [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MCustomer* customer = [[MCustomer alloc]initWithItem:obj];
                    [self.arrayCustomer addObject:customer];
                }];
            }
        }else if ([key isEqualToString:@"info"]){
            NSDictionary* empty = value;
            if(![WMHelper isNULLOrnil:empty]){
                self.fightGroup = [[MFightGroup alloc]initWithItem:empty];
            }
        }else if ([key isEqualToString:@"tuans"]){ //团列表
            NSArray* empty = value;
            if(![WMHelper isNULLOrnil:empty]){
                [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MTuan* tuan = [[MTuan alloc]init];
                    [tuan setValuesForKeysWithDictionary:obj];
                    [self.arrayTuan addObject:tuan];
                }];
            }
        }else if ([key isEqualToString:@"tuan"]){ //团信息
            NSDictionary* empty = value;
            if(![WMHelper isNULLOrnil:empty]){
                self.tuanItem = [[MTuan alloc]init];
                [self.tuanItem setValuesForKeysWithDictionary:empty];
            }
        }else if ([key isEqualToString: @"help_url"]){
            _tuanInfoUrl = value;
        }else if ([key isEqualToString: @"pinwan"]){
            _tuanInfoPhoto = value;
        }
    }
}


-(NSMutableArray *)arrayTuan{
    if(!_arrayTuan){
        _arrayTuan = [[NSMutableArray alloc]init];
    }
    return _arrayTuan;
}

-(NSMutableArray *)arrayCustomer{
    if(!_arrayCustomer){
        _arrayCustomer = [[NSMutableArray alloc]init];
    }
    return _arrayCustomer;
}
@end