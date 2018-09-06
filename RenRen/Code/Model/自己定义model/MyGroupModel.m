//
//  MyGroupModel.m
//  KYRR
//
//  Created by ios on 17/6/11.
//
//

#import "MyGroupModel.h"

@implementation MyGroupModel

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        
        self.rowID = [item objectForKey:@"id"];
        self.sid  = [item objectForKey:@"sid"];
        self.title = [item objectForKey:@"title"];
        self.is_cart = false;
    }
    return self;
}

- (NSMutableArray *)saveKindArray {

    if (_saveKindArray == nil) {
        
        _saveKindArray = [[NSMutableArray alloc]init];
    }
    return _saveKindArray;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        
        if([key isEqualToString:@"id"]){
            _rowID = value;
        }else if ([key isEqualToString:@"title"]){
            _title = value;
        }else if ([key isEqualToString:@"sid"]){
            _sid = value;
        }
        _is_cart = false;
    }
}

@end
