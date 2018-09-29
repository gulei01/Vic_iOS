//
//  Mine.m
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#import "Mine.h"
#import "Address.h"
#import "RedEnvelopes.h"
#import "Feedback.h"
#import "BusinessCooperation.h"
#import <SVWebViewController/SVWebViewController.h>
#import "About.h"
#import "PointsMall.h"
#import "MyTuan.h"
#import "Language.h"

@interface Mine ()<UIAlertViewDelegate>

@property(nonatomic,strong) UIView* headerView;
@property(nonatomic,strong) UIImageView* PhotoAvatar;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UIButton* btnLogout;
@property(nonatomic,strong) UILabel* labelPoint;

@property(nonatomic,strong) NSArray* arrayData;
@property(nonatomic,strong) NSArray* arrayImage;

@property(nonatomic,strong) UIAlertView* alertClear;

#define heightView 70
#define iconSize 20
#define iconSpace 15

@end

@implementation Mine
-(instancetype)init{
    self = [super init];
    if(self){
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab-mine-default"]];
        [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab-mine-enter"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self.tabBarItem setTitle:Localized(@"My_txt")];
        self.tabBarItem.tag=3;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = Localized(@"Personal_center");
    
//    self.arrayData = @[@"管理地址",@"我的优惠券", @"我的拼团",@"积分商城",@"意见反馈",@"商务合作",@"帮助中心",@"关于我们", @"清除本地缓存"];
    self.arrayData = @[Localized(@"Manager_address"),Localized(@"My_coupon"),Localized(@"About_us"),Localized(@"Language"), Localized(@"Clear_cache")];
//    self.arrayImage = @[@"icon-address",@"icon-red",@"icon-mytuan",@"icon-points",@"icon-feedback",@"icon-together",@"icon-help-mine",@"icon-about", @"icon-del"];
    self.arrayImage = @[@"icon-address",@"icon-red",@"icon-about",@"icon-help-mine", @"icon-del"];
    
    
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.PhotoAvatar sd_setImageWithURL:[NSURL URLWithString:self.Identity.userInfo.avatar]  placeholderImage:[UIImage imageNamed:kDefaultImage]];
    self.labelName.text = self.Identity.userInfo.userName;
    [self queryData];
    [self changeNavigationBarBackgroundColor:theme_navigation_color];
    
    [self updateTableText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTableText{
    self.arrayData = @[Localized(@"Manager_address"),Localized(@"My_coupon"),Localized(@"About_us"),Localized(@"Language"), Localized(@"Clear_cache")];
    [self.tableView reloadData];
}

-(void)layoutUI{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*5/8 + heightView)];
//    设置背景图片
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*5/8)];
    bgImgView.image = [UIImage imageNamed:@"lALO0Rw7a80B2s0C7g_750_474.png_620x10000q90g.jpg"];
    bgImgView.userInteractionEnabled = NO;
    [self.headerView addSubview:bgImgView];
    
    [self addPrivate];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.PhotoAvatar = [[UIImageView alloc]init];
    
    self.PhotoAvatar.layer.cornerRadius= 5.f;
    self.PhotoAvatar.layer.masksToBounds = YES;
    [self.headerView addSubview:self.PhotoAvatar];
    
    
    self.labelName =[[ UILabel alloc]init];
    self.labelName.textAlignment = NSTextAlignmentCenter;
    self.labelName.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.labelName];
    
    self.btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnLogout setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnLogout setTitle:Localized(@"Log_out") forState:UIControlStateNormal];
    self.btnLogout.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.btnLogout addTarget:self action:@selector(logoutTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.btnLogout];
    
    self.labelPoint = [[UILabel alloc]init];
    self.labelPoint.textAlignment = NSTextAlignmentCenter;
    self.labelPoint.textColor = theme_title_color;
    self.labelPoint.text = [NSString stringWithFormat:@"%@  %@: 0",Localized(@"Ordin_member"),Localized(@"Integral_txt")];
    [self.headerView addSubview:self.labelPoint];
    
    
    self.tableView.tableHeaderView = self.headerView;
    
}

#pragma mark ====================================== 自己更改
- (void)addPrivate {
    
//        lineView.image = [UIImage imageNamed:@"line-vertical-home"];
        float widthView = SCREEN_WIDTH/2;
        float widthSmall = 4;
        float widthLine = 0.7;
        for (int i = 0; i < 2; i ++) {
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(widthView *i, SCREEN_WIDTH*5/8, widthView, heightView)];
            view.backgroundColor = [UIColor whiteColor];
            
            UIImageView *iconView = [[UIImageView alloc]init];
            [iconView setFrame:CGRectMake(iconSpace, heightView/3, iconSize, iconSize)];
            iconView.image = [UIImage imageNamed:_arrayImage[i]];
            [view addSubview:iconView];
            
            UIImageView *lineViewRight = [[UIImageView alloc]initWithFrame:CGRectMake( widthView - widthLine, 0, widthLine, heightView)];
            lineViewRight.image = [UIImage imageNamed:@"line-vertical-home"];
            [view addSubview:lineViewRight];
            
            UIImageView *lineViewDown = [[UIImageView alloc]initWithFrame:CGRectMake( 0, heightView- widthLine, widthView, widthLine)];
            lineViewDown.image = [UIImage imageNamed:@"line-near-store"];
            [view addSubview:lineViewDown];
            
            UIImageView *lineViewUp = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, widthView, widthLine)];
            lineViewUp.image = [UIImage imageNamed:@"line-near-store"];
            [view addSubview:lineViewUp];
            
            UIImageView *lineViewLeft = [[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, widthLine, heightView)];
            lineViewLeft.image = [UIImage imageNamed:@"line-near-store"];
            [view addSubview:lineViewLeft];
            
            UILabel *iconLable = [[UILabel alloc]init];
            float w = widthView - iconSize - 2*iconSpace;
            [iconLable setFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+5, heightView/3 - widthSmall, w, iconSize + 2*widthSmall)];
            iconLable.text = self.arrayData[i];
            iconLable.textAlignment = NSTextAlignmentCenter;
            [view addSubview:iconLable];
    
            view.tag = i + 1;
    
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTouch:)];
            [view addGestureRecognizer:gesture];
            [self.headerView addSubview:view];
            
        }
    

}

- (void)viewTouch:(UITapGestureRecognizer *)gesture {
    UIImageView *view = (UIImageView *)gesture.view;
    switch (view.tag) {
        case 1:
        {
            Address* controller = [[Address alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:
        {
            RedEnvelopes* controller = [[RedEnvelopes alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
            break;
//        case 3:
//        {
//            MyTuan* controller = [[MyTuan alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
            }



}


-(void)layoutConstraints{
    
    self.PhotoAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnLogout.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPoint.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.PhotoAvatar addConstraint:[NSLayoutConstraint constraintWithItem:self.PhotoAvatar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.PhotoAvatar addConstraint:[NSLayoutConstraint constraintWithItem:self.PhotoAvatar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.PhotoAvatar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTop multiplier:10 constant:30.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.PhotoAvatar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/5]];
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.PhotoAvatar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
    [self.btnLogout addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
    [self.btnLogout addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.PhotoAvatar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLogout attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.self.labelName attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelPoint addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/3]];
    [self.labelPoint addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
    
}

-(void)changeNavigationBarBackgroundColor:(UIColor *)barBackgroundColor{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *subviews =self.navigationController.navigationBar.subviews;
        for (id viewObj in subviews) {
            if (ISIOS10) {
                //iOS10,改变了状态栏的类为_UIBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UIBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.hidden=YES;
                }
            }else{
                //iOS9以及iOS9之前使用的是_UINavigationBarBackground
                NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
                if ([classStr isEqualToString:@"_UINavigationBarBackground"]) {
                    UIImageView *imageView=(UIImageView *)viewObj;
                    imageView.hidden=YES;
                }
            }
        }
        UIImageView *imageView = [self.navigationController.navigationBar viewWithTag:111];
        if (!imageView) {
            imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 64)];
            imageView.tag = 111;
            [imageView setBackgroundColor:barBackgroundColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController.navigationBar insertSubview:imageView atIndex:0];
            });
        }else{
            [imageView setBackgroundColor:barBackgroundColor];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController.navigationBar sendSubviewToBack:imageView];
            });
            
        }
        
    }
}

#pragma mark =====================================================  DataSource
-(void)queryData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary* arg = @{@"ince":@"get_user_info",@"uid":self.Identity.userInfo.userID};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
            if(react == 1){
                NSDictionary* dict = [response objectForKey:@"info"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.labelPoint.text = [NSString stringWithFormat:@"%@  %@: %@",[dict objectForKey:@"level"],Localized(@"Integral_txt"),[dict objectForKey:@"credit"]];
                });
                
            }else if(react == 400){
                [self alertHUD:message];
            }else{
                self.labelPoint.text = [NSString stringWithFormat:@"%@  %@: 0",Localized(@"Ordin_member"),Localized(@"Integral_txt")];
                [self alertHUD:message];
            }
        }];
    });
}


#pragma mark =====================================================  UITableView 协议实现

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayData.count - 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    if(![WMHelper isEmptyOrNULLOrnil:self.arrayImage[indexPath.row]]){
        [cell.imageView setImage:[UIImage imageNamed:self.arrayImage[indexPath.row+2]]];
    }
    if(indexPath.row == 1){//语言
        NSString* languageName = [[[NSUserDefaults standardUserDefaults]objectForKey:@"appLanguage"] isEqualToString:@"zh-Hans"] ? languageName_zh : languageName_en;
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.arrayData[indexPath.row+2],languageName];
    }else{
        cell.textLabel.text = self.arrayData[indexPath.row+2];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row + 3) {
//        case 3:
//        {
//            PointsMall* controller = [[PointsMall alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
//
//        case 4:
//        {
//            Feedback* controller = [[Feedback alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
//
//        case 5:
//        {
////            BusinessCooperation* controller = [[BusinessCooperation alloc]init];
////            controller.hidesBottomBarWhenPushed = YES;
////            [self.navigationController pushViewController:controller animated:YES];
//
//            NSURL *URL = [NSURL URLWithString:@"http://wm.wm0530.com/Mobile/re/user_about"];
//            SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
//            webViewController.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:webViewController animated:YES];
//        }
//            break;
//
//        case 6:
//        {
//            NSURL *URL = [NSURL URLWithString:@"http://wm.wm0530.com/Mobile/re/user_help"];
//            SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
//            webViewController.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:webViewController animated:YES];
//        }
//            break;
        case 3:
        {
            About* controller = [[About alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4:
        {
            Language* controller = [[Language alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 5:
        {
            if(!self.alertClear){
                self.alertClear = [[UIAlertView alloc] initWithTitle:nil message:Localized(@"Want_to_clear_cache") delegate:self cancelButtonTitle:Localized(@"Cancel_txt") otherButtonTitles:Localized(@"Confirm_txt"), nil];
            }
            [self.alertClear show];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark =====================================================  SEL
-(IBAction)logoutTouch:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:Localized(@"Want_to_logout") delegate:self cancelButtonTitle:Localized(@"Cancel_txt") otherButtonTitles:Localized(@"Confirm_txt"), nil];
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == self.alertClear){
        if (buttonIndex==1){
            //[[SDImageCache sharedImageCache] cleanDisk];
            //[[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:NULL];
            [[SDImageCache sharedImageCache] clearMemory];
            //[[[SDWebImageManager sharedManager] imageCache] clearDisk];
            [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:NULL];
            [[[SDWebImageManager sharedManager] imageCache] clearMemory];
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            [self alertHUD: Localized(@"Clear_complete")];
        }
    }else{
        if (buttonIndex==1){
            self.HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
            [self.view.window addSubview:self.HUD];
            self.HUD.delegate = self;
            self.HUD.minSize = CGSizeMake(135.f, 135.f);
            [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
            
            [self.HUD show:YES];
            
            MMember* entity = self.Identity.userInfo;
            entity.isLogin = NO;
            Boolean flag= [NSKeyedArchiver archiveRootObject:entity toFile:[WMHelper archiverPath]];
            if(flag){
                [self logoutJPush:self.Identity.userInfo.userID];
                self.HUD.labelText = Localized(@"Logout_success");
                [self.HUD hide:YES afterDelay:1];
                [self changeTab];
            }else{
                self.HUD.labelText = Localized(@"Logout_fail");
                [self.HUD hide:YES afterDelay:1];
            }
        }
    }
}
-(void)changeTab{
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLogout object:nil];
    self.tabBarController.selectedIndex=0;
}

#pragma mark =====================================================  注销极光推送
-(void)logoutJPush:(NSString*)userID{
    __autoreleasing NSMutableSet *tags = [NSMutableSet set];
    __autoreleasing NSString *alias = @"";
    
    [JPUSHService setTags:tags alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        //NSLog(@"TagsAlias回调: iResCode:%d  iAlias:%@",iResCode,iAlias);
        if(iResCode == 0){
            // NSLog( @"====================");
        }else{
            //self.HUD.labelText = @"消息推送退出失败";
            [self.HUD hide:YES afterDelay:1];
        }
    }];
}

@end
