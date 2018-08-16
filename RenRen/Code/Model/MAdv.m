//
//  MAdv.m
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import "MAdv.h"
#import <SDCycleScrollView/NSData+SDDataCache.h>

@implementation MAdv

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"id"];
        self.photoUrl  = [ item objectForKey:@"url"];
        self.title = [item objectForKey: @"title"];
        self.bannerUrl = [item objectForKey: @"zt_url"];
    }
    return self;
}

-(instancetype)initWithzt:(NSDictionary *)item{
    self = [super init];
    if(self){
        self.rowID = [item objectForKey:@"item_id"];
        self.photoUrl  = [ item objectForKey:@"image"];
        self.bigPhotoUrl  = [ item objectForKey:@"bigimage"];
        self.title = [item objectForKey: @"title"];
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.bigPhotoUrl]];
        [data saveDataCacheWithIdentifier:self.bigPhotoUrl];
        
        
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"item_id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"title"]){
            _title = value;
        }else if ([key isEqualToString:@"url"]){
            _photoUrl = value;
        }else if ([key isEqualToString:@"image"]){
            _photoUrl = value;
        }else if ([key isEqualToString:@"bigimage"]){
            _bigPhotoUrl = value;
        }else if ([key isEqualToString:@"zt_url"]){
            _bannerUrl = value;
        }
    }
}

@end
