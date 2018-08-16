//
//  MSystemNotice.h
//  KYRR
//
//  Created by kyjun on 16/6/2.
//
//

#import <Foundation/Foundation.h>

/**
 *  外卖郎 发出的系统通知
 */
@interface MSystemNotice : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

/**
 *  消息唯一标示
 */
@property(nonatomic,copy) NSString* rowID;
/**
 *  消息内容
 */
@property(nonatomic,copy) NSString* content;
/**
 *  创建消息的用户编号
 */
@property(nonatomic,copy) NSString* userID;
/**
 *  消息开始时间
 */
@property(nonatomic,copy) NSString* beginDate;
/**
 *  消息结束时间
 */
@property(nonatomic,copy) NSString* endDate;

@end
