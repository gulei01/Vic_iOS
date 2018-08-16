//
//  MStore.h
//  XYRR
//
//  Created by kyjun on 15/10/24.
//
//

#import <Foundation/Foundation.h>

@interface MStore : NSObject
/**
 *  首页调用
 *
 *  @param item
 *
 *  @return 
 */
-(instancetype)initWithItem:(NSDictionary*)item;
/**
 *  店铺列表调用
 *
 *  @param item
 *
 *  @return
 */
-(instancetype)initWithList:(NSDictionary*)item;
/**
 *  购物车
 *
 *  @param item
 *
 *  @return
 */
-(instancetype)initWithShopCar:(NSDictionary*)item;
/**
 *  店铺编号
 */
@property(nonatomic,copy) NSString* rowID;
/**
 *  店铺名称
 */
@property(nonatomic,copy) NSString* storeName;
@property(nonatomic,copy) NSString* address;
/**
 *  店铺状态1:开启；0:关闭
 */
@property(nonatomic,copy) NSString* status;
/**
 *  不推荐；1：推荐
 */
@property(nonatomic,copy) NSString* isBest;

/**
 是否是自营
 */
@property(nonatomic,copy) NSString* isSelf;
/**
 *  店铺logo
 */
@property(nonatomic,copy) NSString* logo;
/**
 *  开始营业时间
 */
@property(nonatomic,copy) NSString* servicTimeBegin;
/**
 *  结束营业时间
 */
@property(nonatomic,copy) NSString* serviceTimerEnd;
/**
 *  销量
 */
@property(nonatomic,copy) NSString* sale;
/**
 *  免配送费 起步金额
 */
@property(nonatomic,copy) NSString* freeShip;
/**
 *  配送费
 */
@property(nonatomic,copy) NSString* shipFee;
/**
 *  配送方  0:外卖郎店送货；1：店铺自己送货
 */
@property(nonatomic,copy) NSString* shipUnit;
/**
 *  店铺类别编号
 */
@property(nonatomic,copy) NSString* categoryID;

@property(nonatomic,copy) NSString* notice;

@property(nonatomic,copy) NSString* phone;

@property(nonatomic,copy) NSString* mobile;

@property(nonatomic,copy) NSString* storeScore;

/**
 *    是否是商家配送 1、标示商家配送 0 标示外卖郎配送
 */
@property(nonatomic,copy) NSString* send;

/**
 *  店铺商品列表
 */
@property(nonatomic,strong) NSMutableArray* arrayGoods;

/**
 *  店铺活动、 目前设置
 */
@property(nonatomic,strong) NSMutableArray* arrayActive;
@property(nonatomic,assign,readonly) NSInteger shopCarGoodsCount;
@property(nonatomic,assign,readonly) float shopCarGoodsPrice;


@end
