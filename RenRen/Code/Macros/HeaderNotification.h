//
//  HeaderNotification.h
//  KYRR
//
//  Created by kyjun on 15/11/2.
//
//

#ifndef HeaderNotification_h
#define HeaderNotification_h

#define NotificatonWXLoginAuthorization @"NotificatonWXLoginAuthorization"//微信登录授权成功回调

#define NotificationPaySuccess @"NotificationPaySuccess" //支付成功

#define NotificationPayUserCancel @"NotificationPayUserCancel" //用户取消支付

#define NotificationPayFailure @"NotificationPayFailure" //支付失败

#define NotificationLoginSuccess @"NotificationLoginSuccess" //登录成功通知

#define NotificationLogout @"NotificationLogout" //退出登录通知 

#define NotificationSelectedAddres @"NotificationSelectedAddres" //选择收货地址

#define NotificationSelecteMapAddress @"NotificationSelecteMapAddress"

#define NotificationGoClearing @"NotificationGoClearing" //去结算 修改FirstLoad 为YES 用于刷新数据

#define NotificationChangeOrderPayStatus @"NotificationChangeOrderPayStatus" //用户支付成功 修改订单状态成功调用这个方法

#define NotificationShopCarChange @"NotificationShopCarChange" //购物车发送变化通知 目前支持 提交购物车数据后发出的通知

#define NotificationAppBack @"NotificationAppBack" //支付时不支付选择返回应用

#pragma mark =====================================================  外卖郎订单
#define NotificationRefreshOrder @"NotificationRefreshOrder"

#define NotificationAgainSingle  @"NotificationAgainSingle" //再来一单

#define NotificationShowComment  @"NotificationShowComment"

#define NotificationRereshDescription @"NotificationRereshDescription"

#define NotificationRefreshShopCar @"NotificationRefreshShopCar"

#define NotificationrefReshFightGroupCell @"NotificationrefReshFightGroupCell"

#define NotificationrefReshFightGroupInfoSection @"NotificationrefReshFightGroupInfoSection"

#define NofificatonActivityPart @"NofificatonActivityPart"
/**
 *  参团成功
 *
 *  @return
 */
#define NotificationPintuangouVCuccess @"NotificationPintuangouVCuccess"
/**
 *  创建团成功
 *
 *  @return 
 */
#define NotificationFightGroupCreateTuanSuccess @"NotificationFightGroupCreateTuanSuccess"
/**
 *  团结束
 *
 *  @return
 */
#define NotificationFightGroupTuanEnd @"NotificationFightGroupTuanEnd"

#pragma mark =====================================================  积分商城
/**
 *  积分兑换后更新积分
 *
 *  @return
 */
#define NotificationRefreshPoints @"NotificationRefreshPoints"

#pragma mark =====================================================  水果
#define NotificationrefReshFruitCell @"NotificationrefReshFruitCell"

#define NotificationRefreshGoodsInfo @"NotificationRefreshGoodsInfo"



#define NotificationRefreshGoodsInfo @"NotificationRefreshGoodsInfo"

#pragma mark =====================================================  定位动画
#define NotificationMapLocationCurrentCellBeginAnimations @"NotificationMapLocationCurrentCellbeginAnimations"
#define NotificationMapLocationCurrentCellStopAnimations @"NotificationMapLocationCurrentCellStopAnimations"

/**
 更改了这里位置信息，发出通知更新首页数据

 @return NSString 返回一个字符串
 */
#define NotificationMapLocationChangePosition @"NotificationMapLocationChangePosition"

#pragma mark =====================================================  随意购 

#define NotificationSelectedBuyAddress @"NotificationSelectedBuyAddress"

#define NotificationSelectedRandomAddressReceive @"NotificationSelectedRandomAddressReceive"
#define NotificationSelectedRandomAddressSend @"NotificationSelectedRandomAddressSend"
#define NotificationSelectedRandomAddressTake @"NotificationSelectedRandomAddressTake"

#define NotificationSelectedVouchers @"NotificationSelectedVouchers"

#define NotificationRandomPayFinished @"NotificationRandomPayFinished"

#define NotificationRandomPayFinishRefreshOrder @"NotificationRandomPayFinishRefreshOrder"
#define NotificationRandomRefreshOrder @"NotificationRandomRefreshOrder"
/**
 *  帮你送 选择商品信息
 *
 *  @return 
 */
#define NotificationSelectRandomSaleInfo @"NotificationSelectRandomSaleInfo"

/**
 首次启动引导结束调用

 @return
 */
#define NotificationGuidanceViewFinished @"NotificationGuidanceViewFinished"




#endif /* HeaderNotification_h */
