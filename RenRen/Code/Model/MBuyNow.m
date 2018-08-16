//
//  MBuyNow.m
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import "MBuyNow.h"

@implementation MBuyNow

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if(key){
        if([key isEqualToString:@"price"]){
            _buyNowPrice = value;
        }
    }
}

@end
