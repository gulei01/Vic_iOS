//
//  MCar.h
//  KYRR
//
//  Created by kyjun on 16/6/15.
//
//

#import <Foundation/Foundation.h>

@interface MCar : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

@property(nonatomic,copy) NSString* sumNum;
@property(nonatomic,copy) NSString* sumMoney;

@property(nonatomic,strong) NSMutableArray* arrayStore;
@property(nonatomic,strong) NSMutableArray* arrayAddress;

@end
