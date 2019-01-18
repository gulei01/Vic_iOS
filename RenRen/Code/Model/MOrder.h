//
//  MOrder.h
//  KYRR
//
//  Created by kyjun on 15/11/7.
//
//

#import <Foundation/Foundation.h>

@interface MOrder : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

/**
 *  订单编号
 */
@property(nonatomic,copy) NSString* rowID;
/**
 *  用户编号
 */
@property(nonatomic,copy) NSString* userID;
/**
 *  支付方式 付款类型：0货到付款；1支付宝；2微信;3 moneris
 */
@property(nonatomic,copy) NSString* payType;
/**
 *  支付方式名称
 */
@property(nonatomic,copy) NSString* payTypeName;
/**
 *  店铺编号
 */
@property(nonatomic,copy) NSString* storeID;
/**
 *  店铺名称
 */
@property(nonatomic,copy) NSString* storeName;
/**
 *  订单生产时间
 */
@property(nonatomic,copy) NSString* createDate;
/**
 *  商品数量
 */
@property(nonatomic,copy) NSString* goodsCount;
/**
 *  订单价格(food_amount) + 加上了相应的东西
 */
@property(nonatomic,copy) NSString* goodsPrice;
/**
 *  订单状态 0:未付款；1:已发货；2：已付款（针对在线）；3：退款中；4:交易成功，已完成；5:已取消（退款完成）；6:已退款
 */
@property(nonatomic,copy) NSString* status;

/**
 *  该订单是否已经评论 score_set; // 1：未评价；2：已评价
 */
@property(nonatomic,copy) NSString* isComment;

/**
 *  订单状态名称
 */
@property(nonatomic,copy) NSString* statusName;
/**
 *  商品图片
 */
@property(nonatomic,copy) NSString* goodsImage;
/**
 *  0正常订单，1预售，2拼团
 */
@property(nonatomic,copy) NSString* orderType;
/**
 *  -1失败；0进行；1成功
 */
@property(nonatomic,copy) NSString* tuanStatus;

@property(nonatomic,copy) NSString* tuanMark;

@property(nonatomic,copy) NSString* tuanID;
@property(nonatomic,copy) NSString* showDel;

@property(nonatomic,copy) NSString* tip_fee;
@property(nonatomic,copy) NSString* total_price;
@property(nonatomic,copy) NSString* paid;
@property(nonatomic,copy) NSString* order_id;
@property(nonatomic,copy) NSString* discount;
@property(nonatomic,copy) NSString* deliver_name;
@property(nonatomic,copy) NSString* deliver_lng;
@property(nonatomic,copy) NSString* deliver_lat;

@end
