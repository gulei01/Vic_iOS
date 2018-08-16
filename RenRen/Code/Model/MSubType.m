//
//  MSubType.m
//  XYRR
//
//  Created by kyjun on 15/10/28.
//
//

#import "MSubType.h"

@implementation MSubType
-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"cate_id"];
        self.categoryName = [item objectForKey:@"cate_name"];
        NSInteger num=[[item objectForKey:@"num"]integerValue];
        self.goodsNum = [WMHelper integerConvertToString:num];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"cate_id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"cate_name"]){
            _categoryName = value;
        }else if([key isEqualToString:@"num"]){
            NSInteger num = [value integerValue];
            _goodsNum = [WMHelper integerConvertToString:num];
        }
    }
}

@end
