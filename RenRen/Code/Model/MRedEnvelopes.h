//
//  MRedEnvelopes.h
//  KYRR
//
//  Created by kyjun on 15/11/10.
//
//

#import <Foundation/Foundation.h>

/**
 *  红包
 */
@interface MRedEnvelopes : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;
#warning  notice
@property(nonatomic,copy) NSString* rowiID;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* limitMoney;
@property(nonatomic,copy) NSString* money;
@property(nonatomic,copy) NSString* beginDate;
@property(nonatomic,copy) NSString* endDate;
/**
 *  type; // 1.立减; 2.满减
 */
@property(nonatomic,copy) NSString* type;
/**
 *   '0:未使用；2：已经使用'；3：已过期
 */
@property(nonatomic,copy) NSString* status;


@end
