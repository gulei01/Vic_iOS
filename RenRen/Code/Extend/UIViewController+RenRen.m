//
//  UIViewController+RenRen.m
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#import "UIViewController+RenRen.h"
#import <objc/runtime.h>

static char const * const rrHUD =  "HUD";
static char const * const rrFirstLoad =  "firstLoad";
static NSBundle *bundle = nil;


@implementation UIViewController (RenRen)
@dynamic HUD,Identity;

-(MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, rrHUD);
}

-(void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, rrHUD, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)firstLoad{
    return [objc_getAssociatedObject(self, rrFirstLoad) boolValue];
}

-(void)setFirstLoad:(BOOL)firstLoad{
    objc_setAssociatedObject(self, rrFirstLoad, [NSNumber numberWithBool:firstLoad], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MSingle *)Identity{
    return [MSingle shareAuhtorization];
}


-(void)setCacheDefaultAddres:(MAddress *)address{
    NSCache* cache = [[NSCache alloc]init];
    [cache setObject:address forKey:kDefaultAddress];
}

-(MAddress *)getCacheDefaultAddress{
    NSCache* cache = [[NSCache alloc]init];
    return   [cache objectForKey:kDefaultAddress];
}


-(void)showHUD{
    if (self.HUD) {
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.minSize = CGSizeMake(135.f, 135.f);
    [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
    [self.HUD show:YES];
}
-(void)showHUD:(NSString*)message{
    if (self.HUD) {
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }
    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.minSize = CGSizeMake(135.f, 135.f);
    [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
    [self.HUD setLabelText:message];
    [self.HUD show:YES];
}

-(void)hidHUD{
    if (self.HUD) {
        [self.HUD hide:YES];
        self.HUD=nil;
    }
}
-(void)hidHUD:(NSString*)message{
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = message;
    [self.HUD hide:YES afterDelay:1];
}

-(void)hidHUD:(NSString *)message complete:(dispatch_block_t)complete{
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = message;
    [self.HUD hide:YES afterDelay:1];
    complete();
}

-(void)hidHUD:(NSString*)message success:(BOOL)success{
    if (success) {
        self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
    }else{
        self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
    }
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = message;
    [self.HUD hide:YES afterDelay:1];
}

-(void)hidHUD:(NSString*)message success:(BOOL)success complete:(dispatch_block_t) complete{
    if (success) {
        self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
    }else{
        self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
    }
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = message;
    [self.HUD hide:YES afterDelay:1];
    complete();
}

-(void)alertHUD:(NSString*)message{
    self.HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = message;
    [self.HUD setLabelFont:[UIFont systemFontOfSize:12]];
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD hide:YES afterDelay:0.5];
}

-(void)alertHUD:(NSString*)message complete:(dispatch_block_t) complete{
    self.HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = message;
    [self.HUD setLabelFont:[UIFont systemFontOfSize:12]];
    self.HUD.removeFromSuperViewOnHide = YES;
    complete();
    [self.HUD hide:YES afterDelay:1];
}
-(void)alertHUD:(NSString *)message delay:(NSTimeInterval)delay{
    self.HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = message;
    [self.HUD setLabelFont:[UIFont systemFontOfSize:12]];
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD hide:YES afterDelay:delay];
}
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [hud removeFromSuperview];
    hud = nil;
}
-(void)checkNetWorkState:(void (^)(AFNetworkReachabilityStatus netWorkStatus))complete{
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable)
            [self alertHUD:Localized(@"Net_anomaly")];
        complete(status);
    }];
}

-(void)clearCache{
//    [[SDImageCache sharedImageCache] cleanDisk];
//    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:NULL];
    [[SDImageCache sharedImageCache] clearMemory];
//    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:NULL];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}

@end
