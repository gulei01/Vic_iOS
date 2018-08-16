//
//  NetRepositories.h
//  KYRR
//
//  Created by kyjun on 16/6/1.
//
//

#import <Foundation/Foundation.h>
#import "NetPage.h"
#import "NetClient.h"
#import "MModel.h"
#import <AFNetworking/AFNetworking.h>

/**
 *  数据请求响应结果集 block
 *
 *  @param react  NSInteger 表示当前请求数据的状态 例如:失败(0)
 *  @param list    NSArray  标示当前请求放回的结果集 如果请求失败是nill
 *  @param message NSString 标示请求返回的消息 如果请求失败会返回失败原因
 */
typedef void(^responseListBlock)(NSInteger react, NSArray* list, NSString* message);

typedef void(^responseListBlockXiaolong)(NSInteger react, NSArray* list, NSString* message,NSArray *groupArray);


/**
 数据请求响应结果集 block

 @param react    NSInteger 表示当前请求数据的状态 例如:失败(0) 1 表示成功
 @param response NSDictionary 标示当前请求放回的结果集 如果请求失败是nill
 @param message  NSString 标示请求返回的消息 如果请求失败会返回失败原因
 */
typedef void(^responseDictBlock)(NSInteger react,NSDictionary* response,NSString* message);

typedef void(^responseListAndOtherBlock)(NSInteger react, NSArray* list,id model, NSString* message);

typedef void(^responseListAndDictBlock)(NSInteger react, NSArray* list,NSDictionary* dict, NSString* message);

/**
 *  数据请求响应结果 block
 *
 *  @param react  NSInteger 表示当前请求数据的状态 例如:失败(0)
 *  @param item    id  标示当前请求放回的结果 如果请求失败是nill
 *  @param message NSString 标示请求返回的消息 如果请求失败会返回失败原因
 */
typedef void(^responseItemBlock)(NSInteger react, id obj ,NSString* message);

typedef void(^responseBlock)(NSInteger react,NSString* message);

@interface NetRepositories : NSObject

-(void)netConfirm:(NSDictionary*)arg complete:(responseDictBlock)complete;

@end

FOUNDATION_EXTERN NSString* const AppNetSubPath;
FOUNDATION_EXTERN NSString* const AppNetSubPath_Points;
/**
 *  店铺的数据操作方法
 */
@interface NetRepositories (Store)

-(void)queryStore:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryStore:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlock)complete;
-(void)searchStore:(NSDictionary*)arg complete:(responseItemBlock)complete;

@end
/**
 *  商品的数据操作方法
 */
@interface NetRepositories (Goods)

-(void)queryGoods:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryGoods:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlockXiaolong)complete;
-(void)queryGoodsWithSearch:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlock)complete;
-(void)searchGoods:(NSDictionary*)arg complete:(responseItemBlock)complete;

-(void)querySubType:(NSDictionary*)arg complete:(responseListBlock)complete;

@end
/**
 *  订单的数据操作方法
 */
@interface NetRepositories (Order)
-(void)queryOrder:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryOrder:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlock)complete;
-(void)searchOrder:(NSDictionary*)arg complete:(responseItemBlock)complete;

-(void)queryOrderStatus:(NSDictionary*)arg complete:(responseListAndDictBlock)complete;
 
@end

@interface NetRepositories (Comment)

-(void)queryComment:(NSDictionary*)arg complete:(responseListAndOtherBlock)complete;
-(void)queryComment:(NSDictionary*)arg page:(NetPage*)page complete:(responseListAndOtherBlock)complete;
-(void)updateComment:(NSDictionary*)arg complete:(responseItemBlock)complete;

@end

/**
 *  用户的数据操作方法 - 包含收货地址、红包
 */
@interface NetRepositories (UserInfo)
-(void)login:(NSDictionary*)arg complete:(responseItemBlock)complete;
-(void)register:(NSDictionary*)arg complete:(responseItemBlock)complete;
-(void)searchUserInfo:(NSDictionary*)arg complete:(responseItemBlock)complete;

-(void)queryAddress:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryAddress:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlock)complete;
-(void)searchAddres:(NSDictionary*)arg complete:(responseItemBlock)complete;
-(void)updateAddres:(NSDictionary*)arg complete:(responseItemBlock)complete;

-(void)queryRedEnvelop:(NSDictionary*)arg complete:(responseListBlock)complete;

@end
/**
 *  购物车数据操作方法
 */
@interface NetRepositories (ShopCar)
-(void)queryShopCar:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryShopCar_V2:(NSDictionary*)arg complete:(void(^)(NSInteger react ,MCar* entity,NSString* message))complete;
-(void)updateShopCar:(NSDictionary*)arg complete:(responseItemBlock)complete;
-(void)checkShopCar:(NSDictionary*)arg complete:(responseBlock)complete;
-(void)submitShopCarCheck:(NSDictionary*)arg complete:(responseDictBlock)complete;
@end
/**
 *  地理位置有关的操作方法 - 包含 城市、商圈
 */
@interface NetRepositories (Location)

-(void)queryArea:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryCircle:(NSDictionary*)arg complete:(responseListBlock)complete;

@end
/**
 *  系统通知和广告的操作方法
 */
@interface NetRepositories (Advertisement)
-(void)queryAdvertisement:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryAdvertBanner:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryAdvertZT:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)searchNotice:(NSDictionary*)arg complete:(responseItemBlock)complete;
@end
/**
 *  积分商城的操作方法
 */
@interface NetRepositories (PointsMall)
-(void)queryPointMallIndex:(NSDictionary*)arg page:(NetPage*)page complete:(responseItemBlock)complete;
-(void)queryPointRecord:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlock)complete;
-(void)queryPointExchange:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlock)complete;
-(void)searchPoint:(NSDictionary*)arg complete:(responseItemBlock)complete;
-(void)exchangeGoods:(NSDictionary*)arg complete:(responseItemBlock)complete;
@end
/**
 *  秒杀的操作方法
 */
@interface NetRepositories (BuyNow)

-(void)queryBuyNow:(NSDictionary*)arg complete:(responseListBlock)complete;

-(void)queryBuyNow:(NSDictionary *)arg page:(NetPage*)page complete:(responseListBlock)complete;

-(void)searchBuyNow:(NSDictionary *)arg complete:(responseListAndOtherBlock)complete;

@end
/**
 *  预售的操作方法
 */
@interface NetRepositories (Presale)

-(void)queryPresale:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryPresale:(NSDictionary*)arg page:(NetPage*)page complte:(responseListBlock)complete;
-(void)searchPresale:(NSDictionary*)arg complete:(responseItemBlock)complete;

@end

/**
 *  拼团的操作方法
 */
@interface NetRepositories (PintuangouVC)

-(void)queryPintuangouVC:(NSDictionary*)arg complete:(responseListBlock)complete;
-(void)queryPintuangouVC:(NSDictionary*)arg page:(NetPage*)page complte:(responseListBlock)complete;
-(void)searchPintuangouVC:(NSDictionary*)arg complete:(responseItemBlock)complete;

-(void)queryMyFightGroup:(NSDictionary*)arg page:(NetPage*)page complte:(responseDictBlock)complete;

@end
