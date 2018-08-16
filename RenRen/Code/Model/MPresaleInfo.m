//
//  MPresaleInfo.m
//  KYRR
//
//  Created by kyjun on 16/6/18.
//
//

#import "MPresaleInfo.h"

@implementation MPresaleInfo

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
                self.presale = [[MPresale alloc]initWithItem:empty];
            }
        }else if ([key isEqualToString:@"shopinfo"]){
            NSDictionary* empty = value;
            if(![WMHelper isNULLOrnil:empty]){
                self.store = [[MStore alloc]init];
                [self.store setValuesForKeysWithDictionary:value];
            }
        }
    }
}



-(NSMutableArray *)arrayCustomer{
    if(!_arrayCustomer){
        _arrayCustomer = [[NSMutableArray alloc]init];
    }
    return _arrayCustomer;
}
@end
