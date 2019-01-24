//
//  CouponCode.m
//  RenRen
//
//  Created by Garfunkel on 2018/11/16.
//

#import "CouponCode.h"

@interface CouponCode ()
@property(nonatomic,strong)UITextField* codeText;
@property(nonatomic,strong)UIButton* applyBtn;
@property(nonatomic,strong)UIBarButtonItem* leftBarItem;
@end

@implementation CouponCode

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.leftBarButtonItem = self.leftBarItem;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationItem.title = Localized(@"EXCHANGE_COUPON");
    [self layoutUI];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)layoutUI{
    self.view.backgroundColor = theme_table_bg_color;
    
    self.codeText = [[UITextField alloc] init];
    self.codeText.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    self.codeText.backgroundColor = [UIColor whiteColor];
    self.codeText.placeholder = Localized(@"INPUT_EXCHANGE_CODE");
    self.codeText.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.codeText];
    
    self.applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyBtn.backgroundColor = [UIColor redColor];
    [self.applyBtn setTitleColor:theme_default_color forState:UIControlStateNormal];
    [self.applyBtn setTitle:Localized(@"EXCHANGE_TXT") forState:UIControlStateNormal];
    self.applyBtn.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.applyBtn.layer.masksToBounds = YES;
    self.applyBtn.layer.cornerRadius = 5.f;
    self.applyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.applyBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.applyBtn];
    
    NSInteger topMargin = StatusBarAndNavigationBarHeight + 20;
//    NSInteger bottomMargin = TabbarSafeBottomMargin + 5;
    NSArray* formats = @[
                         @"H:|-defEdge-[codeText]-defEdge-|",@"H:|-defEdge-[applyBtn]-defEdge-|",
                         @"V:|-topMargin-[codeText(==baseHeight)]-30-[applyBtn(==baseHeight)]"
                         ];
    NSDictionary* metrics = @{
                              @"defEdge":@(10),@"topMargin":@(topMargin),@"baseHeight":@(40)
                              };
    NSDictionary* views = @{
                            @"codeText":self.codeText,@"applyBtn":self.applyBtn
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
}

-(void)sendCode{
    if([self.codeText.text isEqualToString:@""]){
        [self alertHUD:Localized(@"INPUT_EXCHANGE_CODE")];
    }else{
        [self showHUD];
        NSDictionary* arg = @{@"a":@"coupon_code",@"uid":self.Identity.userInfo.userID,@"code":self.codeText.text};
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
