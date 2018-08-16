//
//  Pager.m
//  XYRR
//
//  Created by kyjun on 15/10/27.
//
//

#import "Pager.h"

@implementation Pager
-(instancetype)init{
    self = [super init];
    if(self){
        _pageIndex = 1;
        _pageSize = 35;
    }
    return self;
}

-(NSMutableArray *)arrayData{
    if(_arrayData ==nil)
        _arrayData = [NSMutableArray new];
    return _arrayData;
}
@end
