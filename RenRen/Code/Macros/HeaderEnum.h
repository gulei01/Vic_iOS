//
//  HeaderEnum.h
//  KYRR
//
//  Created by kyjun on 16/1/7.
//
//

#import <Foundation/Foundation.h>

@interface HeaderEnum : NSObject

@end
/**
 *  用户订单支付成功需要修改订单状态需要传入一个订单类型
 */
typedef NS_ENUM(NSInteger, KYOrderType) {
    /**
     *  主订单(从购物车提交的订单)
     */
    OrderTypeMain =1,
    /**
     *  子订单(订单列表提交的订单)
     */
    OrderTypeSub = 2
};

/**
 *  客户端平台信息
 */
typedef NS_ENUM(NSInteger,KYClientPlatform) {
    /**
     *  客户端平台为 iOS
     */
    ClientPlatformiOS = 2,
    /**
     *  客户端平台为 Android
     */
    //ClientPlatformAndroid = 3
};

typedef NS_ENUM(NSInteger,KYRandomAddressCategory) {
    /**
     *  发货地址
     */
    RandomAddressCategorySend = 1<<0,
    /**
     *  收货地址
     */
    RandomAddressCategoryReceive = 1<<1,
    /**
     *  取货地址
     */
    RandomAddressCategoryTake    = 1<<2
};