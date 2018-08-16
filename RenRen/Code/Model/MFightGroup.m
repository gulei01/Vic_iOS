//
//  MFightGroup.m
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import "MFightGroup.h"

@implementation MFightGroup

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if(key){
        if([key isEqualToString:@"pingnum"]){
            _pingNum = value;
        }else if([key isEqualToString:@"price"]){
            _tuanPrice = value;
        }
    }
}

@end
