//
//  MGoods.h
//  XYRR
//
//  Created by kyjun on 15/10/24.
//
//

#import <Foundation/Foundation.h>

@interface MGoods : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;
/**
 *  查询专题部分响应的 商品
 *
 *  @param item NSDictionary
 *
 *  @return MGoods
 */
-(instancetype)initWithZTItem:(NSDictionary*)item;
/**
 *  查询商品详细信息
 *
 *  @param item NSDictionary
 *
 *  @return MGoods
 */
-(instancetype)initWithEntity:(NSDictionary*)item;
/**
 *  购物车
 *
 *  @param item NSDictionary
 *
 *  @return MGoods
 */
-(instancetype)initWithShopCar:(NSDictionary*)item;

/**
 *  用于结算 (生成订单、提交订单 页面查询数据)
 *
 *  @param item NSDictionary
 *
 *  @return MGoods
 */
-(instancetype)initWithClearing:(NSDictionary*)item;
/**
 *  查询店铺内商品列表
 *
 *  @param item NSDictionary
 *
 *  @return MGoods
 */
-(instancetype)initWithStore:(NSDictionary*)item;
/**
 *  商品搜索
 *
 *  @param item NSDictionary
 *
 *  @return MGoods
 */
-(instancetype)initWithSearch:(NSDictionary*)item;
/**
 *  查询营业店铺中 (也许你也喜欢 )
 *
 *  @param item NSDictionary
 *
 *  @return MGoods
 */
-(instancetype)initWithOpenStore:(NSDictionary*)item;


/**
 *  商品编号
 */
@property(nonatomic,copy) NSString* rowID;
/**
 *  商品名称
 */
@property(nonatomic,copy) NSString* goodsName;
/**
 *  0:上架；1:下架
 */
@property(nonatomic,copy) NSString* status;
/**
 *  商品类别 71表示秒杀
 */
@property(nonatomic,copy) NSString* categroyID;
/**
 *  0:不推荐；1：首页推荐
 */
@property(nonatomic,copy) NSString* isBest;
/**
 *  0不限购；非零：限购数量
 */
@property(nonatomic,copy) NSString* limitBuy;
/**
 *  库存
 */
@property(nonatomic,copy) NSString* stock;
/**
 *  价格
 */
@property(nonatomic,copy) NSString* price;
/**
 *  市面价格
 */
@property(nonatomic,copy) NSString* maketPrice;
/**
 *  结算价格 目前这个属性没有被使用的地方
 */
@property(nonatomic,copy) NSString* checkPrice;
/**
 *  商品图片 缩略图---
 */
@property(nonatomic,copy) NSString* defaultImg;
/**
 *  商品图片 大图 ---
 */
@property(nonatomic,copy) NSString* maxImage;
/**
 *  水果的图片
 */
@property(nonatomic,copy) NSString* fruitImage;
@property(nonatomic,assign)CGSize thumbnailsSize;
/**
 *  水果简介
 */
@property(nonatomic,copy) NSString* summary;
/**
 *  店铺编号
 */
@property(nonatomic,copy) NSString* storeID;
/**
 *  店面状态 1 营业 2 休息
 */
@property(nonatomic,copy) NSString* storeStatus;
/**
 *  desc代表是否为药品，
 *  药品返回 1，
 *  非药品返回 0；
 *  药品需要显示说明书
 */
@property(nonatomic,copy) NSString* desc;

@property(nonatomic,copy) NSString* content;
/**
 *  店铺名称
 */
@property(nonatomic,copy) NSString* storeName;



/**
 是否是秒杀 是否是秒杀 1.秒杀；0不是秒杀
 */
@property(nonatomic,assign) BOOL isMiaoSha;




#pragma mark =====================================================  购物车部分会用到的属性
/**
 *  购买数量
 */
@property(nonatomic,copy) NSString* quantity;
/**
 *  购物车结算时是否选中 默认为选中
 */
@property(nonatomic,assign) BOOL shopCarSelected;

#pragma mark ===================================================== 用于结算 (生成订单、提交订单 页面查询数据)会用到
/**
 *  优惠价总和
 */
@property(nonatomic,copy) NSString* priceSum;
/**
 *  市场价总和
 */
@property(nonatomic,copy) NSString* maketPriceSum;


//口味分组
@property(nonatomic,copy) NSString* group_id;

//是否有规划或属性选择 garfunkel add
@property(nonatomic,assign) BOOL has_format;

@property(nonatomic,copy) NSString* spec;
@property(nonatomic,copy) NSString* proper;
@property(nonatomic,copy) NSString* spec_desc;
@property(nonatomic,copy) NSString* proper_desc;
@end
