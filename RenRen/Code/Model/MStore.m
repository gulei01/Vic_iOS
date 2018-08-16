//
//  MStore.m
//  XYRR
//
//  Created by kyjun on 15/10/24.
//
//

#import "MStore.h"
#import "MGoods.h"

@implementation MStore
-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"site_id"];
        self.storeName = [item objectForKey:@"site_name"];
        self.isBest = [item objectForKey: @"is_best"];
        self.status = [item objectForKey:@"status"];
        NSArray* emptyArray = [item objectForKey:@"foods"];
        if(![WMHelper isNULLOrnil:emptyArray]){
            [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MGoods* item = [[MGoods alloc]initWithItem:obj];
                [self.arrayGoods addObject:item];
            }];
        }
    }
    return self;
}

-(instancetype)initWithList:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"site_id"];
        self.storeName = [item objectForKey:@"site_name"];
        self.isBest = [item objectForKey: @"is_best"];
        self.status = [item objectForKey:@"status"];
        self.logo = [item objectForKey:@"logo"];
        self.freeShip = [item objectForKey:@"freeship_amount"];
        self.shipFee = [item objectForKey:@"shipfee"];
        self.shipUnit = [item objectForKey:@"send"];
        self.sale = [item objectForKey:@"shop_sale"];
        self.categoryID = [item objectForKey:@"shop_category"];
        self.servicTimeBegin = [item objectForKey:@"service_time_start"];
        self.serviceTimerEnd = [item objectForKey:@"service_time_end"];
    }
    return self;
}

-(instancetype)initWithShopCar:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"site_id"];
        self.storeName = [item objectForKey:@"site_name"];
        self.status = [item objectForKey:@"shopstatus"];
        
        self.servicTimeBegin = [item objectForKey:@"service_time_start"];
        self.serviceTimerEnd = [item objectForKey:@"service_time_end"];
        NSArray* emptyArray = [item objectForKey:@"foods"];
        if(![WMHelper isNULLOrnil:emptyArray]){
            [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MGoods* item = [[MGoods alloc]initWithShopCar:obj];
                if([self.status integerValue] == 0){
                    item.shopCarSelected = NO;
                }
                [self.arrayGoods addObject:item];
            }];
        }
        
    }
    return self;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"site_id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"site_name"]){
            _storeName = value;
        }else if ([key isEqualToString:@"is_best"]){
            _isBest = value;
        }else if ([key isEqualToString:@"is_self"]){
            _isSelf = value;
        }else if ([key isEqualToString:@"score"]){
            _storeScore = value;
        }else if ([key isEqualToString:@"status"]){
            _status = value;
        }else if ([key isEqualToString:@"send"]){
            _shipUnit = value;
        }else if ([key isEqualToString:@"logo"]){
            _logo = value;
        }else if ([key isEqualToString:@"freeship_amount"]){
            _freeShip = value;
        }else if ([key isEqualToString:@"shipfee"]){
            _shipFee = value;
        }else if ([key isEqualToString:@"shop_sale"]){
            _sale = value;
        }else if ([key isEqualToString:@"shop_category"]){
            _categoryID = value;
        }else if ([key isEqualToString:@"service_time_start"]){
            _servicTimeBegin = value;
        }else if ([key isEqualToString:@"service_time_end"]){
            _serviceTimerEnd = value;
        }else if ([key isEqualToString:@"shopstatus"]){
            _status = value;
        }else if ([key isEqualToString:@"full_discount"]){
            if([WMHelper isEmptyOrNULLOrnil:value]){
                
            }else{
                [self.arrayActive addObject:@{ @"满":value}];
            }
        }else if ([key isEqualToString:@"first_discount"]){
            if([WMHelper isEmptyOrNULLOrnil:value]){
                
            }else{
                [self.arrayActive addObject:@{ @"首":value}];
            }
        }else if ([key isEqualToString:@"foods"]){
            NSArray* array = value;
            if(![WMHelper isNULLOrnil:array]){
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MGoods* empty = [[MGoods alloc]init];
                    [empty setValuesForKeysWithDictionary:obj];
                    [self.arrayGoods addObject:empty];
                }];
            }
        }
    }
}

-(NSString *)logo{
    if([WMHelper isNULLOrnil:_logo]){
        return @"";
    }
    return _logo;
}

-(NSMutableArray *)arrayActive{
    if(!_arrayActive){
        _arrayActive = [[NSMutableArray alloc]init];
    }
    return _arrayActive;
}

-(NSMutableArray *)arrayGoods{
    if(!_arrayGoods)
        _arrayGoods = [[NSMutableArray alloc]init];
    return _arrayGoods;
}

-(NSInteger)shopCarGoodsCount{
    __block NSInteger count=0;
    [self.arrayGoods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MGoods* item = (MGoods*)obj;
        count+=[item.quantity integerValue];
    }];
    return count;
}

-(float)shopCarGoodsPrice{
    __block float count=0.f;
    [self.arrayGoods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MGoods* item = (MGoods*)obj;
        count+=[item.price floatValue]*[item.quantity integerValue];
    }];
    return count;
}
@end
