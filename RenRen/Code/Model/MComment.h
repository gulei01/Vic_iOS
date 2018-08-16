//
//  MComment.h
//  KYRR
//
//  Created by kyjun on 16/4/15.
//
//

#import <Foundation/Foundation.h>

@interface MComment : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

/**
 *  唯一标示
 */
@property(nonatomic,strong) NSString* rowID;
/**
 *  订单编号
 */
@property(nonatomic,strong) NSString* orderID;
/**
 *  评论时间
 */
@property(nonatomic,strong) NSString* createDate;
/**
 *  店铺编号
 */
@property(nonatomic,strong) NSString* storeID;
/**
 *  评论内容
 */
@property(nonatomic,strong) NSString* comment;
@property(nonatomic,assign) CGFloat commentHeight;

/**
 回复评论
 */
@property(nonatomic,strong) NSString* replyComment;
@property(nonatomic,assign) CGFloat replyCommentHeight;
/**
 *  用户名称
 */
@property(nonatomic,strong) NSString* userName;
@property(nonatomic,copy) NSString* avatar;
@property(nonatomic,copy) NSString* finishTime;

/**
 *  综合评价
 */
@property(nonatomic,strong) NSString* scoreToal;
/**
 *  口味评论
 */
@property(nonatomic,strong) NSString* scoreFood;
/**
 *  快递评论
 */
@property(nonatomic,strong) NSString* scoreExpress;



@end

@interface MOther : NSObject

#pragma mark =====================================================  总体评分
@property(nonatomic,copy) NSString* totalComment;
@property(nonatomic,copy) NSString* foodComment;
@property(nonatomic,copy) NSString* shipComment;

#pragma mark =====================================================  评分等级
@property(nonatomic,copy) NSString* totalNum;
@property(nonatomic,copy) NSString* badNum;
@property(nonatomic,copy) NSString* goodNum;
@property(nonatomic,copy) NSString* bestNum;

@end
