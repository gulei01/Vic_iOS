//
//  MSystemNotice.m
//  KYRR
//
//  Created by kyjun on 16/6/2.
//
//

#import "MSystemNotice.h"

@implementation MSystemNotice

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:item];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"content"]){
            _content = value;
        }else if ([key isEqualToString:@"uid"]){
            _userID = value;
        }else if ([key isEqualToString:@"start"]){
            _beginDate = value;
        }else if ([key isEqualToString:@"end"]){
            _endDate = value;
        }
    }
}

@end
