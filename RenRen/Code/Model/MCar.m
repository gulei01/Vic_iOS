//
//  MCar.m
//  KYRR
//
//  Created by kyjun on 16/6/15.
//
//

#import "MCar.h"

@implementation MCar 
-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        _sumNum = [item objectForKey:@"allnum"];
        _sumMoney = [item objectForKey:@"allmoney"];
        NSDictionary* dict = [item objectForKey:@"addr"];
        if(![WMHelper isNULLOrnil:dict]){
                MAddress* empty = [[MAddress alloc] init];
                [empty setValuesForKeysWithDictionary:dict];
                [self.arrayAddress addObject:empty];             
        }
         NSArray* array = [item objectForKey:@"info"];
        if(![WMHelper isNULLOrnil:array]){
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MStore* empty = [[MStore alloc]init];
                [empty setValuesForKeysWithDictionary:obj];
                [self.arrayStore addObject:empty];
            }];
        }
    }
    return self;
}

-(NSMutableArray *)arrayAddress{
    if(!_arrayAddress){
        _arrayAddress = [[NSMutableArray alloc]init];
    }
    return _arrayAddress;
}

-(NSMutableArray *)arrayStore{
    if(!_arrayStore){
        _arrayStore = [[NSMutableArray alloc]init];
    }
    return _arrayStore;
}


@end
