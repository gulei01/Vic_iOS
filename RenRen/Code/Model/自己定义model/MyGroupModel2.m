//
//  MyGroupModel2.m
//  KYRR
//
//  Created by ios on 17/6/11.
//
//

#import "MyGroupModel2.h"

@implementation MyGroupModel2


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        
        if([key isEqualToString:@"id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"title"]){
            _title = value;
        }else if ([key isEqualToString:@"sid"]){
            _sid = value;
        }
        
    }
}

@end
