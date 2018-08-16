//
//  MStoreStatus.h
//  KYRR
//
//  Created by kyjun on 16/4/18.
//
//

#import <Foundation/Foundation.h>

@interface MOrderStatus : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;
/**
 *  状态编号
 */
@property(nonatomic,strong) NSString* status;
/**
 *  状态说明
 */
@property(nonatomic,strong) NSString* mark;
/**
 *  状态名称
 */
@property(nonatomic,strong) NSString* name;
/**
 *  状态产生时间
 */
@property(nonatomic,strong) NSString* createDate;

@end
