//
//  CreditPay.m
//  RenRen
//
//  Created by Garfunkel on 2018/10/17.
//

#import "CreditPay.h"
#import "Card.h"

@interface CreditPay ()<UITextFieldDelegate>
@property(nonatomic,strong) UIView* cardView;
@property(nonatomic,strong) UIButton* oldSelectBtn;
@property(nonatomic,strong) UIImageView* oldCardImg;
@property(nonatomic,strong) UIButton* cardMemoBtn;
@property(nonatomic,strong) UIImageView* cardMore;

@property(nonatomic,strong) UIView* NewCardView;
@property(nonatomic,strong) UIButton* CardTitle;
@property(nonatomic,strong) UIImageView* titleImg;
@property(nonatomic,strong) UITextField* CardName;
@property(nonatomic,strong) UITextField* ExpiryLabel;
@property(nonatomic,strong) UITextField* CardNum;
@property(nonatomic,strong) UIButton* SaveBtn;
@property(nonatomic,strong) UIImageView* SaveImg;

@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* priceTitle;
@property(nonatomic,strong) UILabel* SumPrice;

@property(nonatomic,strong) UIButton* PaymentBtn;

@property(nonatomic,assign) NSString* isSave;
@property(nonatomic,assign) NSString* credit_id;
@property(nonatomic,assign) NSString* userCard;
@end

@implementation CreditPay

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = Localized(@"Payment_txt");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:Localized(@"Cancel_txt") style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouch:)];
    
    [self layoutUI];
    [self layoutConstraints];
    
    self.isSave = @"0";
    self.userCard = @"0";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self queryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)layoutUI{
    self.view.backgroundColor = theme_table_bg_color;
    
    self.cardView = [[UIView alloc]init];
    self.cardView.backgroundColor = theme_default_color;
    self.cardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cardView];
    
    self.oldSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.oldSelectBtn setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* oldCardStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Credit_card")];
    [self.oldSelectBtn setAttributedTitle:oldCardStr forState:UIControlStateNormal];
    self.oldSelectBtn.backgroundColor =theme_default_color;
    self.oldSelectBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    self.oldSelectBtn.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.oldSelectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.oldSelectBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.oldSelectBtn addTarget:self action:@selector(SelectCard) forControlEvents:UIControlEventTouchUpInside];
    self.oldSelectBtn.selected = YES;
    [self.cardView addSubview:self.oldSelectBtn];
    
    self.oldCardImg = [[UIImageView alloc]init];
    [self.oldCardImg setImage:[UIImage imageNamed:@"icon-address-enter"]];
    self.oldCardImg.translatesAutoresizingMaskIntoConstraints = NO;
    [self.oldSelectBtn addSubview:self.oldCardImg];
    
    self.cardMemoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cardMemoBtn setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    //NSMutableAttributedString* oldCardStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Credit_card")];
    //[cardMemoBtn setAttributedTitle:oldCardStr forState:UIControlStateNormal];
    self.cardMemoBtn.backgroundColor =theme_default_color;
    self.cardMemoBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    self.cardMemoBtn.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.cardMemoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.cardMemoBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cardMemoBtn addTarget:self action:@selector(ChangeCard) forControlEvents:UIControlEventTouchUpInside];
    [self.cardView addSubview:self.cardMemoBtn];
    
    self.cardMore = [[UIImageView alloc]init];
    [self.cardMore setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    self.cardMore.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cardMemoBtn addSubview:self.cardMore];
    
    self.NewCardView = [[UIView alloc] init];
    //self.NewCardView.frame = CGRectMake(0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, 240);
    self.NewCardView.backgroundColor = theme_default_color;
    self.NewCardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.NewCardView];
    
    self.CardTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.CardTitle setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* CardStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"Credit_card")];
    [self.CardTitle setAttributedTitle:CardStr forState:UIControlStateNormal];
    self.CardTitle.backgroundColor =theme_default_color;
    self.CardTitle.titleLabel.font = [UIFont systemFontOfSize:16.f];
    self.CardTitle.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.CardTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.CardTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.CardTitle addTarget:self action:@selector(SelectCard) forControlEvents:UIControlEventTouchUpInside];
    [self.NewCardView addSubview:self.CardTitle];
    
    self.titleImg = [[UIImageView alloc]init];
    [self.titleImg setImage:[UIImage imageNamed:@"icon-address-default"]];
    self.titleImg.translatesAutoresizingMaskIntoConstraints = NO;
    [self.CardTitle addSubview:self.titleImg];
    
    self.CardName = [[UITextField alloc] init];
    self.CardName.leftView = [self leftView:[NSString stringWithFormat:@"%@:",Localized(@"CREDITHOLDER_NAME")]];
    self.CardName.leftViewMode =UITextFieldViewModeAlways;
    self.CardName.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.CardName.placeholder = @"Name";
    self.CardName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.NewCardView addSubview:self.CardName];
    
    self.CardNum = [[UITextField alloc] init];
    self.CardNum.leftView = [self leftView:[NSString stringWithFormat:@"%@:",Localized(@"CREDIT_CARD_NUM")]];
    self.CardNum.leftViewMode =UITextFieldViewModeAlways;
    self.CardNum.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.CardNum.placeholder = @"Number";
    self.CardNum.translatesAutoresizingMaskIntoConstraints = NO;
    self.CardNum.keyboardType = UIKeyboardTypeNumberPad;
    self.CardNum.delegate = self;
    [self.NewCardView addSubview:self.CardNum];
    
    self.ExpiryLabel = [[UITextField alloc] init];
    self.ExpiryLabel.leftView = [self leftView:[NSString stringWithFormat:@"%@:",Localized(@"EXPRIRY_DATE")]];
    self.ExpiryLabel.leftViewMode =UITextFieldViewModeAlways;
    self.ExpiryLabel.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.ExpiryLabel.placeholder = @"MMYY";
    self.ExpiryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.ExpiryLabel.keyboardType = UIKeyboardTypeNumberPad;
    self.ExpiryLabel.delegate = self;
    [self.NewCardView addSubview:self.ExpiryLabel];
    
    self.SaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.SaveBtn setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    NSMutableAttributedString* creditStr = [[NSMutableAttributedString alloc]initWithString:Localized(@"IS_SAVE")];
    [self.SaveBtn setAttributedTitle:creditStr forState:UIControlStateNormal];
    self.SaveBtn.backgroundColor =theme_line_color;
    self.SaveBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    self.SaveBtn.contentEdgeInsets =UIEdgeInsetsMake(0, 10, 0, 0);
    self.SaveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.SaveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.SaveBtn addTarget:self action:@selector(SaveCard) forControlEvents:UIControlEventTouchUpInside];
    [self.NewCardView addSubview:self.SaveBtn];
    
    self.SaveImg = [[UIImageView alloc]init];
    [self.SaveImg setImage:[UIImage imageNamed:@"icon-address-default"]];
    self.SaveImg.translatesAutoresizingMaskIntoConstraints = NO;
    [self.SaveBtn addSubview:self.SaveImg];
    
    self.priceView = [[UIView alloc]init];
    self.priceView.translatesAutoresizingMaskIntoConstraints = NO;
    self.priceView.backgroundColor = theme_default_color;
    [self.view addSubview:self.priceView];
    
    self.priceTitle = [[UILabel alloc]init];
    self.priceTitle.text = Localized(@"Total_price");
    self.priceTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.priceView addSubview:self.priceTitle];
    
    self.SumPrice = [[UILabel alloc]init];
    self.SumPrice.text = [NSString stringWithFormat:@"$%.2f",self.total_price + self.tip_price];
    self.SumPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.SumPrice.textAlignment = NSTextAlignmentRight;
    [self.priceView addSubview:self.SumPrice];
    
    self.PaymentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.PaymentBtn.backgroundColor = [UIColor redColor];
    [self.PaymentBtn setTitleColor:theme_default_color forState:UIControlStateNormal];
    [self.PaymentBtn setTitle:Localized(@"Payment_txt") forState:UIControlStateNormal];
    self.PaymentBtn.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.PaymentBtn.layer.masksToBounds = YES;
    self.PaymentBtn.layer.cornerRadius = 5.f;
    self.PaymentBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.PaymentBtn addTarget:self action:@selector(sendPayment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.PaymentBtn];
    
    
    NSInteger topMargin = StatusBarAndNavigationBarHeight;
    NSInteger bottomMargin = TabbarSafeBottomMargin + 5;
    NSArray* formats = @[
                         @"H:|-defEdge-[cardView]-defEdge-|",@"H:|-defEdge-[NewCardView]-defEdge-|",@"H:|-defEdge-[priceView]-defEdge-|",@"H:|-15-[PaymentBtn(==payWidth)]",
                         @"V:|-topMargin-[cardView(==90)]-10-[NewCardView(==240)]-10-[priceView(==baseHeight)]",@"V:[PaymentBtn(==baseHeight)]-bottomMargin-|"
                         ];
    NSDictionary* metrics = @{
                @"defEdge":@(0),@"payWidth":@(SCREEN_WIDTH-30),@"topMargin":@(topMargin),@"bottomMargin":@(bottomMargin),@"baseHeight":@(40)
                              };
    NSDictionary* views = @{
                            @"cardView":self.cardView,@"NewCardView":self.NewCardView,@"priceView":self.priceView, @"PaymentBtn":self.PaymentBtn
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
}

-(void)layoutConstraints{
    NSArray* formats = @[
                         @"H:|-defEdge-[CardTitle]-defEdge-|",@"H:|-leftMargin-[CardName(==baseWidth)]",@"H:|-leftMargin-[CardNum(==baseWidth)]",@"H:|-leftMargin-[ExpiryLabel(==baseWidth)]",@"H:|-defEdge-[SaveBtn]-defEdge-|",
                         @"V:|-baseTop-[CardTitle(==baseHeight)]-baseTop-[CardName(==baseHeight)]-baseTop-[CardNum(==baseHeight)]-baseTop-[ExpiryLabel(==baseHeight)]",@"V:[SaveBtn(==baseHeight)]-defEdge-|",
                         @"H:[titleImg(==20)]-5-|",@"V:|-10-[titleImg(==20)]",
                         ];
    NSDictionary* metrics = @{
                              @"defEdge":@(0),@"leftMargin":@(10),@"baseWidth":@(SCREEN_WIDTH - 20),@"baseHeight":@(40),@"baseTop":@(5)
                              };
    NSDictionary* views = @{
                            @"CardTitle":self.CardTitle, @"CardName":self.CardName,@"CardNum":self.CardNum,@"ExpiryLabel":self.ExpiryLabel,@"SaveBtn":self.SaveBtn,@"titleImg":self.titleImg
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.NewCardView addConstraints:constraints];
    }
    
    formats = @[@"H:|-defEdge-[oldSelectBtn]-defEdge-|",@"H:|-defEdge-[cardMemoBtn]-defEdge-|",@"V:|-defEdge-[oldSelectBtn(==40)]-baseTop-[cardMemoBtn(==40)]",
                @"H:[oldCardImg(==20)]-5-|",@"V:|-10-[oldCardImg(==20)]",
                @"H:[cardMore(==8)]-5-|",@"V:|-12-[cardMore(==14)]"
                ];
    metrics = @{@"defEdge":@(0),@"baseTop":@(5)};
    views = @{@"oldSelectBtn":self.oldSelectBtn,@"oldCardImg":self.oldCardImg,@"cardMemoBtn":self.cardMemoBtn,@"cardMore":self.cardMore};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.cardView addConstraints:constraints];
    }
    
    [self.SaveImg addConstraint:[NSLayoutConstraint constraintWithItem:self.SaveImg attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:20.f]];
    [self.SaveImg addConstraint:[NSLayoutConstraint constraintWithItem:self.SaveImg attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:20.f]];
    [self.SaveBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.SaveImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.SaveBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.SaveBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.SaveImg attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.SaveBtn attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.priceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.priceTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.SumPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.SumPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.SumPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.SumPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.SumPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.priceView addConstraint:[NSLayoutConstraint constraintWithItem:self.SumPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.priceView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
}

-(IBAction)cancelTouch:(id)sender{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{//不是从购物车进入的会跳过下一步
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:@""];
    }];
}

-(void)SelectCard{
    self.oldSelectBtn.selected = !self.oldSelectBtn.selected;
    self.CardTitle.selected = !self.CardTitle.selected;
    if(self.oldSelectBtn.selected){
        [self.oldCardImg setImage:[UIImage imageNamed:@"icon-address-enter"]];
        self.userCard = @"0";
    }else{
        [self.oldCardImg setImage:[UIImage imageNamed:@"icon-address-default"]];
        self.userCard = @"1";
    }
    
    if(self.CardTitle.selected){
        [self.titleImg setImage:[UIImage imageNamed:@"icon-address-enter"]];
    }else{
        [self.titleImg setImage:[UIImage imageNamed:@"icon-address-default"]];
    }
}

-(void)ChangeCard{
    Card* controller = [[Card alloc]init];
    controller.fromMe = @"0";
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [nav.navigationBar setBackgroundColor:theme_navigation_color];
    [nav.navigationBar setBarTintColor:theme_navigation_color];
    [nav.navigationBar setTintColor:theme_default_color];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)SaveCard{
    self.SaveBtn.selected = !self.SaveBtn.selected;
    
    if(self.SaveBtn.selected){
        [self.SaveImg setImage:[UIImage imageNamed:@"icon-address-enter"]];
        self.isSave = @"1";
    }else{
        [self.SaveImg setImage:[UIImage imageNamed:@"icon-address-default"]];
        self.isSave = @"0";
    }
}

-(void)queryData{
    [self showHUD];
    NSDictionary* arg = @{@"a":@"user_card_default",@"uid":self.Identity.userInfo.userID};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            NSDictionary* dict = [response objectForKey:@"info"];
            NSLog(@"garfunkel_logcard:%@",dict);
            if(![[dict objectForKey:@"id"] isEqualToString:@"0"]){
                self.credit_id = [dict objectForKey:@"id"];
                NSString* cardMemo = [NSString stringWithFormat:@"%@:%@",[dict objectForKey:@"name"],[dict objectForKey:@"card_num"]];
                NSMutableAttributedString* oldCardStr = [[NSMutableAttributedString alloc]initWithString:cardMemo];
                [self.cardMemoBtn setAttributedTitle:oldCardStr forState:UIControlStateNormal];
            }else{//如果没有已经存储的卡 禁止选择
//                [self SelectCard];
                self.oldSelectBtn.selected = NO;
                [self.oldCardImg setImage:[UIImage imageNamed:@"icon-address-default"]];
                self.CardTitle.selected = YES;
                [self.titleImg setImage:[UIImage imageNamed:@"icon-address-enter"]];
                self.oldSelectBtn.userInteractionEnabled = NO;
                self.CardTitle.userInteractionEnabled = NO;
                NSString* cardMemo = Localized(@"ADD_CREDIT_CARD");
                NSMutableAttributedString* oldCardStr = [[NSMutableAttributedString alloc]initWithString:cardMemo];
                [self.cardMemoBtn setAttributedTitle:oldCardStr forState:UIControlStateNormal];
            }
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
    }];
}

-(void)sendPayment{
    [self showHUD];
    if(!self.order_type){
        self.order_type = @"shop";
    }
    NSString* new_order_id = [NSString stringWithFormat:@"tutti%@_%@",self.order_type,self.order_id];
    NSDictionary* arg = @{@"a":@"credit_pay",@"uid":self.Identity.userInfo.userID,@"order_id":new_order_id,@"charge_total":[NSString stringWithFormat:@"%.2f", self.total_price + self.tip_price],@"tip":[NSString stringWithFormat:@"%.2f", self.tip_price],@"card_num":self.CardNum.text,@"expiry":self.ExpiryLabel.text,@"name":self.CardName.text,@"save":self.isSave,@"order_type":self.order_type};
    
    if([self.userCard isEqualToString:@"0"] && self.credit_id){
        arg = @{@"a":@"credit_pay",@"uid":self.Identity.userInfo.userID,@"order_id":new_order_id,@"charge_total":[NSString stringWithFormat:@"%.2f", self.total_price + self.tip_price],@"tip":[NSString stringWithFormat:@"%.2f", self.tip_price],@"credit_id":self.credit_id,@"order_type":self.order_type};
    }
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            NSString* strMsg = [NSString stringWithFormat:@"%@:%@",Localized(@"Payment_result"),Localized(@"Success_txt") ];
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPaySuccess object:strMsg];
            }];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
    }];
}

#pragma mark =====================================================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        // 不能输入.0-9以外的字符
        if (!(single >= '0' && single <= '9'))
        {
            [self alertHUD:Localized(@"Enter_Error")];
            return NO;
        }
        
    }
    
    return YES;
}

-(UILabel*)leftView:(NSString*)title{
    UILabel* leftView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 40.f)];
    leftView.textColor = [UIColor grayColor];
    leftView.font = [UIFont systemFontOfSize:14.f];
    leftView.text = title;
    leftView.textAlignment = NSTextAlignmentRight;
    return leftView;
}

@end
