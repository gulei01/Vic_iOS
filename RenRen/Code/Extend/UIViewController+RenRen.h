//
//  UIViewController+RenRen.h
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#import <UIKit/UIKit.h>
#import "MSingle.h"
#import "MAddress.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>


@interface UIViewController (RenRen)<MBProgressHUDDelegate>

@property(nonatomic,strong) MBProgressHUD* HUD;

@property(nonatomic,strong,readonly) MSingle* Identity;

@property(nonatomic,assign) BOOL firstLoad;

-(void)setCacheDefaultAddres:(MAddress*)address;
-(MAddress*)getCacheDefaultAddress;



-(void)showHUD;
-(void)showHUD:(NSString*)message;

-(void)hidHUD;
-(void)hidHUD:(NSString*)message;
-(void)hidHUD:(NSString*)message complete:(dispatch_block_t) complete;
-(void)hidHUD:(NSString*)message success:(BOOL)success;
-(void)hidHUD:(NSString*)message success:(BOOL)success complete:(dispatch_block_t) complete;

-(void)alertHUD:(NSString*)message;
-(void)alertHUD:(NSString*)message complete:(dispatch_block_t) complete;
-(void)alertHUD:(NSString *)message delay:(NSTimeInterval)delay;

-(void)checkNetWorkState:(void (^)(AFNetworkReachabilityStatus netWorkStatus))complete;
 
//-(void)clearCache;

@end
