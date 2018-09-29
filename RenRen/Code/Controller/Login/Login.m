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
#import "Reg.h"

#import "AppDelegate.h"


@interface Login ()


@property(nonatomic,strong) UIButton* btnQQ;
@property(nonatomic,strong) UIButton* btnWeChat;
@property(nonatomic,strong) TencentOAuth*  tencentOAuth;

@property(nonatomic,strong) UIImageView *backView;

@property(nonatomic,strong) UIView *myView;
//garfunkel add
@property(nonatomic,strong) UIView *inputView;

@property(nonatomic,strong) UILabel *mobileLabel;
@property(nonatomic,strong) UILabel *passwordLabel;
@property(nonatomic,strong) UITextField *mobileText;
@property(nonatomic,strong) UITextField *passwordText;

@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,strong) UIButton *regBtn;


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
    self.title = Localized(@"Log_in");
    [self layoutUI];
    [self layoutUIConstains];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weChatLoginAuthorization:) name:NotificatonWXLoginAuthorization object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(regReturn) name:NotificationRegSuuccess object:nil];
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
    [btn setTitle:Localized(@"Close_txt") forState:UIControlStateNormal];
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
    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3, SCREEN_WIDTH, SCREEN_HEIGHT/5)];
    _inputView.backgroundColor = [UIColor clearColor];
    _inputView.userInteractionEnabled = YES;
    [_backView addSubview:_inputView];
    
    //_mobileLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    _mobileLabel = [[UILabel alloc] init];
    _mobileLabel.text = [NSString stringWithFormat:@"%@:",Localized(@"Mobile_num")];
    _mobileLabel.textAlignment = NSTextAlignmentRight;
    _mobileLabel.textColor = [UIColor whiteColor];
    
    _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 60, 30)];
    _passwordLabel.text = [NSString stringWithFormat:@"%@:",Localized(@"Password_txt")];
    _passwordLabel.textAlignment = NSTextAlignmentRight;
    _passwordLabel.textColor = [UIColor whiteColor];
    
    _mobileText = [[UITextField alloc] initWithFrame:CGRectMake(75, 10, 200, 30)];
    _mobileText.placeholder = Localized(@"Please_enter_mobile");
    _mobileText.layer.borderWidth = 1.0f;
    _mobileText.layer.cornerRadius = 5;
    _mobileText.layer.borderColor = [UIColor grayColor].CGColor;
    _mobileText.backgroundColor = [UIColor whiteColor];
    
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(75, 50, 200, 30)];
    _passwordText.placeholder = Localized(@"Please_enter_password");
    _passwordText.secureTextEntry = YES;
    _passwordText.layer.borderWidth = 1.0f;
    _passwordText.layer.cornerRadius = 5;
    _passwordText.layer.borderColor = [UIColor grayColor].CGColor;
    _passwordText.backgroundColor = [UIColor whiteColor];
    
    [_inputView addSubview:_mobileLabel];
    [_inputView addSubview:_passwordLabel];
    [_inputView addSubview:_mobileText];
    [_inputView addSubview:_passwordText];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn setTitle:Localized(@"Log_in") forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    _regBtn = [[UIButton alloc] init];
    [_regBtn setTitle:Localized(@"Register_txt") forState:UIControlStateNormal];
    [_regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_regBtn addTarget:self action:@selector(regTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [_inputView addSubview:_loginBtn];
    [_inputView addSubview:_regBtn];
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
    
    self.mobileLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.mobileText.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordText.translatesAutoresizingMaskIntoConstraints = NO;

    [self.mobileLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.mobileLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30.f]];
    
    [self.passwordLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.passwordLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30.f]];
    
    [self.mobileText addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.mobileText addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100.f]];
    
    [self.passwordText addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.passwordText addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100.f]];
    
    self.loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.regBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.loginBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.loginBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:110.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100.f]];
    
    [self.regBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.regBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:110.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-100.f]];
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


-(IBAction)QQLoginTouch:(id)sender{NSLog(@"garfunkel_log:loadQQLogin");
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
    NSLog(@"garfunkel_log:intoQQLogin");
    [self.tencentOAuth getUserInfo];
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSLog(@"garfunkel_log:loginReturn:%d",cancelled);
    if (cancelled)
    {
        [self alertHUD:Localized(@"User_cancel_login")];
    }
    else
    {
        [self alertHUD:Localized(@"Login_fail")];
    }
    
}

- (void)tencentDidNotNetWork{
    [self alertHUD:Localized(@"Net_anomaly")];
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
        [self alertHUD:Localized(@"Auth_fail")];
    }
}
-(BOOL)checkPhoneNum:(NSString*)num{//验证手机号
    NSString* str = @"[0-9]{5,20}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [phoneTest evaluateWithObject:num];
}

-(void)regTouch:(id)sender{
    //Reg* reg = [[Reg alloc] init];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Reg alloc]init]];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

-(void)regReturn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginTouch:(id)sender{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            self.HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
            [self.view.window addSubview:self.HUD];
            self.HUD.delegate = self;
            self.HUD.minSize = CGSizeMake(135.f, 135.f);
            [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
            
            if(![self checkPhoneNum:_mobileText.text]){
                [self alertHUD:Localized(@"Phone_error")];
            }else{
                if([_passwordText.text length] < 6){
                    [self alertHUD:Localized(@"Password_six")];
                }else{
                    NSString *mobile = _mobileText.text;
                    NSString *password = _passwordText.text;
                    self.HUD.labelText = Localized(@"Login_now");
                    [self.HUD show:YES];
                    
                    NSDictionary* arg = @{@"a":@"userLogin",@"userName":mobile,@"password":password};
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
                            [self hidHUD:Localized(@"Success_txt") success:YES];
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }else if(react == 400){
                            [self hidHUD:message];
                        }else{
                            [self hidHUD:message];
                        }
                    }];
                }
            }
        }
    }];
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
    NSLog(@"garfunkel______________________log");
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:self.HUD];
    self.HUD.delegate = self;
    self.HUD.minSize = CGSizeMake(135.f, 135.f);
    [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
    self.HUD.labelText = Localized(@"Login_now");
    [self.HUD show:YES];
    
    
    //NSDictionary* arg = @{@"ince":@"the_third_reg",@"nickname":nick,@"openid":openID,@"face_pic":face,@"type":[WMHelper integerConvertToString:type]};
    NSDictionary* arg = @{@"a":@"user_third_Login"};
    NSLog(@"garfunkel_log:loginArg:%@",arg);
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
            [self hidHUD:Localized(@"Success_txt") success:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if(react == 400){
            [self hidHUD:message];
        }else{
            [self hidHUD:message];
        }
    }];
    
    
}


@end
