//
//  MGoods.m
//  XYRR
//
//  Created by kyjun on 15/10/24.
//
//

#import "MGoods.h"

@implementation MGoods

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"fid"];
        self.goodsName = [item objectForKey:@"name"];
        self.limitBuy = [item objectForKey:@"limit_buy"];
        self.status = [item objectForKey: @"status"];
        self.checkPrice = [item objectForKey:@"check_price"];
        self.maketPrice = [item objectForKey: @"market_price"];
        self.stock = [item objectForKey:@"stock"];
        self.price = [item objectForKey:@"price"];
        self.isBest = [item objectForKey:@"is_best"];
        self.defaultImg = [item objectForKey:@"default_image"];
        self.storeStatus = [item objectForKey:@"shopstatus"];
    }
    return self;
}
-(instancetype)initWithZTItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        
        self.rowID = [item objectForKey:@"fid"];
        self.goodsName = [item objectForKey:@"name"];
        self.limitBuy = [item objectForKey:@"limit_buy"];
        self.status = [item objectForKey: @"status"];
        self.checkPrice = [item objectForKey:@"check_price"];
        self.maketPrice = [item objectForKey: @"market_price"];
        self.stock = [item objectForKey:@"stock"];
        self.price = [item objectForKey:@"price"];
        self.isBest = [item objectForKey:@"is_best"];
        self.defaultImg = [item objectForKey:@"default_image"];
        self.storeStatus = [item objectForKey:@"shop_status"];
    }
    return self;
}

-(instancetype)initWithEntity:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"fid"];
        self.goodsName = [item objectForKey:@"name"];
        self.limitBuy = [item objectForKey:@"limit_buy"];
        self.status = [item objectForKey: @"status"];
        self.checkPrice = [item objectForKey:@"check_price"];
        self.maketPrice = [item objectForKey: @"market_price"];
        self.stock = [item objectForKey:@"stock"];
        self.price = [item objectForKey:@"price"];
        self.isBest = [item objectForKey:@"is_best"];
        self.defaultImg = [item objectForKey:@"image"];
        self.desc = [item objectForKey:@"desc"];
        self.storeName = [item objectForKey:@"site_name"];
        self.storeID = [item objectForKey:@"site_id"];
        self.categroyID = [item objectForKey:@"cate_id"];
        self.storeStatus = [item objectForKey:@"shopstatus"];
    }
    return self;
    
}

-(instancetype)initWithShopCar:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"fid"];
        self.goodsName = [item objectForKey:@"name"];
        self.limitBuy = [item objectForKey:@"limit_buy"];
        self.status = [item objectForKey: @"status"];
        self.checkPrice = [item objectForKey:@"check_price"];
        self.maketPrice = [item objectForKey: @"market_price"];
        self.stock = [item objectForKey:@"stock"];
        self.price = [item objectForKey:@"price"];
        self.isBest = [item objectForKey:@"is_best"];
        self.defaultImg = [item objectForKey:@"default_image"];
        self.categroyID = [item objectForKey:@"cate_id"];
        self.quantity = [item objectForKey:@"quantity"];
        self.shopCarSelected = YES;
    }
    return self;
}

-(instancetype)initWithClearing:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"fid"];
        self.goodsName = [item objectForKey:@"fname"];
        self.checkPrice = [item objectForKey:@"check_price"];
        self.maketPrice = [item objectForKey: @"market_price"];
        self.maketPriceSum = [item objectForKey:@"market_prices"];
        self.price = [item objectForKey:@"price"];
        self.priceSum = [item objectForKey:@"prices"];
        self.quantity = [item objectForKey:@"stock"];
    }
    return self;
    
}

-(instancetype)initWithStore:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"fid"];
        self.goodsName = [item objectForKey:@"name"];
        self.limitBuy = [item objectForKey:@"limit_buy"];
        self.status = [item objectForKey: @"status"];
        self.checkPrice = [item objectForKey:@"check_price"];
        self.maketPrice = [item objectForKey: @"market_price"];
        self.stock = [item objectForKey:@"stock"];
        self.price = [item objectForKey:@"price"];
        self.isBest = [item objectForKey:@"is_best"];
        self.defaultImg = [item objectForKey:@"default_image"];
    }
    return self;
}

-(instancetype)initWithSearch:(NSDictionary*)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"fid"];
        self.goodsName = [item objectForKey:@"name"];
        self.limitBuy = [item objectForKey:@"limit_buy"];
        self.status = [item objectForKey: @"status"];
        self.checkPrice = [item objectForKey:@"check_price"];
        self.maketPrice = [item objectForKey: @"market_price"];
        self.stock = [item objectForKey:@"stock"];
        self.price = [item objectForKey:@"price"];
        self.isBest = [item objectForKey:@"is_best"];
        self.defaultImg = [item objectForKey:@"default_image"];
        self.storeStatus = @"1";
    }
    return self;
}

-(instancetype)initWithOpenStore:(NSDictionary*)item{
    return [self initWithSearch:item];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"fid"]){
            _rowID = value;
        }else if ([key isEqualToString:@"name"]){
            _goodsName = value;
        }else if ([key isEqualToString:@"limit_buy"]){
            _limitBuy = value;
        }else if ([key isEqualToString:@"status"]){
            _status = value;
        }else if ([key isEqualToString:@"check_price"]){
            _checkPrice = value;
        }else if ([key isEqualToString:@"market_price"]){
            _maketPrice = value;
        }else if ([key isEqualToString:@"stock"]){
            _stock = value;
        }else if ([key isEqualToString:@"price"]){
            _price = value;
        }else if ([key isEqualToString:@"is_best"]){
            _isBest = value;
        }else if ([key isEqualToString:@"default_image"]){
            _defaultImg = value;
        }else if ([key isEqualToString:@"shopstatus"]){
            _storeStatus = value;
        }else if ([key isEqualToString:@"shop_status"]){
            _storeStatus = value;
        }else if ([key isEqualToString:@"image"]){
            _maxImage = value;
        }else if ([key isEqualToString:@"desc"]){
            _desc = value;
        }else if ([key isEqualToString:@"site_name"]){
            _storeName = value;
        }else if ([key isEqualToString:@"site_id"]){
            _storeID = value;
        }else if ([key isEqualToString:@"cate_id"]){
            _categroyID = value;
        }else if ([key isEqualToString:@"quantity"]){
            _quantity = value;
        }else if ([key isEqualToString:@"first_image"]){
            _fruitImage = value;
        }else if ([key isEqualToString:@"tip"]){
            _summary = value;
        }else if ([key isEqualToString:@"is_miao"]){
            NSInteger empty =[(NSNumber*)value integerValue];
            _isMiaoSha = empty==0?NO:YES;
        }else if([key isEqualToString:@"group_id"]){
            _group_id = value;
        }
    }
}


@end
