//
//  OrderPaySuccess.m
//  KYRR
//
//  Created by kyjun on 16/6/22.
//
//

#import "OrderPaySuccess.h"

@interface OrderPaySuccess ()

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* iconSuccess;
@property(nonatomic,strong) UILabel* labelSuccess;

@property(nonatomic,strong) UIButton* btnGoShopping;
@property(nonatomic,strong) UIButton* btnGoOrder;

@end

@implementation OrderPaySuccess

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = theme_table_bg_color;
    self.navigationItem.hidesBackButton = YES;
    [self layoutUI];
    [self layoutConstraints];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title = @"支付成功";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.iconSuccess];
    [self.topView addSubview:self.labelSuccess];
    [self.view addSubview:self.btnGoShopping];
    [self.view addSubview:self.btnGoOrder];
}

-(void)layoutConstraints{
    self.topView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconSuccess.translatesAutoresizingMaskIntoConstraints = YES;
    self.labelSuccess.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnGoShopping.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnGoOrder.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.iconSuccess addConstraint:[NSLayoutConstraint constraintWithItem:self.iconSuccess attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.iconSuccess addConstraint:[NSLayoutConstraint constraintWithItem:self.iconSuccess attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.iconSuccess attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.iconSuccess attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSuccess attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSuccess attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSuccess attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.self.iconSuccess attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSuccess attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnGoOrder addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoOrder attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.btnGoOrder addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoOrder attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoOrder attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoOrder attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:SCREEN_WIDTH/4-10.f]];
    
    [self.btnGoShopping addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoShopping attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/4]];
    [self.btnGoShopping addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoShopping attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoShopping attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGoShopping attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnGoOrder attribute:NSLayoutAttributeRight multiplier:1.0 constant:20.f]];
    
}


#pragma mark =====================================================  SEL
-(IBAction)goOrderTouch:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeOrderPayStatus object:nil];
    }];
}
-(IBAction)goShoppingTouch:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark =====================================================  property package
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

-(UIImageView *)iconSuccess{
    if(!_iconSuccess){
        _iconSuccess = [[UIImageView alloc]init];
        [_iconSuccess setImage:[UIImage imageNamed:@"icon-order-success"]];
    }
    return _iconSuccess;
}

-(UILabel *)labelSuccess{
    if(!_labelSuccess){
        _labelSuccess = [[UILabel alloc]init];
        _labelSuccess.textColor = [UIColor redColor];
        _labelSuccess.textAlignment = NSTextAlignmentCenter;
        _labelSuccess.contentMode = UIViewContentModeCenter;
        _labelSuccess.text = @"\n\n支付成功!\n success!";
        _labelSuccess.numberOfLines = 0;
        _labelSuccess.font = [UIFont systemFontOfSize:20.f];
    }
    return _labelSuccess;
}

-(UIButton *)btnGoOrder{
    if(!_btnGoOrder){
        _btnGoOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnGoOrder.backgroundColor = [UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1.0];
        [_btnGoOrder setTitleColor:[UIColor colorWithRed:68/255.f green:68/255.f blue:68/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnGoOrder setTitle:@"查看订单" forState:UIControlStateNormal];
        [_btnGoOrder addTarget:self action:@selector(goOrderTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnGoOrder.layer.masksToBounds = YES;
        _btnGoOrder.layer.cornerRadius = 5.f;
        _btnGoOrder.layer.borderColor = [UIColor colorWithRed:68/255.f green:68/255.f blue:68/255.f alpha:1.0].CGColor;
        _btnGoOrder.layer.borderWidth = 1.f;
    }
    return _btnGoOrder;
}


-(UIButton *)btnGoShopping{
    if(!_btnGoShopping){
        _btnGoShopping = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnGoShopping.backgroundColor = [UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1.0];
        [_btnGoShopping setTitleColor:[UIColor colorWithRed:68/255.f green:68/255.f blue:68/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnGoShopping setTitle:@"查看订单" forState:UIControlStateNormal];
        [_btnGoShopping addTarget:self action:@selector(goShoppingTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnGoShopping.layer.masksToBounds = YES;
        _btnGoShopping.layer.cornerRadius = 5.f;
        _btnGoShopping.layer.borderColor = [UIColor colorWithRed:68/255.f green:68/255.f blue:68/255.f alpha:1.0].CGColor;
        _btnGoShopping.layer.borderWidth = 1.f;
    }
    return _btnGoShopping;
}

@end
