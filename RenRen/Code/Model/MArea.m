//
//  MArea.m
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import "MArea.h"

@implementation MArea
@synthesize areaName,areaID;
-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.areaID = [item objectForKey:@"area_id"];
        self.areaName = [item objectForKey:@"name"];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"area_id"]){
            self.areaID = value;
        }else if ([key isEqualToString:@"name"]){
            self.areaName = value;
        }
    }
}
@end
