//
//  Recharge.m
//  RenRen
//
//  Created by Garfunkel on 2018/11/22.
//

#import "Recharge.h"
#import "CreditPay.h"

@interface Recharge ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField* moneyText;
@property(nonatomic,strong)UIButton* payBtn;
@property(nonatomic,strong)UIView* showView;

@property(nonatomic,strong)NSDictionary* disList;

@property(nonatomic,assign)BOOL isHaveDian;
@property(nonatomic,strong) UIBarButtonItem* leftBarItem;
@end

@implementation Recharge

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.leftBarButtonItem = self.leftBarItem;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = Localized(@"Recharge_txt");
    [self layoutUI];
    [self queryData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)layoutUI{
    self.view.backgroundColor = theme_table_bg_color;
    
    self.moneyText = [[UITextField alloc] init];
    self.moneyText.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.moneyText.backgroundColor = [UIColor whiteColor];
    self.moneyText.placeholder = Localized(@"INPUT_RECHARGE");
    self.moneyText.keyboardType = UIKeyboardTypeNumberPad;
    self.moneyText.delegate = self;
    self.moneyText.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.moneyText];
    
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payBtn.backgroundColor = [UIColor redColor];
    [self.payBtn setTitleColor:theme_default_color forState:UIControlStateNormal];
    [self.payBtn setTitle:Localized(@"Recharge_txt") forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.payBtn.layer.masksToBounds = YES;
    self.payBtn.layer.cornerRadius = 5.f;
    self.payBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.payBtn addTarget:self action:@selector(ToPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payBtn];
    
    self.showView = [[UIView alloc]init];
    self.showView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.showView];
    
    NSInteger topMargin = StatusBarAndNavigationBarHeight + 20;
    //    NSInteger bottomMargin = TabbarSafeBottomMargin + 5;
    NSArray* formats = @[
                         @"H:|-defEdge-[moneyText]-defEdge-|",@"H:|-defEdge-[payBtn]-defEdge-|",@"H:|-defEdge-[showView]-defEdge-|",
                         @"V:|-topMargin-[moneyText(==baseHeight)]-30-[payBtn(==baseHeight)]-20-[showView]-defEdge-|"
                         ];
    NSDictionary* metrics = @{
                              @"defEdge":@(10),@"topMargin":@(topMargin),@"baseHeight":@(40)
                              };
    NSDictionary* views = @{
                            @"moneyText":self.moneyText,@"payBtn":self.payBtn,@"showView":self.showView
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
}

-(void)queryData{
    [self showHUD];
    NSDictionary* arg = @{@"a":@"getRechargeDis"};
    NetRepositories* repositories = [[NetRepositories alloc]init];
    [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
        [self hidHUD];
        if(react == 1){
            self.disList = [response objectForKey:@"info"];
            [self showDis];
        }else if(react == 400){
            [self alertHUD:message];
        }else{
            [self alertHUD:message];
        }
    }];
}

-(void)showDis{
    if([self.disList count] > 0){
        UILabel* showTitle = [[UILabel alloc]init];
        showTitle.text = [NSString stringWithFormat:@"%@:", Localized(@"Balance_pro")];
        showTitle.frame = CGRectMake(10, 5, 200, 20);
        [self.showView addSubview:showTitle];
        NSMutableArray* list;
        int i = 1;
        NSMutableArray *stringArray = [NSMutableArray arrayWithArray:self.disList.allKeys];
        [stringArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
            NSNumber *number1 = [NSNumber numberWithInteger:str1.floatValue];
            NSNumber *number2 = [NSNumber numberWithInteger:str2.floatValue];
            return [number1 compare:number2];
        }];
        for(NSString* k in stringArray){
            NSLog(@"garfunkel_log:%@ - %@",k,self.disList[k]);
            [list addObject:[NSString stringWithFormat:@"%@ - %@",k,self.disList[k]]];
            UILabel* newLine = [[UILabel alloc]init];
            newLine.text = [NSString stringWithFormat:@"%@ $%@ %@ $%@",Localized(@"Deposit_txt"),k,Localized(@"Earn_txt"),self.disList[k]];
            
            newLine.frame = CGRectMake(10, 25*i + 5, SCREEN_WIDTH - 20, 20);
            [self.showView addSubview:newLine];
            i++;
        }
    }
}

-(void)ToPay{
    if([self.moneyText.text isEqualToString:@""]){
        [self alertHUD:Localized(@"INPUT_RECHARGE")];
    }else{
        [self showHUD];
        NSDictionary* arg = @{@"a":@"createRechargeOrder",@"uid":self.Identity.userInfo.userID,@"money":self.moneyText.text};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories netConfirm:arg complete:^(NSInteger react, NSDictionary *response, NSString *message) {
            [self hidHUD];
            if(react == 1){
                NSString* order_id = [response objectForKey:@"info"];
                CreditPay* controller = [[CreditPay alloc]init];
                controller.tip_price = 0;
                controller.total_price = [self.moneyText.text doubleValue];
                controller.order_id = order_id;
                controller.order_type = @"recharge";
                
                UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
                //        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [nav.navigationBar setBackgroundColor:theme_navigation_color];
                [nav.navigationBar setBarTintColor:theme_navigation_color];
                [nav.navigationBar setTintColor:theme_default_color];
                [self.parentViewController presentViewController:nav animated:YES completion:^{
                    [self.navigationController popViewControllerAnimated:NO];
                }];
            }else if(react == 400){
                [self alertHUD:message];
            }else{
                [self alertHUD:message];
            }
        }];
    }
}

#pragma mark =====================================================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
     * 不能输入.0-9以外的字符。
     * 设置输入框输入的内容格式
     * 只能有一个小数点
     * 小数点后最多能输入两位
     * 如果第一位是.则前面加上0.
     * 如果第一位是0则后面必须输入点，否则不能输入。
     */
    
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
            [self alertHUD:Localized(@"Enter_Error")];
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
            [self alertHUD:Localized(@"Enter_Error")];
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
                    [self alertHUD:Localized(@"Enter_Error")];
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                    [self alertHUD:Localized(@"Enter_Error")];
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                    [self alertHUD:Localized(@"Enter_Error")];
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
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
