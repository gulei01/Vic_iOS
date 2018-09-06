//
//  Reg.m
//  RenRen
//
//  Created by Garfunkel on 2018/8/28.
//

#import "Reg.h"

@interface Reg ()

@property(nonatomic,strong) UIImageView *backView;

@property(nonatomic,strong) UIView *inputView;

@property(nonatomic,strong) UILabel *mobileLabel;
@property(nonatomic,strong) UILabel *passwordLabel;
@property(nonatomic,strong) UILabel *vcodeLabel;
@property(nonatomic,strong) UILabel *confirmPLabel;

@property(nonatomic,strong) UITextField *mobileText;
@property(nonatomic,strong) UITextField *vcodeText;
@property(nonatomic,strong) UITextField *confirmPText;
@property(nonatomic,strong) UITextField *passwordText;
@property(nonatomic,strong) UILabel *vcodeTLabel;

@property(nonatomic,strong) UIButton *sendcodeBtn;
@property(nonatomic,strong) UIButton *regBtn;

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) int timeNum;

@end

@implementation Reg



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self layoutUI];
    [self layoutUIConstains];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)layoutUI{
    _backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_backView setImage:[UIImage imageNamed:@"首页"]];
    _backView.userInteractionEnabled = YES;
    [self.navigationController.view addSubview:_backView];
    
    UIButton *btn =  [[UIButton alloc]initWithFrame:CGRectMake(15, 25, 40, 20)];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backView addSubview:btn];
    
    _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/5, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    _inputView.backgroundColor = [UIColor clearColor];
    _inputView.userInteractionEnabled = YES;
    [_backView addSubview:_inputView];
    
    _mobileLabel = [[UILabel alloc] init];
    _mobileLabel.text = @"手机号:";
    _mobileLabel.textAlignment = NSTextAlignmentRight;
    _mobileLabel.textColor = [UIColor whiteColor];
    
    _passwordLabel = [[UILabel alloc] init];
    _passwordLabel.text = @"密   码:";
    _passwordLabel.textAlignment = NSTextAlignmentRight;
    _passwordLabel.textColor = [UIColor whiteColor];
    
    _vcodeLabel = [[UILabel alloc] init];
    _vcodeLabel.text = @"验证码:";
    _vcodeLabel.textAlignment = NSTextAlignmentRight;
    _vcodeLabel.textColor = [UIColor whiteColor];
    
    _confirmPLabel = [[UILabel alloc] init];
    _confirmPLabel.text = @"确认密码:";
    _confirmPLabel.textAlignment = NSTextAlignmentRight;
    _confirmPLabel.textColor = [UIColor whiteColor];
    
    _mobileText = [[UITextField alloc] init];
    _mobileText.placeholder = @"请输入手机号";
    _mobileText.layer.borderWidth = 1.0f;
    _mobileText.layer.cornerRadius = 5;
    _mobileText.layer.borderColor = [UIColor grayColor].CGColor;
    _mobileText.backgroundColor = [UIColor whiteColor];
    
    _vcodeText = [[UITextField alloc] init];
    _vcodeText.placeholder = @"验证码";
    _vcodeText.layer.borderWidth = 1.0f;
    _vcodeText.layer.cornerRadius = 5;
    _vcodeText.layer.borderColor = [UIColor grayColor].CGColor;
    _vcodeText.backgroundColor = [UIColor whiteColor];
    
    _confirmPText = [[UITextField alloc] init];
    _confirmPText.placeholder = @"请再次输入密码";
    _confirmPText.secureTextEntry = YES;
    _confirmPText.layer.borderWidth = 1.0f;
    _confirmPText.layer.cornerRadius = 5;
    _confirmPText.layer.borderColor = [UIColor grayColor].CGColor;
    _confirmPText.backgroundColor = [UIColor whiteColor];
    
    _passwordText = [[UITextField alloc] init];
    _passwordText.placeholder = @"请输入密码";
    _passwordText.secureTextEntry = YES;
    _passwordText.layer.borderWidth = 1.0f;
    _passwordText.layer.cornerRadius = 5;
    _passwordText.layer.borderColor = [UIColor grayColor].CGColor;
    _passwordText.backgroundColor = [UIColor whiteColor];
    
    [_inputView addSubview:_mobileLabel];
    [_inputView addSubview:_passwordLabel];
    [_inputView addSubview:_vcodeLabel];
    [_inputView addSubview:_confirmPLabel];
    [_inputView addSubview:_vcodeText];
    [_inputView addSubview:_confirmPText];
    [_inputView addSubview:_mobileText];
    [_inputView addSubview:_passwordText];
    
    _regBtn = [[UIButton alloc] init];
    [_regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_regBtn addTarget:self action:@selector(regTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    _sendcodeBtn = [[UIButton alloc] init];
    [_sendcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendcodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendcodeBtn addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [_inputView addSubview:_regBtn];
    [_inputView addSubview:_sendcodeBtn];
    
    _vcodeTLabel = [[UILabel alloc] init];
    _vcodeTLabel.textColor = [UIColor whiteColor];
    _vcodeTLabel.textAlignment = NSTextAlignmentCenter;
    _vcodeTLabel.hidden = true;
    [_inputView addSubview:_vcodeTLabel];
}
- (void)layoutUIConstains {
    self.mobileLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.vcodeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmPLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.vcodeText.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmPText.translatesAutoresizingMaskIntoConstraints = NO;
    self.mobileText.translatesAutoresizingMaskIntoConstraints = NO;
    self.passwordText.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.mobileLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.mobileLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30.f]];
    
    [self.vcodeLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.vcodeLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30.f]];
    
    [self.passwordLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.passwordLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:100.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30.f]];
    
    [self.confirmPLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self.confirmPLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:140.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30.f]];
    
    [self.mobileText addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.mobileText addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.mobileText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:120.f]];
    
    [self.vcodeText addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.vcodeText addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:120.f]];
    
    [self.passwordText addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.passwordText addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:100.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:120.f]];
    
    [self.confirmPText addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPText attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.confirmPText addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPText attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPText attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:140.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.confirmPText attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:120.f]];
    
    self.regBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.sendcodeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.vcodeTLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.sendcodeBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.sendcodeBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.sendcodeBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.sendcodeBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.sendcodeBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.sendcodeBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:220.f]];
    
    [self.vcodeTLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeTLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.vcodeTLabel addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeTLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeTLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:60.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.vcodeTLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:220.f]];
    
    [self.regBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.regBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeTop multiplier:1.0 constant:180.f]];
    [self.inputView addConstraint:[NSLayoutConstraint constraintWithItem:self.regBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.inputView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-SCREEN_WIDTH/2+30]];
}
-(IBAction)closeView:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)checkPhoneNum:(NSString*)num{//验证手机号
    NSString* str = @"[0-9]{5,20}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [phoneTest evaluateWithObject:num];
}

-(void)regTouch:(id)sender{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            if(![self checkPhoneNum:_mobileText.text]){
                [self alertHUD:@"请输入正确的手机号"];
            }else{
                if([self.vcodeText.text length] < 6){
                    [self alertHUD:@"请输入正确的验证码"];
                }else{
                    if ([self.passwordText.text length] < 6) {
                        [self alertHUD:@"密码不能少于六位"];
                    }else{
                        if (![self.passwordText.text isEqualToString:self.confirmPText.text]) {
                            [self alertHUD:@"两次输入的密码不一致"];
                        }else{
                            self.HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
                            [self.view.window addSubview:self.HUD];
                            self.HUD.delegate = self;
                            self.HUD.minSize = CGSizeMake(135.f, 135.f);
                            [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
                            
                            self.HUD.labelText = @"正在注册";
                            [self.HUD show:YES];
                            
                            NSDictionary* arg = @{@"a":@"userReg",@"phone":self.mobileText.text,@"password":self.passwordText.text,@"vcode":self.vcodeText.text};
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
                                    }else{
                                        // NSLog(@"%@",@"归档失败!");
                                    }
                                    [self hidHUD:@"注册成功，并登录" success:YES];
                                    //关闭当前
                                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                    //通知登录页面
                                    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationRegSuuccess object:nil];
                                }else if(react == 400){
                                    [self hidHUD:message];
                                }else{
                                    [self hidHUD:message];
                                }
                            }];
                        }
                    }
                }
            }
        }
    }];
}

-(void)sendCode:(id)sender{
    [self checkNetWorkState:^(AFNetworkReachabilityStatus netWorkStatus) {
        if(netWorkStatus!=AFNetworkReachabilityStatusNotReachable){
            if(![self checkPhoneNum:_mobileText.text]){
                [self alertHUD:@"请输入正确的手机号"];
            }else{
                self.HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
                [self.view.window addSubview:self.HUD];
                self.HUD.delegate = self;
                self.HUD.minSize = CGSizeMake(135.f, 135.f);
                [self.HUD setLabelFont:[UIFont systemFontOfSize:14.f]];
                
                self.HUD.labelText = @"正在发送验证码";
                [self.HUD show:YES];
                
                NSDictionary* arg = @{@"a":@"getVerificationCode",@"phone":_mobileText.text};
                NetRepositories* repositories = [[NetRepositories alloc]init];
                [repositories requestPost:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
                    NSLog(@"garfunkel_log:msg:%@",message);
                    if(react == 1){
                        [self hidHUD:@"发送成功" success:YES];
                        self.sendcodeBtn.hidden = true;
                        [self initTimer];
                    }else if(react == 400){
                        [self hidHUD:message];
                    }else{
                        [self hidHUD:message];
                    }
                }];
            }
        }
    }];
}
-(void) initTimer{
    self.timeNum = 60;
    //时间间隔
    NSTimeInterval timeInterval =1.0 ;
    //定时器    repeats 表示是否需要重复，NO为只重复一次
    _timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(vcodeTimer) userInfo:nil repeats:YES];
}

-(void) vcodeTimer{
//    NSLog(@"garfunkel_log:intoTimer-%d",self.timeNum);
    if (self.timeNum > 0) {
        self.vcodeTLabel.hidden = false;
        self.vcodeTLabel.text = [NSString stringWithFormat:@"%d %@",self.timeNum,@"S"];
        self.timeNum--;
    }else{
        [self.timer invalidate];
        self.vcodeTLabel.hidden = true;
        self.sendcodeBtn.hidden = false;
    }
}
@end
