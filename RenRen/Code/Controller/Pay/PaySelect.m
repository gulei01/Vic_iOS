//
//  PaySelect.m
//  RenRen
//
//  Created by Garfunkel on 2018/11/27.
//

#import "PaySelect.h"
#import "CreditPay.h"
#import "AlipayOrder.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface PaySelect ()
@property(nonatomic,strong) UILabel* labelOrderId;

@property(nonatomic,strong) UIButton* btnWeXinPay;
@property(nonatomic,strong) UIImageView* imgWeiXin;
@property(nonatomic,strong) UIButton* btnAlipay;
@property(nonatomic,strong) UIImageView* imgAli;
@property(nonatomic,strong) UIButton* btnFacePay;
@property(nonatomic,strong) UIImageView* imgFace;
@property(nonatomic,strong) UIButton* btnCredit;
@property(nonatomic,strong) UIImageView* imgCredit;
@property(nonatomic,strong) UIButton* btnBalance;
@property(nonatomic,strong) UIImageView* imgBalance;

@property(nonatomic,strong) UIView* priceView;

@property(nonatomic,strong) UILabel* labelTip;
@property(nonatomic,strong) UILabel* labelTotal;

@property(nonatomic,strong) UIButton* btnPay;

@property(nonatomic,assign) double currTip;
@property(nonatomic,assign) double currTotal;
@property(nonatomic,assign) double balance;

@property(nonatomic,strong) UIBarButtonItem* leftBarItem;
@end

@implementation PaySelect

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.leftBarButtonItem = self.leftBarItem;
    self.view.backgroundColor = theme_table_bg_color;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccessNotification:) name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payUserCancelNotification:) name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PayFailureNotification:) name:NotificationPayFailure object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBackNotification:) name:NotificationAppBack object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = Localized(@"Payment_method");
    [self layoutUI];
    [self layoutConstraints];
    [self queryData];
    if([self.payType isEqualToString:@"moneris"]){
        [self btnPayWay:self.btnCredit];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPaySuccess object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPayUserCancel object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationPayFailure object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationAppBack object:nil];
    
}

-(void)layoutUI{
    self.labelOrderId = [[UILabel alloc]init];
    self.labelOrderId.text = [NSString stringWithFormat:@"%@:%@",Localized(@"Order_num"),self.order_id];
    self.labelOrderId.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.labelOrderId];
    
    self.btnFacePay = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnFacePay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Offline_payment")];
    [self.btnFacePay setAttributedTitle:attributeStr forState:UIControlStateNormal];
    self.btnFacePay.backgroundColor =theme_default_color;
    self.btnFacePay.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.btnFacePay.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.btnFacePay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnFacePay.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnFacePay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnFacePay];
    
    self.imgFace = [[UIImageView alloc]init];
    [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
    self.imgFace.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnFacePay addSubview:self.imgFace];
    
    self.btnCredit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCredit setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* creditStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Payment_online")];
    [self.btnCredit setAttributedTitle:creditStr forState:UIControlStateNormal];
    self.btnCredit.backgroundColor =theme_default_color;
    self.btnCredit.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.btnCredit.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.btnCredit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnCredit.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnCredit addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnCredit];
    
    self.imgCredit = [[UIImageView alloc]init];
    [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
    self.imgCredit.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnCredit addSubview:self.imgCredit];
    
    self.btnWeXinPay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnWeXinPay.backgroundColor = theme_default_color;
    self.btnWeXinPay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnWeXinPay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
    self.btnWeXinPay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.btnWeXinPay setImage:[UIImage imageNamed:@"icon-wechat-pay"] forState:UIControlStateNormal];
    [self.btnWeXinPay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    [self.btnWeXinPay setTitle:Localized(@"Wexin_payment") forState:UIControlStateNormal];
    self.btnWeXinPay.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.btnWeXinPay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    self.btnWeXinPay.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.btnWeXinPay];
    
    self.imgWeiXin = [[UIImageView alloc]init];
    [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
    self.imgWeiXin.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnWeXinPay addSubview:self.imgWeiXin];
    
    self.btnAlipay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAlipay.backgroundColor =theme_default_color;
    self.btnAlipay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnAlipay.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-40);
    self.btnAlipay.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.btnAlipay setImage:[UIImage imageNamed:@"icon-alipay"] forState:UIControlStateNormal];
    [self.btnAlipay setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    [self.btnAlipay setTitle:Localized(@"Alipay_payment") forState:UIControlStateNormal];
    self.btnAlipay.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self.btnAlipay addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    self.btnAlipay.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.btnAlipay];
    
    self.imgAli = [[UIImageView alloc]init];
    [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
    self.imgAli.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnAlipay addSubview:self.imgAli];
    
    self.btnBalance = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnBalance setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnBalance setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    NSString* balanceStr = [NSString stringWithFormat:@"%@ ($%@)" ,Localized(@"BALANCE_PAYMENT"),@"0.00"];
    [self.btnBalance setTitle:balanceStr forState:UIControlStateNormal];
    self.btnBalance.backgroundColor =theme_default_color;
    self.btnBalance.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.btnBalance.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.btnBalance.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnBalance.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnBalance addTarget:self action:@selector(btnPayWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnBalance];
    
    self.imgBalance = [[UIImageView alloc]init];
    [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-default"]];
    self.imgBalance.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnBalance addSubview:self.imgBalance];
    
    self.priceView = [[UIView alloc]init];
    self.priceView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.priceView];
    
    self.labelTip = [[UILabel alloc]init];
    self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),self.tip_price];
    self.labelTip.translatesAutoresizingMaskIntoConstraints = NO;
    [self.priceView addSubview:self.labelTip];
    
    self.labelTotal = [[UILabel alloc]init];
    [self.labelTotal setTextColor:[UIColor redColor]];
    self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price + self.tip_price];
    self.labelTotal.textAlignment = NSTextAlignmentRight;
    self.labelTotal.translatesAutoresizingMaskIntoConstraints = NO;
    [self.priceView addSubview:self.labelTotal];
    
    self.btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPay.backgroundColor = [UIColor redColor];
    [self.btnPay setTitleColor:theme_default_color forState:UIControlStateNormal];
    [self.btnPay setTitle:Localized(@"Payment_txt") forState:UIControlStateNormal];
    self.btnPay.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.btnPay.layer.masksToBounds = YES;
    self.btnPay.layer.cornerRadius = 5.f;
    self.btnPay.translatesAutoresizingMaskIntoConstraints = NO;
    [self.btnPay addTarget:self action:@selector(sendPayment) forControlEvents:UIControlEventTouchUpInside];
    self.btnPay.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.btnPay];
}

-(void)layoutConstraints{
    NSInteger topMargin = StatusBarAndNavigationBarHeight;
    NSInteger bottomMargin = TabbarSafeBottomMargin + 5;
    NSArray* formats = @[
                         @"H:|-10-[labelOrderId]-defEdge-|",
                         @"H:|-defEdge-[btnFacePay]-defEdge-|",
                         @"H:|-defEdge-[btnCredit]-defEdge-|",
                         @"H:|-defEdge-[btnAlipay]-defEdge-|",
                         @"H:|-defEdge-[btnWeXinPay]-defEdge-|",
                         @"H:|-defEdge-[btnBalance]-defEdge-|",
                         @"H:|-10-[priceView]-defEdge-|",
                         @"H:|-15-[btnPay(==payWidth)]",
                         @"V:|-topMargin-[labelOrderId(==baseHeight)]-20-[btnFacePay(==baseHeight)][btnCredit(==baseHeight)][btnAlipay(==baseHeight)][btnWeXinPay(==baseHeight)][btnBalance(==baseHeight)]-10-[priceView(==baseHeight)]",
                         @"H:[imgFace(==30)]-10-|",@"V:|-5-[imgFace(==30)]",
                         @"H:[imgCredit(==30)]-10-|",@"V:|-5-[imgCredit(==30)]",
                         @"H:[imgAli(==30)]-10-|",@"V:|-5-[imgAli(==30)]",
                         @"H:[imgWeiXin(==30)]-10-|",@"V:|-5-[imgWeiXin(==30)]",
                         @"H:[imgBalance(==30)]-10-|",@"V:|-5-[imgBalance(==30)]",
                         @"H:|-defEdge-[labelTip][labelTotal]-10-|",
                         @"V:|-defEdge-[labelTip(==baseHeight)]",@"V:|-defEdge-[labelTotal(==baseHeight)]",
                         @"V:[btnPay(==baseHeight)]-bottomMargin-|"
                         ];
    NSDictionary* metrics = @{
                            @"defEdge":@(0),@"payWidth":@(SCREEN_WIDTH-30),@"topMargin":@(topMargin),@"bottomMargin":@(bottomMargin),@"baseHeight":@(40)
                              };
    NSDictionary* views = @{
                            @"labelOrderId":self.labelOrderId,@"btnFacePay":self.btnFacePay,@"btnCredit":self.btnCredit,@"imgFace":self.imgFace,@"imgCredit":self.imgCredit,@"btnBalance":self.btnBalance,@"imgBalance":self.imgBalance,@"priceView":self.priceView,@"labelTip":self.labelTip,@"labelTotal":self.labelTotal,@"btnPay":self.btnPay,@"btnAlipay":self.btnAlipay,@"btnWeXinPay":self.btnWeXinPay,@"imgAli":self.imgAli,@"imgWeiXin":self.imgWeiXin
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
}

-(IBAction)btnPayWay:(id)sender{
    if(sender == self.btnCredit){
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = YES;
        self.btnBalance.selected = NO;
        self.btnAlipay.selected = NO;
        self.btnWeXinPay.selected = NO;
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),self.tip_price];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price + self.tip_price];
    }else if(sender == self.btnBalance){
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = NO;
        self.btnBalance.selected = YES;
        self.btnAlipay.selected = NO;
        self.btnWeXinPay.selected = NO;
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),self.tip_price];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price + self.tip_price];
    }else if(sender == self.btnFacePay){
        self.btnFacePay.selected = YES;
        self.btnCredit.selected = NO;
        self.btnBalance.selected = NO;
        self.btnAlipay.selected = NO;
        self.btnWeXinPay.selected = NO;
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),0.00];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price];
    }else if(sender == self.btnAlipay){
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = NO;
        self.btnBalance.selected = NO;
        self.btnAlipay.selected = YES;
        self.btnWeXinPay.selected = NO;
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-default"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),self.tip_price];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price + self.tip_price];
    }else if(sender == self.btnWeXinPay){
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = NO;
        self.btnBalance.selected = NO;
        self.btnAlipay.selected = NO;
        self.btnWeXinPay.selected = YES;
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgAli setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgWeiXin setImage:[UIImage imageNamed:@"icon-address-enter"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),self.tip_price];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price + self.tip_price];
    }
}

-(void)queryData{
    [self showHUD];
    NSDictionary* arg = @{@"a":@"get_user_info",@"uid":self.Identity.userInfo.userID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            NSDictionary* dict = [response objectForKey:@"info"];
            //余额
            self.balance = [[dict objectForKey:@"now_money"] doubleValue];
            if(self.balance > 0){
                NSString* balanceStr = [NSString stringWithFormat:@"%@ ($%.2f)" ,Localized(@"BALANCE_PAYMENT"),self.balance];
                [self.btnBalance setTitle:balanceStr forState:UIControlStateNormal];
                //                [self.btnBalance setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }else{
                self.btnBalance.hidden = YES;
                for(NSLayoutConstraint* con in [self.btnBalance constraints]){
                    if([con firstAttribute] == NSLayoutAttributeHeight){
                        [self.btnBalance removeConstraint:con];
                        [self.btnBalance addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBalance attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0.f]];
                    }
                }
            }
            //
            if (self.total_price + self.tip_price <= self.balance) {
                self.btnBalance.enabled = YES;
            }else{
                self.btnBalance.enabled = NO;
                if(self.btnBalance.selected){
                    [self btnPayWay:self.btnCredit];
                }
            }
            ///////
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
    }];
}

-(void)sendPayment{
    if(self.btnCredit.selected){
        CreditPay* controller = [[CreditPay alloc]init];
        controller.tip_price = self.tip_price;
        controller.total_price = self.total_price;
        controller.order_id = self.order_id;
        controller.order_type = self.order_type;

        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
        //        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self.parentViewController presentViewController:nav animated:YES completion:^{
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }else{
        if(self.btnWeXinPay.selected){
            if(![WXApi isWXAppInstalled]){
                [self alertHUD:Localized(@"Not_weixin_payment")];
                return;
            }
        }
        NSString* payType = @"0";
        if(self.btnFacePay.selected){
            payType = @"0";
            self.tip_price = 0.00;
        }else if(self.btnBalance.selected){
            payType = @"4";
        }else if(self.btnAlipay.selected){
            payType = @"1";
        }else if(self.btnWeXinPay.selected){
            payType = @"2";
        }
        [self showHUD];
        NSString* IPAddress = [self getIPAddress:YES];
        NSDictionary* arg = @{@"a":@"ToPay",@"uid":self.Identity.userInfo.userID,@"pay_type":payType,@"tip":[NSString stringWithFormat:@"%.2f",self.tip_price],@"order_id":self.order_id,@"price":[NSString stringWithFormat:@"%.2f",self.total_price],@"ip":IPAddress};
        
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
            if(react == 1){
                [self hidHUD];
                if(self.btnWeXinPay.selected)//微信支付
                    [self wxPayNew:[response objectForKey:@"result"]];
                else if (self.btnAlipay.selected)//支付宝支付
                    [self aliPayNew:[response objectForKey:@"result"]];
                else{
                    NSString* strMsg = [NSString stringWithFormat:@"%@:%@",Localized(@"Payment_result"),Localized(@"Success_txt") ];
                    [self alertHUD:strMsg];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else if(react == 400){
                [self hidHUD:message];
            }else{
                [self hidHUD:message];
            }
        }];
    }
}
-(void)wxPayNew:(NSDictionary*)result{
    if([[result objectForKey:@"resCode"] isEqualToString:@"SUCCESS"] && [[result objectForKey:@"retCode"] isEqualToString:@"SUCCESS"]){
        NSMutableDictionary* dict = [result objectForKey:@"payParams"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timeStamp"];
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appId"];
        req.partnerId           = [dict objectForKey:@"partnerId"];
        req.prepayId            = [dict objectForKey:@"prepayId"];
        req.nonceStr            = [dict objectForKey:@"nonceStr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"packageValue"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }else{
        NSString* message = [result objectForKey:@"retMsg"];
        [self alertHUD:message];
    }
}

-(void)aliPayNew:(NSDictionary*)result{
    NSString *appScheme = @"com.kavl.tutti.user";
    NSString* orderString = [result objectForKey:@"payParams"];
    NSLog(@"garfunkel_Alipay:%@",orderString);
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSInteger flag = [[resultDic objectForKey:@"resultStatus"]integerValue];
        if(flag == 9000){
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:[resultDic objectForKey:@"memo"]];
        }else if(flag == 4000){
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayFailure object:[resultDic objectForKey:@"memo"]];
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPayUserCancel object:[resultDic objectForKey:@"memo"]];
        }
        NSLog(@"%@",resultDic);
    }];
}
#pragma mark =====================================================  通知
-(void)paySuccessNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message];
}

-(void)payUserCancelNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message];
}

-(void)PayFailureNotification:(NSNotification*)notification{
    NSString* message = [notification object];
    [self payResult:message];
}

-(void)appBackNotification:(NSNotification*)notification{
    [self payResult:nil];
}
-(void)payResult:(NSString*)message{
    if(message){
        /*[self showHUD:message];
         [self hidHUD:message];*/
        [self alertHUD:message];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                //                if(type) {
                //                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                //                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                //                }
                if(type && [type isEqualToString:IP_ADDR_IPv4]) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf]; }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

-(UIBarButtonItem *)leftBarItem{
    if(!_leftBarItem){
        UIButton* btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(-200, 0, 44, 44);
        [btn setImage:[UIImage imageNamed: @"icon-back-white"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        _leftBarItem =  [[UIBarButtonItem alloc]initWithCustomView:btn];
        
    }
    return _leftBarItem;
}
-(IBAction)goBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
