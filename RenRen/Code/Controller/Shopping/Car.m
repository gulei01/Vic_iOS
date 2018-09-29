//
//  Car.m
//  KYRR
//
//  Created by kyjun on 16/6/15.
//
//

#import "Car.h"

@interface Car ()

@property(nonatomic,strong) UIView* bottomView;
/**
 *  当前购物车总金额
 */
@property(nonatomic,strong) UILabel* labelSumPrice;
/**
 *
 */
@property(nonatomic,strong) UILabel* labelOtherPrice;
/**
 *  去购买
 */
@property(nonatomic,strong) UIButton* btnBuy;

@property(nonatomic,strong) UIView* numView;
/**
 *  购物车图标
 */
@property(nonatomic,strong) UIImageView* photoCar;
/**
 *  商品数量
 */
@property(nonatomic,strong) UILabel* labelNum;

@property(nonatomic,strong) NSMutableArray<MStore*>* arrayShopCar;

@property(nonatomic,assign) float sumPrice;
@property(nonatomic,assign) NSInteger sumNum;
@property(nonatomic,assign) MCar* entity;

@end

@implementation Car

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = theme_table_bg_color;
    [self layoutUI];
    [self layoutConstraints];    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryData) name:NotificationRefreshShopCar object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //garfunkel modify
    //[self queryData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelSumPrice];
    [self.bottomView addSubview:self.labelOtherPrice];
    [self.bottomView addSubview:self.btnBuy];
    [self.view addSubview:self.numView];
    
    self.photoCar.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoCarClicked:)];
    [self.photoCar addGestureRecognizer:recognizer];
    
    [self.numView addSubview:self.photoCar];
    [self.numView addSubview:self.labelNum];
}

-(void)layoutConstraints{
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSumPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOtherPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnBuy.translatesAutoresizingMaskIntoConstraints = NO;
    self.numView.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoCar.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelNum.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelSumPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2-10]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSumPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelOtherPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOtherPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelSumPrice attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.btnBuy addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnBuy attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.numView addConstraint:[NSLayoutConstraint constraintWithItem:self.numView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.numView addConstraint:[NSLayoutConstraint constraintWithItem:self.numView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.numView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.numView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    
    [self.photoCar addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.photoCar addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.numView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.numView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.numView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoCar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.numView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.labelNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.numView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.numView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:25.f]];
    [self.numView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.numView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-30.f]];
    
}


#pragma mark =====================================================  DataSource
-(void)queryData{
    if(self.Identity.userInfo.isLogin){
        NSLog(@"garfunkel_log:getCartData");
//        NSDictionary* arg = @{@"ince":@"getcart",@"zoneid":self.Identity.location.circleID,@"uid":self.Identity.userInfo.userID};
        NSDictionary* arg = @{@"a":@"getCart",@"uid":self.Identity.userInfo.userID};
        NetRepositories* repositories = [[NetRepositories alloc]init];
        [repositories queryShopCar_V2:arg complete:^(NSInteger react, MCar *entity, NSString *message) {
            if(react == 1){
                //garfunkel add
                self.entity = entity;
                //
                [self.arrayShopCar removeAllObjects];
                self.sumPrice = [entity.sumMoney floatValue];
                self.sumNum = [entity.sumNum integerValue];
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    [UIView animateWithDuration:0.7 animations:^{
                        self.labelNum.text = [WMHelper integerConvertToString:self.sumNum];
                        if(self.sumPrice>=[@"9.00" floatValue]){
                            self.labelSumPrice.frame = CGRectMake(0, 0, SCREEN_WIDTH*2/3-10, 45.f);
                            self.labelOtherPrice.hidden = YES;
                            self.btnBuy.hidden = NO;
                        }else{
                            self.labelSumPrice.frame = CGRectMake(0, 0, SCREEN_WIDTH/2-10, 45.f);
                            self.labelOtherPrice.hidden = NO;
                            self.btnBuy.hidden = YES;
                            self.labelOtherPrice.text =[NSString stringWithFormat:@"%@ $%.2f",Localized(@"Still_need_num"),[@"9.00" floatValue] - self.sumPrice];
                        }
                        self.labelSumPrice.text = [NSString stringWithFormat:@"%@ $%.2f",Localized(@"Subtotal_txt"),self.sumPrice];
                    }];
                });
                //garfunkel add
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationUpdateGoodList object:self.entity];
            }else{
                self.labelNum.text =@"0";
                self.labelSumPrice.text =[NSString stringWithFormat:@"%@ $0.00  ",Localized(@"Subtotal_txt")];
                self.labelOtherPrice.hidden = NO;
                self.btnBuy.hidden = YES;
                self.labelOtherPrice.text =[NSString stringWithFormat:@"%@ $9.00",Localized(@"Still_need_num")] ;
            }

        }];
    }

    
}
#pragma mark =====================================================  SEL
-(IBAction)goBuy:(id)sender{
    if(self.tabBarController.selectedIndex ==1){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    self.tabBarController.selectedIndex = 1;
    }
}

- (void)photoCarClicked:(UITapGestureRecognizer *)recognizer {
    if(self.Identity.userInfo.isLogin){
        if(self.tabBarController.selectedIndex ==1){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            self.tabBarController.selectedIndex = 1;
        }
    }else{
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:[[Login alloc]init]];
        [nav.navigationBar setBackgroundColor:theme_navigation_color];
        [nav.navigationBar setBarTintColor:theme_navigation_color];
        [nav.navigationBar setTintColor:theme_default_color];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark =====================================================  property package

-(NSMutableArray<MStore *> *)arrayShopCar{
    if(!_arrayShopCar){
        _arrayShopCar = [[NSMutableArray<MStore*> alloc]init];
    }
    return _arrayShopCar;
}
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.7f;
    }
    return _bottomView;
}

-(UILabel *)labelSumPrice{
    if(!_labelSumPrice){
        _labelSumPrice = [[UILabel alloc]init];
        _labelSumPrice .backgroundColor = [UIColor blackColor];
        _labelSumPrice.alpha=0.7f;
        _labelSumPrice.textColor = [UIColor whiteColor];
        _labelSumPrice.text =[NSString stringWithFormat:@"%@ $0.00  ",Localized(@"Subtotal_txt")];;
        _labelSumPrice.textAlignment = NSTextAlignmentRight;
        _labelSumPrice.font = [UIFont systemFontOfSize:15.f];
    }
    return _labelSumPrice;
}

-(UILabel *)labelOtherPrice{
    if(!_labelOtherPrice){
        _labelOtherPrice = [[UILabel alloc]init];
        _labelOtherPrice.backgroundColor = [UIColor darkGrayColor];
        _labelOtherPrice.alpha=0.7f;
        _labelOtherPrice.textColor = [UIColor whiteColor];
        _labelOtherPrice.text =[NSString stringWithFormat:@"%@ $9.00",Localized(@"Still_need_num")];
        _labelOtherPrice.textAlignment = NSTextAlignmentCenter;
        _labelOtherPrice.font = [UIFont systemFontOfSize:15.f];
        _labelOtherPrice.hidden = NO;
        
    }
    return _labelOtherPrice;
}

-(UIButton *)btnBuy{
    if(!_btnBuy){
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBuy.backgroundColor = [UIColor redColor];
        _btnBuy.alpha = 0.7f;
        [_btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnBuy setTitle:Localized(@"Settlement") forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnBuy.hidden = YES;
        _btnBuy.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_btnBuy addTarget:self action:@selector(goBuy:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBuy;
}

-(UIView *)numView{
    if(!_numView){
        _numView = [[UIView alloc]init];
        _numView.tag = 1994;
    }
    return _numView;
}

-(UIImageView *)photoCar {
    if(!_photoCar){
        _photoCar = [[UIImageView alloc]init];
        _photoCar.tag = 1117;
        [_photoCar setImage:[UIImage imageNamed:@"icon-shop-car"]];
    }
    return _photoCar;
}

-(UILabel *)labelNum{
    if(!_labelNum){
        _labelNum = [[UILabel alloc]init];
        _labelNum.layer.masksToBounds = YES;
        _labelNum.layer.cornerRadius = 10;
        _labelNum.backgroundColor = theme_navigation_color;
        _labelNum.textColor = [UIColor whiteColor];
        _labelNum.text = @"0";
        _labelNum.textAlignment = NSTextAlignmentCenter;
        _labelNum.font = [UIFont systemFontOfSize:12.f];
    }
    return _labelNum;
}


@end
