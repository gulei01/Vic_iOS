//
//  Login.m
//  KYRR
//
//  Created by kyjun on 15/11/2.
//
//

#import "Login.h"
#import "WXApi.h"
#import "MMember.h"

#import "AppDelegate.h"


@interface Login ()


@property(nonatomic,strong) UIButton* btnQQ;
@property(nonatomic,strong) UIButton* btnWeChat;
@property(nonatomic,strong) TencentOAuth*  tencentOAuth;

@property(nonatomic,strong) UIImageView *backView;

@property(nonatomic,strong) UIView *myView;

@end

@implementation Login

-(instancetype)init{
    self = [super init];
    if(self){
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self layoutUI];
    [self layoutUIConstains];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weChatLoginAuthorization:) name:NotificatonWXLoginAuthorization object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(![WXApi isWXAppInstalled]){
        self.btnWeChat.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  UI布局


-(void)layoutUI{

    
    _backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_backView setImage:[UIImage imageNamed:@"首页"]];
    _backView.userInteractionEnabled = YES;
    [self.navigationController.view addSubview:_backView];
    
    
     CGFloat itemW = 150;
     CGFloat itemH = 0;
    
    UIImage *img = [UIImage imageNamed:@"未标题-1"];
    itemH = itemW *img.size.height/img.size.width;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-itemW)/2, 150, itemW, itemH)];
    
    [imgView setImage:img];
    imgView.backgroundColor = [UIColor clearColor];
    [_backView addSubview:imgView];
    
    
    UIButton *btn =  [[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 20)];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backView addSubview:btn];
    
    
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 20, 20, 40, 25)];
//    lable.text = @"登录";
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.textColor = [UIColor whiteColor];
//    
//    [_backView addSubview:lable];
    
    _myView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 170, SCREEN_WIDTH, 100)];
    _myView.backgroundColor = [UIColor clearColor];
    _myView.userInteractionEnabled = YES;
    [_backView addSubview:_myView];
    
    self.btnQQ = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnQQ setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [self.btnQQ addTarget:self action:@selector(QQLoginTouch:) forControlEvents:UIControlEventTouchUpInside];

    
    self.btnWeChat = [ UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnWeChat setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
    [self.btnWeChat addTarget:self action:@selector(weiXinLoginTouch:) forControlEvents:UIControlEventTouchUpInside];

    [_myView addSubview:_btnQQ];
    
    [_myView addSubview:_btnWeChat];
    
}

- (void)layoutUIConstains {

    self.btnQQ.translatesAutoresizingMaskIntoConstraints =NO ;
    self.btnWeChat.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.btnQQ addConstraint:[NSLayoutConstraint constraintWithItem:self.btnQQ attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.btnQQ addConstraint:[NSLayoutConstraint constraintWithItem:self.btnQQ attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.myView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnQQ attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.myView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.f]];
    [self.myView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnQQ attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.myView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:SCREEN_WIDTH/2-100]];
    
    
    
    [self.btnWeChat addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeChat attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.btnWeChat addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeChat attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.myView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeChat attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.myView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.f]];
    [self.myView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnWeChat attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.myView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-SCREEN_WIDTH/2+100]];
}

#pragma mark =====================================================  通知
-(void)weChatLoginAuthorization:(NSNotification*)notification{
    NSDictionary* dict = [notification object];
    NSString* nickName = [dict objectForKey:@"nickname"];
    NSString* openID = [dict objectForKey:@"openid"];
    NSString* avatar = [dict objectForKey:@"headimgurl"];
    // 实现平台统一将openid 改成 unionid 的值
    openID = [dict objectForKey:@"unionid"];
    
    [self thirdPartyLogin:nickName openID:openID face:avatar type:2];
}

#pragma mark =====================================================  SEL
-(IBAction)closeView:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)QQLoginTouch:(id)sender{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            self.tencentOAuth= [[TencentOAuth alloc] initWithAppId:kQQAPP_ID andDelegate:self];
            NSArray  *permissions =  [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
            [self.tencentOAuth authorize:permissions inSafari:NO];
            [self.tencentOAuth accessToken] ;
            [self.tencentOAuth openId] ;
                    }
    }];
    
}

-(IBAction)weiXinLoginTouch:(id)sender{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            SendAuthReq* req =[[SendAuthReq alloc ] init ];
            req.openID = @"wxa63756a88befb156";
            req.scope = @"snsapi_userinfo" ;
            req.state = @"123" ;
            //第三方向微信终端发送一个SendAuthReq消息结构
            [WXApi sendReq:req];
        }
    }];
}
#pragma mark =====================================================  TencentSessionDelegate 协议实现
- (void)tencentDidLogin{
    [self.tencentOAuth getUserInfo];
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled)
    {
        [self alertHUD:@"用户取消登陆"];
    }
    else
    {
        [self alertHUD:@"登陆失败"];
    }
    
}

- (void)tencentDidNotNetWork{
    [self alertHUD:@"网络异常"];
}

-(void)getUserInfoResponse:(APIResponse *)response{
    //NSLog(@"%@",[response jsonResponse]);
    NSInteger flag = [[response.jsonResponse objectForKey:@"ret"] integerValue];
    if(flag == 0){
        NSString* openID = self.tencentOAuth.openId;
        NSString* nick = [response.jsonResponse objectForKey:@"nickname"];
        NSString* face = [response.jsonResponse objectForKey:@"figureurl_qq_2"];
        [self thirdPartyLogin:nick openID:openID face:face type:1];
    }else {
        [self alertHUD:@"授权失败"];
    }
}

#pragma mark =====================================================  绑定极光推送

-(void)registerTagsWithAlias:(NSString*)userID{
    
    __autoreleasing NSMutableSet *tags = [NSMutableSet set];
    __autoreleasing NSString *alias = userID;
    [self analyseInput:&alias tags:&tags];
    
    [JPUSHService setTags:tags alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        //NSLog(@"TagsAlias回调:\n iResCode:%d  iAlias:%@",iResCode,iAlias);
        if(iResCode == 0){
            
        }else{
            /* UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:@"消息推送注册失败,请退出后再登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [alert show];*/
        }
    }];
}

- (void)setTags:(NSMutableSet **)tags addTag:(NSString *)tag {
    [*tags addObject:tag];
}

- (void)analyseInput:(NSString **)alias tags:(NSSet **)tags {
    // alias analyse
    if (![*alias length]) {
        // ignore alias
        *alias = nil;
    }
    // tags analyse
    if (![*tags count]) {
        *tags = nil;
    } else {
        __block int emptyStringCount = 0;
        [*tags enumerateObjectsUsingBlock:^(NSString *tag, BOOL *stop) {
            if ([tag isEqualToString:@""]) {
                emptyStringCount++;
            } else {
                emptyStringCount = 0;
                *stop = YES;
            }
        }];
        if (emptyStringCount == [*tags count]) {
            *tags = nil;
        }
    }
}
#pragma mark =====================================================  私有方法
-(void)thirdPartyLogin:(NSString*)nick openID:(NSString*)openID face:(NSString*)face type:(NSInteger)type{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.minSize = CGSizeMake(135.f, 135.f);
    [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
    self.HUD.labelText = @"正在登录!";
    [self.HUD show:YES];
    
    
    NSDictionary* arg = @{@"ince":@"the_third_reg",@"nickname":nick,@"openid":openID,@"face_pic":face,@"type":[WMHelper integerConvertToString:type]};
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories login:arg complete:^(NSInteger react, id obj, NSString *message) {
        if(react == 1){
            MMember* entity = (MMember*)obj;
            entity.isLogin = YES;
            Boolean flag= [NSKeyedArchiver archiveRootObject:entity toFile:[WMHelper archiverPath]];
            if(flag){
                NSUserDefaults* config = [NSUserDefaults standardUserDefaults];
                [config setObject:@(YES) forKey:kisBindingJPushTag];
                [config synchronize];
                [self registerTagsWithAlias:self.Identity.userInfo.userID];
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationLoginSuccess object:nil];
            }else{
               // NSLog(@"%@",@"归档失败!");
            }
            [self hidHUD:@"登录成功" success:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if(react == 400){
            [self hidHUD:message];
        }else{
            [self hidHUD:message];
        }
    }];
    
    
}


@end
