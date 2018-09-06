//
//  MyGroupModel.h
//  KYRR
//
//  Created by ios on 17/6/11.
//
//

#import <Foundation/Foundation.h>

@interface MyGroupModel : NSObject


-(instancetype)initWithItem:(NSDictionary*)item;

@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,copy) NSString* sid;
@property(nonatomic,copy) NSString* title;

//garfunkel add
@property(nonatomic,assign) BOOL is_cart;

@property(nonatomic,copy) NSMutableArray *saveKindArray;

@end
