//
//  AppDelegate.m
//  RenRen
//
//  Created by kyjun on 15/10/29.
//
//

#import "AppDelegate.h"
#import "Home.h"
#import "NewHome.h"
#import "Shopping.h"
#import "OrderVC.h"
#import "Mine.h"
#import "RandomBuy.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "MSingle.h"
#import "Login.h"
#import <AlipaySDK/AlipaySDK.h>
#import "GuidanceView.h"
#import <IQKeyboardManager/IQToolbar.h>
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>


#import <TencentOpenAPI/QQApiInterface.h>
#import <UMMobClick/MobClick.h>

#import <AMapFoundationKit/AMapFoundationKit.h>
#import "RandomOrder.h"
#import "Store.h"
#import "Goods.h"
#import "PintuangouVC.h"
#import "FightGroupItem.h"
#import "BuyNow.h"
#import "BuyNowInfo.h"
//#import <JSPatchPlatform/JSPatch.h>

#import "MapLocation.h"

@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate ()<UITabBarControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UITabBarController* mainTab;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setWholeStyle];
    [GMSServices provideAPIKey:googleMapAPIKey];
    [GMSPlacesClient provideAPIKey:googleMapAPIKey];
    
    [self setLanguage];

//    [JSPatch startWithAppKey:@"04c363927fbfd6cb"];
//    [JSPatch sync];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=theme_navigation_color;
    //garfunkel 创建四个主要的导航控制器并添加到数组中
    NSArray *arrayController=@[
                               [[UINavigationController alloc]initWithRootViewController:[[NewHome alloc]init]],
                               [[UINavigationController alloc]initWithRootViewController:[[Shopping alloc]init]],
                               [[UINavigationController alloc]initWithRootViewController:[[OrderVC alloc]init]],
                               [[UINavigationController alloc]initWithRootViewController:[[Mine alloc]init]],
                               ];
    //数组循环
    [arrayController enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UINavigationController* nav = obj;
        UIImage* navBg = [WMHelper makeImageWithColor:theme_navigation_color width:1.0 height:1.0];
        [nav.navigationBar setTranslucent:YES];
        [nav.navigationBar setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault] ;
        nav.navigationBar.shadowImage = navBg;
        UIImageView* barImageView =[UINavigationBar appearance].subviews.firstObject;
        barImageView.backgroundColor = theme_navigation_color;
        
        //[nav.navigationBar setBarTintColor:theme_navigation_color];
    }];
    //分栏控制器，代理
    self.mainTab = [UITabBarController new];
    self.mainTab.delegate = self;
    
//    MapLocation* controller = [[MapLocation alloc]init];
//    Empty2Controller* controller = [[Empty2Controller alloc]init];
//    controller.hidesBottomBarWhenPushed = YES;
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:controller.view];

    //添加导航控制器数据到分栏控制器
    self.mainTab.viewControllers = arrayController;
    self.window.rootViewController = self.mainTab;
    [self.window makeKeyAndVisible];
    
    MapLocation* controller = [[MapLocation alloc]init];

    controller.hidesBottomBarWhenPushed = YES;
    
    [_mainTab.tabBarController presentViewController:controller animated:YES completion:^{
        
        
        
    }];

    
    [self registerThirdParty];
    
    [self registerShareSDK];
    
    //启用引导页
    [self startGuide];
    
//    //启动定位页
//    MapLocation* controller = [[MapLocation alloc]init];
//    //Empty2Controller* controller = [[Empty2Controller alloc]init];
//    controller.hidesBottomBarWhenPushed = YES;
//
//    [[UIApplication sharedApplication].keyWindow addSubview:controller.view];
  
    
    //启用友盟
    [self startUMeng];
    SDWebImageDownloader* imgDownloader = SDWebImageManager.sharedManager.imageDownloader;
    imgDownloader.headersFilter = ^(NSURL *url, NSDictionary *headers) {
        
        NSFileManager *fm = [[NSFileManager alloc] init];
        NSString *imgKey = [SDWebImageManager.sharedManager cacheKeyForURL:url];
        NSString *imgPath = [SDWebImageManager.sharedManager.imageCache defaultCachePathForKey:imgKey];
        NSDictionary *fileAttr = [fm attributesOfItemAtPath:imgPath error:nil];
        
        NSMutableDictionary *mutableHeaders = [headers mutableCopy];
        
        NSDate *lastModifiedDate = nil;
        
        if (fileAttr.count > 0) {
            if (fileAttr.count > 0) {
                lastModifiedDate = (NSDate *)fileAttr[NSFileModificationDate];
            }
            
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
        
        NSString *lastModifiedStr = [formatter stringFromDate:lastModifiedDate];
        lastModifiedStr = lastModifiedStr.length > 0 ? lastModifiedStr : @"";
        [mutableHeaders setValue:lastModifiedStr forKey:@"If-Modified-Since"];
        
        return mutableHeaders;
    };
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:2 * 1024 * 1024
                                                            diskCapacity:100 * 1024 * 1024
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    //启动极光推送设置
    //garfunkel close[self startJPush:launchOptions];
    
    [self configureMAMap];
    
    [self configDB];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAppBack object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    //[APService registerDeviceToken:deviceToken];
    
    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    // [APService handleRemoteNotification:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];

   
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    // IOS 7 Support Required
    //[APService handleRemoteNotification:userInfo];
    
    [JPUSHService handleRemoteNotification:userInfo];
    [self handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    
//    // 取得 APNs 标准信息内容
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    // 取得Extras字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
//    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
//    //判断程序是否在前台运行
//    if (application.applicationState == UIApplicationStateActive) {
//        //如果应用在前台，在这里执行
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"外卖郎" message:content delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    
//    // iOS 7 Support Required,处理收到的APNS信息
//    //如果应用在后台，在这里执行
//    [self handleRemoteNotification:userInfo];
//
//    completionHandler(UIBackgroundFetchResultNewData);
//    
//    [JPUSHService setBadge:0];//清空JPush服务器中存储的badge值
//    [application setApplicationIconBadgeNumber:0];//小红点清0操作
    
//    NSLog(@"我他妈  是   推送 (7)     ！！！！！！！");
    

}


//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    else {
//        // 本地通知
//    }
//    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//  
//
//}
//
//
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//
//    // Required
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    else {
//        // 本地通知
//    }
//    completionHandler();  // 系统要求执行这个方法
//
//}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    NSRange range = [url.absoluteString rangeOfString:kQQAPP_ID];
    if (range.location != NSNotFound){
        return [TencentOAuth HandleOpenURL:url];
        
    }else
    return [WXApi handleOpenURL:url delegate:self];
}

//支付宝回调函数
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //if([url.description hasPrefix: @"com.wanmei.waimailanguser://wm.wm0530.com"]){
    if([url.description hasPrefix: @"com.vicisland://www.vicisland.com"]){
        // NSLog( @"%@",url.description);
        //获取当前控制器
        UINavigationController* currentController = self.mainTab.selectedViewController;
        NSMutableDictionary* arg = [[NSMutableDictionary alloc]init];
        NSArray* arrayParameter = [url.query componentsSeparatedByString: @"&"];
        [arrayParameter enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray* empty = [obj componentsSeparatedByString: @"="];
            [arg setObject:[empty lastObject] forKey:[empty firstObject]];
        }];
        if([url.path hasSuffix: @"store"]){
            NSString* rowID = [arg objectForKey: @"storeid"];
            if([WMHelper isEmptyOrNULLOrnil:rowID]){
                
            }else{
                MStore* item = [[MStore alloc]init];
                item.rowID = rowID;
                Store* controller = [[Store alloc] initWithItem:item];
                if([currentController.visibleViewController isMemberOfClass:[NewHome class]] || [currentController.visibleViewController isMemberOfClass:[Shopping class]]||[currentController.visibleViewController isMemberOfClass:[OrderVC class]]||[currentController.visibleViewController isMemberOfClass:[Mine class]]){
                    controller.hidesBottomBarWhenPushed = YES;
                }
                [currentController pushViewController:controller animated:YES];
            }
        }else if ([url.path hasSuffix: @"goods"]){
            NSString* rowID = [arg objectForKey: @"goodsid"];
            NSString* goodName = [arg objectForKey: @"goodsname"];
            if([WMHelper isEmptyOrNULLOrnil:rowID]){
                
            }else{
                Goods* controller = [[Goods alloc] initWithGoodsID:rowID goodsName:goodName];
                if([currentController.visibleViewController isMemberOfClass:[NewHome class]] || [currentController.visibleViewController isMemberOfClass:[Shopping class]]||[currentController.visibleViewController isMemberOfClass:[OrderVC class]]||[currentController.visibleViewController isMemberOfClass:[Mine class]]){
                    controller.hidesBottomBarWhenPushed = YES;
                }
                [currentController pushViewController:controller animated:YES];
            }
        }else if ([url.path hasSuffix: @"tuan"]){
            NSString* rowID = [arg objectForKey: @"tuanid"];
            if([WMHelper isEmptyOrNULLOrnil:rowID]){
                PintuangouVC * controller = [[PintuangouVC alloc]init];
                if([currentController.visibleViewController isMemberOfClass:[NewHome class]] || [currentController.visibleViewController isMemberOfClass:[Shopping class]]||[currentController.visibleViewController isMemberOfClass:[OrderVC class]]||[currentController.visibleViewController isMemberOfClass:[Mine class]]){
                    controller.hidesBottomBarWhenPushed = YES;
                }
                [currentController pushViewController:controller animated:YES];
            }else{
                FightGroupItem * controller = [[FightGroupItem alloc]initWithRowID:rowID];
                if([currentController.visibleViewController isMemberOfClass:[NewHome class]] || [currentController.visibleViewController isMemberOfClass:[Shopping class]]||[currentController.visibleViewController isMemberOfClass:[OrderVC class]]||[currentController.visibleViewController isMemberOfClass:[Mine class]]){
                    controller.hidesBottomBarWhenPushed = YES;
                }
                [currentController pushViewController:controller animated:YES];
            }
        }else if ([url.path hasSuffix: @"miaosha"]){
            NSString* rowID = [arg objectForKey: @"miaoshaid"];
            if([WMHelper isEmptyOrNULLOrnil:rowID]){
                
            }else{
                BuyNow * controller = [[BuyNow alloc]init];
                if([currentController.visibleViewController isMemberOfClass:[NewHome class]] || [currentController.visibleViewController isMemberOfClass:[Shopping class]]||[currentController.visibleViewController isMemberOfClass:[OrderVC class]]||[currentController.visibleViewController isMemberOfClass:[Mine class]]){
                    controller.hidesBottomBarWhenPushed = YES;
                }
                [currentController pushViewController:controller animated:YES];
            }
        }else if ([url.path hasSuffix: @"web"]){
            NSString* url = [arg objectForKey: @"url"];
            if([WMHelper isEmptyOrNULLOrnil:url]){
                
            }else{
                SVWebViewController * controller = [[SVWebViewController alloc]initWithURL:[NSURL URLWithString:url]];
                if([currentController.visibleViewController isMemberOfClass:[NewHome class]] || [currentController.visibleViewController isMemberOfClass:[Shopping class]]||[currentController.visibleViewController isMemberOfClass:[OrderVC class]]||[currentController.visibleViewController isMemberOfClass:[Mine class]]){
                    controller.hidesBottomBarWhenPushed = YES;
                }
                [currentController pushViewController:controller animated:YES];
            }
            
        }else{
            
        }
        return YES;
    }
    
//    支付宝支付成功返回
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
             //NSLog(@"支付宝成功回调的接口result = %@",resultDic);
            
        }];
        return YES;
    }
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if(result){
        return result;
    }
    NSRange range = [url.absoluteString rangeOfString:kQQAPP_ID];
    if (range.location != NSNotFound)
    return [TencentOAuth HandleOpenURL:url];
    else
    
    return [WXApi handleOpenURL:url delegate:self];
}

//garfunkel add
-(void)setLanguage{
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]) {
        
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *language = [languages objectAtIndex:0];
        
        if ([language hasPrefix:@"zh-"]) {
            //开头匹配
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
        }
    }
    NSLog(@"garfunkel_log:**language-%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"]);
}
#pragma mark =====================================================  设置极光推送
-(void)startJPush:(NSDictionary*)launchOptions{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert) categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert) categories:nil];
    }
    
    //  [JPUSHService setupWithOption:launchOptions];
    //极光推送
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:nil
                 apsForProduction:false  advertisingIdentifier:advertisingId];
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(networkDidLogin:)
//                                                 name:kJPFNetworkDidCloseNotification
//                                               object:nil];
    
}


//- (void)networkDidLogin:(NSNotification *)notification {
//    NSLog(@"已登录");
//    [JPUSHService setAlias:@"123456" callbackSelector:nil object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:kJPFNetworkDidCloseNotification
//                                                  object:nil];
//}




#pragma mark =====================================================  启动友盟设置友盟
-(void)startUMeng{
    UMConfigInstance.appKey = kYouMengAppKey;
    UMConfigInstance.channelId = @"App Store";
    //UMConfigInstance.eSType = E_UM_GAME; // 仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];
    
    [self registeUMShare];
}
- (void)registeUMShare
{
    /**/
    [UMSocialData openLog:NO];
    [UMSocialData setAppKey:kYouMengAppKey];
    [UMSocialQQHandler setQQWithAppId:kQQAPP_ID appKey:kQQAPP_KEY url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:kWXAPP_ID appSecret:kWXAPP_SECRET url:@"http://www.umeng.com/social"];
    
}

#pragma mark =====================================================  UIAlertView 协议实现
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        // 此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", kStoreAppId]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark =====================================================  UITabBarController 协议实现
//调用导航控制器前 判断用户是否可以选中此控制器
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger seletedIndex = viewController.tabBarItem.tag;
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger previousIndex  = [[userDefault objectForKey:kNoLoginMemoryPreviousTabIndex]integerValue];
    //用户未登陆不能进入
    if(![MSingle shareAuhtorization].userInfo.isLogin && (seletedIndex==3||seletedIndex==1||seletedIndex==2)){
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        
        [tabBarController.viewControllers[previousIndex] presentViewController:nav animated:YES completion:nil];
        return NO;
    }else{
        [userDefault setObject:@(seletedIndex) forKey:kNoLoginMemoryPreviousTabIndex];
        [userDefault synchronize];
    }
    return YES;
}

#pragma mark =====================================================  全局样式设置
-(void)setWholeStyle{
    
    
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.f]};
    [[UINavigationBar appearance]  setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:theme_default_color];
    
    
    
    [[UIToolbar appearance] setBackgroundColor:theme_navigation_color];
    [[UIToolbar appearance] setBarTintColor:theme_navigation_color];
    [[UIToolbar appearance] setTintColor:theme_default_color];
    
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    //设置分栏按钮title默认颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:11.f]} forState:UIControlStateNormal];
    //设置分栏按钮title选中颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:theme_navigation_color,NSFontAttributeName:[UIFont systemFontOfSize:11.f]} forState:UIControlStateSelected];
    
    [[UITableView appearance] setBackgroundColor:theme_table_bg_color];
    [[UICollectionView appearance] setBackgroundColor:theme_table_bg_color];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    [manager disableDistanceHandlingInViewControllerClass:[Home class]];
    [manager disableDistanceHandlingInViewControllerClass:[RandomBuy class]];
    [[IQToolbar appearance] setBarTintColor:theme_navigation_color];
    [[IQToolbar appearance] setTintColor:theme_default_color];
    
}

-(void)registerThirdParty{
    [WXApi registerApp:@"wx8b65930e48974b35"];
}
#pragma mark =====================================================  配置高德地图
-(void)configureMAMap{
    [AMapServices sharedServices].apiKey = kMAMapAPIKey;
    
}

-(void)configDB{
    
    
    [FMDBHelper setDataBaseName:@"DBBuyAddress.db"];
    
    
    BOOL flag = [FMDBHelper createTable: @"CREATE TABLE IF NOT EXISTS tableBuyAddress (rowID integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, address text NOT NULL,mapLat text NOT NULL,mapLng text NOT NULL);"];
    if(flag){
        // NSLog( @"tableBuyAddress create success");
    }else{
        // NSLog( @"tableBuyAddress create fail");
    }
}
#pragma mark =====================================================  ShareSDK
-(void)registerShareSDK{
    /*  [ShareSDK registerApp:@"144719fb78c66"
     
     activePlatforms:@[
     @(SSDKPlatformTypeWechat),
     @(SSDKPlatformTypeQQ)
     ]
     onImport:^(SSDKPlatformType platformType)
     {
     switch (platformType)
     {
     
     case SSDKPlatformTypeWechat:
     [ShareSDKConnector connectWeChat:[WXApi class]];
     break;
     case SSDKPlatformTypeQQ:
     [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
     break;
     default:
     break;
     }
     }
     onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
     
     switch (platformType)
     {
     case SSDKPlatformTypeWechat:
     [appInfo SSDKSetupWeChatByAppId:@"wxa63756a88befb156"
     appSecret:@"0704a2d0add2c688e3b9db94c335d591"];
     break;
     case SSDKPlatformTypeQQ:
     [appInfo SSDKSetupQQByAppId:@"1104837305"
     appKey:@"nleKvzmwkzwIIFwh"
     authType:SSDKAuthTypeBoth];
     break;
     default:
     break;
     }
     }];*/
}

#pragma mark =====================================================  WXApi 协议实现
-(void)onResp:(BaseReq *)resp
{
    if([resp isKindOfClass:[SendAuthResp class]])
    {
        
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (aresp.errCode== 0) {
            NSString *code = aresp.code;
            [self getAccess_token:code];
        }
    }else{
        NSString *strMsg;
        NSString *strTitle;
        if([resp isKindOfClass:[PayResp class]]){
            //支付返回结果，实际支付结果需要去微信服务器端查询
            strTitle = [NSString stringWithFormat:@"%@", Localized(@"Payment_result")];
            PayResp *aresp = (PayResp *)resp;
            
            switch (aresp.errCode) {
                    case WXSuccess:
                {
                    strMsg = [NSString stringWithFormat:@"%@:%@",Localized(@"Payment_result"),Localized(@"Success_txt") ];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:strMsg];
                }
                    break;
                    case WXErrCodeUserCancel:
                {
                    strMsg = Localized(@"User_cancel_pay");
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayUserCancel object:strMsg];
                }
                    break;
                    case WXErrCodeCommon:
                    case WXErrCodeUnsupport:
                    case WXErrCodeSentFail:
                    case WXErrCodeAuthDeny:
                {
                    strMsg = Localized(@"Payment_error");
                    // NSLog(@"错误，retcode = %d, retstr = %@", aresp.errCode,aresp.errStr);
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayFailure object:strMsg];
                }
                    break;
                default:
                {
                    strMsg = Localized(@"Payment_error");
                    //NSLog(@"错误，retcode = %d, retstr = %@", aresp.errCode,aresp.errStr);
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayFailure object:strMsg];
                }
                    break;
            }
        }
        /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];*/
        
    }
}

-(void)getAccess_token:(NSString*)code
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
                 "expires_in" = 7200;
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
                 scope = "snsapi_userinfo,snsapi_base";
                 }
                 */
                
                NSString* accessToken = [dic objectForKey:@"access_token"];
                NSString* openID = [dic objectForKey:@"openid"];
                [self getUserInfo:accessToken openID:openID];
                
            }
        });
    });
}

-(void)getUserInfo:(NSString*)accessToken openID:(NSString*)openID
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openID];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonWXLoginAuthorization object:dic];
            }
        });
        
    });
}


#pragma mark =====================================================  加载引导页
-(void)startGuide{
    
    if([self isFirstLunch])
    [self loadGuidanceView];
}

- (BOOL)isFirstLunch
{
    BOOL ret = YES;
    do {
        NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:@"isfirst"];
        NSInteger isfirst = [string integerValue];
        if (isfirst==1) {
            ret = NO;
        }
    } while (0);
    return ret;
}
- (void)loadGuidanceView
{
    NSArray* arrayImg = nil;
    if(IS_IPHONE_4_OR_LESS)
    arrayImg=@[@"00005@2x",@"0004@2x",@"004@2x",@"04@2x"];
    else if (IS_IPHONE_5)
    arrayImg=@[@"00001-568h@2x",@"0001-568h@2x",@"001-568h@2x",@"01-568h@2x"];
    else if (IS_IPHONE_6)
    arrayImg=@[@"00002-667h@2x",@"0002-667h@2x",@"002-667h@2x",@"02-667h@2x"];
    else
    arrayImg=@[@"00003-736h@3x",@"0003-736h@3x",@"003-736h@3x",@"03-736h@3x"];
    GuidanceView *guidance = [[GuidanceView alloc] initWithImages:arrayImg andFinishBlock:^(GuidanceView *guidance){
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isfirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }];
    [guidance showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark =====================================================  远程通知
/**
 *  接收通知
 *
 *  @param remoteInfo
 */
-(void)handleRemoteNotification:(NSDictionary *)remoteInfo{
    //NSLog(@"通知:%@",remoteInfo);
    if(![WMHelper isNULLOrnil:remoteInfo])
    {
        if([@"at" isEqualToString:[remoteInfo objectForKey: @"send_type"]]){
            //获取当前控制器
            UINavigationController* empty = self.mainTab.selectedViewController;
            
            if(self.mainTab.selectedIndex == 2){
                if([empty.visibleViewController isMemberOfClass:[OrderVC class]]){
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshOrder object:nil];
                }else{
                    [empty popToRootViewControllerAnimated:YES];
                }
            }else{
                //设置控制器索引
                self.mainTab.selectedIndex = 2;
            }
        }
    }
}




@end
