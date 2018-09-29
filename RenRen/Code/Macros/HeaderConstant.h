//
//  HeaderConstant.h
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#ifndef HeaderConstant_h
#define HeaderConstant_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define StatusBar_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define SCREEN [[UIScreen mainScreen]bounds]

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)



//----------------------系统----------------------------

// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 是否iPad
#define someThing (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? ipad: iphone

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define ISIOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define ISIOS9 ([[UIDevice currentDevice].systemVersion floatValue]>=9?YES:NO)
#define ISIOS10 ([[UIDevice currentDevice].systemVersion floatValue]>=10?YES:NO)


//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define kHost @"http://wm.wm0530.com/mobile/Re/index"

/**
 * begin 20170407 第三方配置文件
 *
 */

#pragma mark =====================================================  微信登陆、支付
#define kWXAPP_ID @"wx8b65930e48974b35"
#define kWXAPP_SECRET @"6b477f1058f877e89da8bdaf7ad5de5f"

#pragma mark 微信支付
/**
 *  微信支付分配的商户号
 */
#define kWXPay_partnerid @"1337228001"

/**
 *  微信支付分配的商户号 密钥
 */
#define kWXPay_partnerid_secret @"GFTYjdhye4521235d5d8e8s5s1zx2d5s"

#pragma mark =====================================================  QQ登陆
#define kQQAPP_ID @"1106028245"
#define kQQAPP_KEY @"Yyh8N6Ybtl5sHBlu"

//支付结果回调页面
//http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php

#define NOTIFY_URL      @"http://wm.wm0530.com/mobile/Re/wx_notify"

//获取服务器端支付数据地址（商户自定义）(在小吉这里，签名算法直接放在APP端，故不需要自定义)
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"

/*
 用户没有登录Tabbarselectedindex就不执行Tab 切换
 */
#define kNoLoginNoSelectedIndex @"kNoLoginNoSelectedIndex"
#define kNoLoginMemoryPreviousTabIndex @"kNoLoginMemoryPreviousTabIndex"




#pragma mark =====================================================  友盟
#define kYouMengAppKey @"58f2d43ef29d984159001ea8"

#pragma mark =====================================================  高德地图
#define kMAMapAPIKey @"43e46dfd09ac8de7ce14bcda53aca6f4"
#pragma mark =====================================================  APPID 苹果应用唯一标示
#define kStoreAppId     @""

#pragma google map ===============================================  Google Map
#define googleMapAPIKey @"AIzaSyCLuaiOlNCVdYl9ZKZzJIeJVkitLksZcYA"
/**
 * end 20170407 第三方配置文件
 *
 */

#pragma mark =====================================================  缓存key
#define kDefaultAddress @"kDefaultAddress"

#define ADVHEIGHT (60.f)

#define kHtmlHead @"<html><head><meta name=\"viewport\" content=\"width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no\"><style type=\"text/css\">body{max-width:100%;} img{max-width:100%;overflow:hidden;height:auto;}</style></head><body style=\"font-size:13px;\">"

#define kHtmlFoot @"</body></html>"


#pragma mark =====================================================  随意购
#define kRandomBuyConfig @"RandomBuyConfig"
#define kRandomBuyFeeConfig @"kRandomBuyFeeConfig"

#pragma mark =====================================================  全局配置参数
#define kisBindingJPushTag @"kisBindingJPushTag"  //是否绑定了极光推送别名 对应的YES or NO


/**
 默认给定店铺logo图标

 @return NSString  店铺默认logo图片名称
 */
#define kDefStoreLogo @"icon-60"
#define kDefaultImage @"Icon-default-image"

/**
 默认商品图片
 
 @return NSString  默认商品图片
 */
#define kDefaultGoodsImage @"Icon-default-image"

/**
 默认秒杀图片
 
 @return NSString  默认秒杀图片
 */
#define kDefaultMiaoShaImage @"Icon-default-image"

/**
 默认满减图片
 
 @return NSString  默认满减图片
 */
#define kDefaultManJianImage @"Icon-default-image"

/**
 默认团购图片
 
 @return NSString  默认团购图片
 */
#define kDefaultTuanImage @"Icon-default-image"

//garfunkel add
#define languageName_zh @"中文"
#define languageName_en @"English"
//获取语言包
#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Language"]

#endif /* HeaderConstant_h */
