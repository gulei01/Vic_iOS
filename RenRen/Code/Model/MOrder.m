//
//  MOrder.m
//  KYRR
//
//  Created by kyjun on 15/11/7.
//
//

#import "MOrder.h"

@implementation MOrder

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"order_id"];
        self.userID = [item objectForKey:@"uid"];
        self.goodsImage = [item objectForKey:@"order_image"];
        self.goodsCount = [item objectForKey:@"food_num"];
        self.goodsPrice = [item objectForKey:@"food_amount"];
        self.payType =[item objectForKey:@"paytype"];
        self.payTypeName = [item objectForKey:@"paytype_name"];
        self.storeID = [item objectForKey:@"site_id"];
        self.storeName = [item objectForKey:@"shopname"];
        self.createDate = [item objectForKey:@"add_time"];
        self.status = [item objectForKey:@"status"];
        self.statusName = [item objectForKey:@"status_name"];
        self.isComment = [item objectForKey:@"score_set"];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"order_id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"uid"]){
            _userID = value;
        }else if ([key isEqualToString:@"order_image"]){
            _goodsImage = value;
        }else if ([key isEqualToString:@"food_num"]){
            _goodsCount = value;
        }else if ([key isEqualToString:@"food_amount"]){
            _goodsPrice = value;
        }else if ([key isEqualToString:@"paytype"]){
            _payType = value;
        }else if ([key isEqualToString:@"paytype_name"]){
            _payTypeName = value;
        }else if ([key isEqualToString:@"site_id"]){
            _storeID = value;
        }else if ([key isEqualToString:@"shopname"]){
            _storeName = value;
        }else if ([key isEqualToString:@"add_time"]){
            _createDate = value;
        }else if ([key isEqualToString:@"status"]){
            _status = value;
        }else if ([key isEqualToString:@"status_name"]){
            _statusName = value;
        }else if ([key isEqualToString:@"score_set"]){
            _isComment = value;
        }else if ([key isEqualToString:@"ordertype"]){
            _orderType = value;
        }else if ([key isEqualToString:@"tuaninfo"]){
            _tuanMark = value;
        }else if ([key isEqualToString: @"tuanstatus"]){
            _tuanStatus = value;
        }else if ([key isEqualToString: @"tuan_id"]){
            _tuanID = value;
        }else if ([key isEqualToString: @"show_del"]){
            _showDel = value;
        }
    }
}

@end
