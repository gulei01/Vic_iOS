//
//  MSingle.m
//  XYRR
//
//  Created by kyjun on 15/10/17.
//
//

#import "MSingle.h"

@implementation MSingle
+(instancetype)shareAuhtorization{
    static dispatch_once_t onceToken;
    static MSingle* shareAuhtor;
    dispatch_once(&onceToken, ^{
        shareAuhtor = [[self alloc] init];
    });
    return shareAuhtor;
}
-(instancetype)init{
    
    if (self = [super init])
    {
    }
    return self;
}

-(MLcation *)location{
    //return [NSKeyedUnarchiver unarchiveObjectWithFile:[WMHelper archiverLocationCirclePath]]; 旧版本
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[WMHelper archiverMapLocationPath]]; //新版本 2016-08-13
}
-(MMember*)userInfo{
     return [NSKeyedUnarchiver unarchiveObjectWithFile:[WMHelper archiverPath]];
}

@end
