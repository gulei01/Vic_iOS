//
//  AppDelegate.h
//  RenRen
//
//  Created by kyjun on 15/10/29.
//
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "MAddress.h"
#import <TencentOpenAPI/TencentOAuth.h>


static NSString *appKey = @"72646590972c7cf19f53a1b3";
static NSString *channel = @"https://www.tutti.app";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  全局变量 存储默认的收货地址
 */
@property(nonatomic,strong) MAddress* globalAddress;

@end

