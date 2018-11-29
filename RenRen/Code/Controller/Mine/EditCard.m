//
//  EditCard.m
//  RenRen
//
//  Created by Garfunkel on 2018/10/18.
//

#import "EditCard.h"

@interface EditCard ()<UITextFieldDelegate>

@property(nonatomic,strong) UIView* NewCardView;
@property(nonatomic,strong) UIButton* CardTitle;
@property(nonatomic,strong) UITextField* CardName;
@property(nonatomic,strong) UITextField* ExpiryLabel;
@property(nonatomic,strong) UITextField* CardNum;

@property(nonatomic,strong) UIButton* PaymentBtn;

@property(nonatomic,assign) NSString* credit_id;
@property(nonatomic,assign) NSString* is_default;
@end

@implementation EditCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(self.dict){
        self.credit_id = [self.dict objectForKey:@"id"];
        
        self.CardName.text = [self.dict objectForKey:@"name"];
        self.CardNum.text = [self.dict objectForKey:@"card_num"];
        self.ExpiryLabel.text = [self.dict objectForKey:@"expiry"];
        self.is_default = [self.dict objectForKey:@"is_default"];
        
        self.navigationItem.title = Localized(@"Credit_card");
    }else{
        self.navigationItem.title = Localized(@"ADD_CREDIT_CARD");
    }
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
    [self.NewCardView addSubview:self.CardTitle];
    
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
    self.CardNum.keyboardType = UIKeyboardTypeNumberPad;
    self.CardNum.translatesAutoresizingMaskIntoConstraints = NO;
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
    
    self.PaymentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.PaymentBtn.backgroundColor = [UIColor redColor];
    [self.PaymentBtn setTitleColor:theme_default_color forState:UIControlStateNormal];
    [self.PaymentBtn setTitle:Localized(@"Save_txt") forState:UIControlStateNormal];
    self.PaymentBtn.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.PaymentBtn.layer.masksToBounds = YES;
    self.PaymentBtn.layer.cornerRadius = 5.f;
    self.PaymentBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.PaymentBtn addTarget:self action:@selector(sendPayment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.PaymentBtn];
    
    
    NSInteger topMargin = StatusBarAndNavigationBarHeight;
    NSInteger bottomMargin = TabbarSafeBottomMargin + 5;
    NSArray* formats = @[
                         @"H:|-defEdge-[NewCardView]-defEdge-|",@"H:|-15-[PaymentBtn(==payWidth)]",
                         @"V:|-topMargin-[NewCardView(==200)]",@"V:[PaymentBtn(==baseHeight)]-bottomMargin-|"
                         ];
    NSDictionary* metrics = @{
                              @"defEdge":@(0),@"payWidth":@(SCREEN_WIDTH-30),@"topMargin":@(topMargin),@"bottomMargin":@(bottomMargin),@"baseHeight":@(40)
                              };
    NSDictionary* views = @{
                            @"NewCardView":self.NewCardView, @"PaymentBtn":self.PaymentBtn
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
}

-(void)layoutConstraints{
    NSArray* formats = @[
                         @"H:|-defEdge-[CardTitle]-defEdge-|",@"H:|-leftMargin-[CardName(==baseWidth)]",@"H:|-leftMargin-[CardNum(==baseWidth)]",@"H:|-leftMargin-[ExpiryLabel(==baseWidth)]",
                         @"V:|-baseTop-[CardTitle(==baseHeight)]-baseTop-[CardName(==baseHeight)]-baseTop-[CardNum(==baseHeight)]-baseTop-[ExpiryLabel(==baseHeight)]"
                         ];
    NSDictionary* metrics = @{
                              @"defEdge":@(0),@"leftMargin":@(10),@"baseWidth":@(SCREEN_WIDTH - 20),@"baseHeight":@(40),@"baseTop":@(5)
                              };
    NSDictionary* views = @{
                            @"CardTitle":self.CardTitle, @"CardName":self.CardName,@"CardNum":self.CardNum,@"ExpiryLabel":self.ExpiryLabel
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.NewCardView addConstraints:constraints];
    }
}

-(void)sendPayment{
    [self showHUD];
    NSDictionary* arg = @{@"a":@"edit_card",@"uid":self.Identity.userInfo.userID,@"card_num":self.CardNum.text,@"expiry":self.ExpiryLabel.text,@"name":self.CardName.text};
    if(self.credit_id)
        arg = @{@"a":@"edit_card",@"uid":self.Identity.userInfo.userID,@"card_id":self.credit_id,@"card_num":self.CardNum.text,@"expiry":self.ExpiryLabel.text,@"name":self.CardName.text,@"is_default":self.is_default};
    
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            [self alertHUD: Localized(@"Success_txt") complete:^{
                [self.navigationController popViewControllerAnimated:YES];
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

-(void)setDict:(NSDictionary *)dict{
    if(dict){
        _dict = dict;
    }
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
