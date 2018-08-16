//
//  MComment.m
//  KYRR
//
//  Created by kyjun on 16/4/15.
//
//

#import "MComment.h"

@implementation MComment

-(instancetype)initWithItem:(NSDictionary *)item{
    self = [super init];
    if(self){
        _rowID = [item objectForKey:@"itemid"];
        _orderID = [item objectForKey:@"order_id"];
        _storeID = [item objectForKey:@"sid"];
        _createDate =[item objectForKey:@"addtime"];
        _comment = [item objectForKey:@"comment"];
        _userName = [item objectForKey:@"name"];
        
        _scoreToal = [item objectForKey:@"score"];
        _scoreFood = [item objectForKey:@"score1"];
        _scoreExpress = [item objectForKey:@"score2"];
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if(key){
        if([key isEqualToString:@"itemid"]){
            _rowID = value;
        }else if ([key isEqualToString:@"order_id"]){
            _orderID = value;
        }else if ([key isEqualToString:@"sid"]){
            _storeID = value;
        }else if ([key isEqualToString:@"addtime"]){
            _createDate = value;
        }else if ([key isEqualToString:@"comment"]){
            _comment = value;
        }else if ([key isEqualToString:@"name"]){
            _userName = value;
        }else if ([key isEqualToString:@"score"]){
            _scoreToal = value;
        }else if ([key isEqualToString:@"score1"]){
            _scoreFood = value;
        }else if ([key isEqualToString:@"score2"]){
            _scoreExpress = value;
        }else if ([key isEqualToString: @"img_url"]){
            _avatar = value;
        }else if ([key isEqualToString: @"send_done_time"]){
            _finishTime = value;
        }else if ([key isEqualToString: @"reply"]){
            NSDictionary* empty = value;
            if([empty isKindOfClass:[NSDictionary class]]){
            _replyComment =[NSString stringWithFormat: @"商家回复: %@", [empty objectForKey: @"comment"]];
            }
        }
    }
}

-(NSString *)avatar{
    if([WMHelper isNULLOrnil:_avatar]){
        return  @"";
    }
    return _avatar;
}


@end

@implementation MOther



@end
