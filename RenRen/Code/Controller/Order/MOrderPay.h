//
//  MOrderPay.h
//  KYRR
//
//  Created by kyjun on 16/1/7.
//
//

#import <Foundation/Foundation.h>
#import "payRequsestHandler.h"
#import "AlipayOrder.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AppDelegate.h"
#import "WXApi.h"

/**
 *  订单支付 这里主要是 微信支付和支付宝支付
 */
@interface MOrderPay : NSObject

/**
 *  微信支付
 *
 *  @param orderID  NSString 订单编号
 *  @param price    NSInteger 订单金额
 *  @param complete block 回调
 */
+(void)payWithWeiXin:(NSString*)orderID price:(NSInteger)price;
/**
 *  支付宝支付
 *
 *  @param orderID  NSString 订单编号
 *  @param price    float 订单金额
 *  @param complete block 回调
 */
+(void)payWithAlipay:(NSString*)orderID price:(double)price complete:(void(^)(NSInteger resultCode,NSString* message))complete;


@end
