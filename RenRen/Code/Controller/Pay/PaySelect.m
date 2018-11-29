//
//  PaySelect.m
//  RenRen
//
//  Created by Garfunkel on 2018/11/27.
//

#import "PaySelect.h"
#import "CreditPay.h"

@interface PaySelect ()
@property(nonatomic,strong) UILabel* labelOrderId;

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
@end

@implementation PaySelect

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = theme_table_bg_color;
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
                         @"H:|-defEdge-[btnBalance]-defEdge-|",
                         @"H:|-10-[priceView]-defEdge-|",
                         @"H:|-15-[btnPay(==payWidth)]",
                         @"V:|-topMargin-[labelOrderId(==baseHeight)]-20-[btnFacePay(==baseHeight)][btnCredit(==baseHeight)][btnBalance(==baseHeight)]-10-[priceView(==baseHeight)]",
                         @"H:[imgFace(==30)]-10-|",@"V:|-5-[imgFace(==30)]",
                         @"H:[imgCredit(==30)]-10-|",@"V:|-5-[imgCredit(==30)]",
                         @"H:[imgBalance(==30)]-10-|",@"V:|-5-[imgBalance(==30)]",
                         @"H:|-defEdge-[labelTip][labelTotal]-10-|",
                         @"V:|-defEdge-[labelTip(==baseHeight)]",@"V:|-defEdge-[labelTotal(==baseHeight)]",
                         @"V:[btnPay(==baseHeight)]-bottomMargin-|"
                         ];
    NSDictionary* metrics = @{
                            @"defEdge":@(0),@"payWidth":@(SCREEN_WIDTH-30),@"topMargin":@(topMargin),@"bottomMargin":@(bottomMargin),@"baseHeight":@(40)
                              };
    NSDictionary* views = @{
                            @"labelOrderId":self.labelOrderId,@"btnFacePay":self.btnFacePay,@"btnCredit":self.btnCredit,@"imgFace":self.imgFace,@"imgCredit":self.imgCredit,@"btnBalance":self.btnBalance,@"imgBalance":self.imgBalance,@"priceView":self.priceView,@"labelTip":self.labelTip,@"labelTotal":self.labelTotal,@"btnPay":self.btnPay
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
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-default"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),self.tip_price];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price + self.tip_price];
    }else if(sender == self.btnBalance){
        self.btnFacePay.selected = NO;
        self.btnCredit.selected = NO;
        self.btnBalance.selected = YES;
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-enter"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),self.tip_price];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price + self.tip_price];
    }else if(sender == self.btnFacePay){
        self.btnFacePay.selected = YES;
        self.btnCredit.selected = NO;
        self.btnBalance.selected = NO;
        [self.imgFace setImage:[UIImage imageNamed:@"icon-address-enter"]];
        [self.imgCredit setImage:[UIImage imageNamed:@"icon-address-default"]];
        [self.imgBalance setImage:[UIImage imageNamed:@"icon-address-default"]];
        
        self.labelTip.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Tip_txt"),0.00];
        self.labelTotal.text = [NSString stringWithFormat:@"%@:$%.2f",Localized(@"Total_price"),self.total_price];
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
        NSString* payType = @"0";
        if(self.btnFacePay.selected){
            payType = @"0";
            self.tip_price = 0.00;
        }else if(self.btnBalance.selected){
            payType = @"4";
        }
        [self showHUD];
        NSDictionary* arg = @{@"a":@"ToPay",@"uid":self.Identity.userInfo.userID,@"pay_type":payType,@"tip":[NSString stringWithFormat:@"%.2f",self.tip_price],@"order_id":self.order_id,@"price":[NSString stringWithFormat:@"%.2f",self.total_price]};
        
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
            if(react == 1){
                [self hidHUD];
                NSString* strMsg = [NSString stringWithFormat:@"%@:%@",Localized(@"Payment_result"),Localized(@"Success_txt") ];
                [self alertHUD:strMsg];
                [self.navigationController popViewControllerAnimated:YES];
            }else if(react == 400){
                [self hidHUD:message];
            }else{
                [self hidHUD:message];
            }
        }];
    }
}


@end
