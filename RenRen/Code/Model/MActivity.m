//
//  MActivity.m
//  KYRR
//
//  Created by kuyuZJ on 16/6/24.
//
//

#import "MActivity.h"

@implementation MActivity

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:item];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"fid"]){
            _rowID = value;
        }else if ([key isEqualToString:@"name"]){
            _goodsName = value;
        }else if ([key isEqualToString:@"default_image"]){
            _thumbnails = value;
        }else if ([key isEqualToString:@"sid"]){
            _storeID = value;
        }else if ([key isEqualToString:@"site_name"]){
            _storeName = value;
        }else if ([key isEqualToString:@"market_price"]){
            _marketPrice = value;
        }else if ([key isEqualToString:@"startdate"]){
            _beginDate = value;
        }else if ([key isEqualToString:@"enddate"]){
            _endDate = value;
        }else if ([key isEqualToString:@"sales"]){
            _goodsSales = value;
        }else if ([key isEqualToString:@"stock"]){
            _goodsStock = value;
        }else if ([key isEqualToString:@"content"]){
            _goodsContent = value;
        }else if ([key isEqualToString: @"shop_status"]){
            _storeStatus = value;
        }
    }
    
}
@end
