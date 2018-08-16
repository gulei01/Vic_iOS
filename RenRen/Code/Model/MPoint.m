//
//  MPoint.m
//  KYRR
//
//  Created by kyjun on 16/5/9.
//
//

#import "MPoint.h"

@implementation MPoint
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString: @"jid"]){
            _rowID = value;
        }else if ([key isEqualToString: @"cate"]){
            _category = value;
        }else if ([key isEqualToString: @"jifen"]){
            _points = value;
        }else if ([key isEqualToString:@"market_price"]){
            _marketPrice = value;
        }else if ([key isEqualToString:@"name"]){
            _goodsName = value;
        }else if ([key isEqualToString:@"default_image"]){
            _defaultImg = value;
        }else if ([key isEqualToString:@"tip"]){
            _subTitle = value;
        }else if ([key isEqualToString:@"addtime"]){
            _createDate = value;
        }else if ([key isEqualToString:@"uptime"]){
            _modifyDate = value;
        }else if ([key isEqualToString:@"stock"]){
            _stock = value;
        }else if ([key isEqualToString:@"keywords"]){
            _keyWords = value;
        }
    }
}


@end

@implementation MPointRecord

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString: @"item_id"]){
            _rowID = value;
        }else if ([key isEqualToString: @"credit"]){
            _points = value;
        }else if ([key isEqualToString:@"addtime"]){
            _createDate = value;
        }else if ([key isEqualToString:@"uid"]){
            _userID = value;
        }else if ([key isEqualToString:@"typename"]){
            _typeName = value;
        } 
    }
}


@end

@implementation MPointExchange
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString: @"id"]){
            _rowID = value;
        }else if ([key isEqualToString: @"jid"]){
            _goodsID = value;
        }else if ([key isEqualToString: @"jifen"]){
            _points = value;
        }else if ([key isEqualToString:@"add_time"]){
            _createDate = value;
        }else if ([key isEqualToString:@"uid"]){
            _userID = value;
        }else if ([key isEqualToString:@"uname"]){
            _userName = value;
        }else if ([key isEqualToString:@"default_image"]){
            _defaultImg = value;
        }else if ([key isEqualToString:@"jname"]){
            _goodsName = value;
        }
    }
}

@end

@implementation MPointIndex

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString: @"img"]){
            _topImg = value;
        }else if ([key isEqualToString: @"rule"]){
            _ruleUrl = value;
        }else if ([key isEqualToString: @"jifen"]){
            _points = value;
        }else if ([key isEqualToString:@"list"]){
            NSArray* empty = value;
            if(![WMHelper isNULLOrnil:empty] && [empty isKindOfClass:[NSArray class]]){
                [empty enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MPoint* item = [[MPoint alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [self.arrayData addObject:item];
                }];
            }
        }
    }
}

-(NSMutableArray *)arrayData{
    if(!_arrayData){
        _arrayData = [[NSMutableArray alloc]init];
    }
    return _arrayData;
}

@end
