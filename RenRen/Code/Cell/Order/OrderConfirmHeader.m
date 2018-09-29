//
//  OrderConfirmHeader.m
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import "OrderConfirmHeader.h"
#import "SelectAddres.h"

@interface OrderConfirmHeader ()

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* iconLocation;
@property(nonatomic,strong) UIButton* btnAddress;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelAddress;

@property(nonatomic,strong) UIButton* btnOrderInfo;

@end

@implementation OrderConfirmHeader

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = theme_table_bg_color;
    [self layoutUI];
    [self layoutConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAddressNotification:) name:NotificationSelectedAddres object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.iconLocation];
    [self.topView addSubview:self.btnAddress];
    [self.btnAddress addSubview:self.labelUserName];
    [self.btnAddress addSubview:self.labelAddress];
    [self.view addSubview:self.btnOrderInfo];
}

-(void)layoutConstraints{
    self.topView. translatesAutoresizingMaskIntoConstraints = NO;
    self.iconLocation.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAddress.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.btnOrderInfo.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.iconLocation addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLocation attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.iconLocation addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLocation attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLocation attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLocation attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    CGFloat width = SCREEN_WIDTH - 30 - 20;
    
    [self.btnAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.btnAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.topView addConstraint: [NSLayoutConstraint constraintWithItem:self.btnAddress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconLocation attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelUserName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelUserName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.btnAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnAddress attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.btnAddress addConstraint: [NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnAddress attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.btnAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelUserName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.btnAddress addConstraint: [NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnAddress attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
   
    [self.btnOrderInfo addConstraint:[NSLayoutConstraint constraintWithItem:self.btnOrderInfo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnOrderInfo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnOrderInfo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btnOrderInfo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];    
    
}

#pragma mark =====================================================  SEL
-(IBAction)selectAddress:(id)sender{
    SelectAddres* controller = [[SelectAddres alloc]init];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:controller];
    [nav.navigationBar setBackgroundColor:theme_navigation_color];
    [nav.navigationBar setBarTintColor:theme_navigation_color];
    [nav.navigationBar setTintColor:theme_default_color];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark =====================================================  Notification
-(void)selectAddressNotification:(NSNotification*)notification{
    MAddress* empty = (MAddress*)[notification object];
    if(empty){
        self.entity = empty;
    }
}

#pragma mark =====================================================  property pacakge
-(void)setEntity:(MAddress *)entity{
    if(entity){
        _entity = entity;
        self.labelUserName.text = [NSString stringWithFormat:@"%@:%@ %@",Localized(@"Receiver_txt"),entity.userName,entity.phoneNum];
        self.labelAddress.text = [NSString stringWithFormat:@"%@: %@",Localized(@"Shipping_address"),entity.address];
        [self.btnAddress setTitle:@"" forState:UIControlStateNormal];
    }else{
        self.labelUserName.hidden = YES;
        self.labelAddress.hidden = YES;
        [self.btnAddress setTitle:Localized(@"Add_new_address") forState:UIControlStateNormal];
    }
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        CALayer* bordr = [[CALayer alloc]init];
        bordr.frame = CGRectMake(0, 0, SCREEN_WIDTH, 5.f);
        bordr.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon-line-address"]].CGColor;
        [_topView.layer addSublayer:bordr];
        
        bordr = [[CALayer alloc]init];
        bordr.frame = CGRectMake(0, 65, SCREEN_WIDTH, 5.f);
        bordr.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon-line-address"]].CGColor;
        [_topView.layer addSublayer:bordr];
    }
    return _topView;
}



-(UIImageView *)iconLocation{
    if(!_iconLocation){
        _iconLocation = [[UIImageView alloc]init];
        [_iconLocation setImage:[UIImage imageNamed:@"icon-address"]];
    }
    return _iconLocation;
}

-(UIButton *)btnAddress{
    if(!_btnAddress){
        _btnAddress = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAddress setTitleColor:[UIColor colorWithRed:68/255.f green:66/255.f blue:67/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnAddress addTarget:self action:@selector(selectAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddress;
}

-(UILabel *)labelUserName{
    if(!_labelUserName){
        _labelUserName = [[UILabel alloc]init];
        _labelUserName.textColor = [UIColor colorWithRed:68/255.f green:66/255.f blue:67/255.f alpha:1.0];
        _labelUserName.text = @"LabelUserName";
        _labelUserName.font =[UIFont systemFontOfSize:14.f];
    }
    return _labelUserName;
}

-(UILabel *)labelAddress{
    if(!_labelAddress){
        _labelAddress = [[UILabel alloc]init];
        _labelAddress.text = @"labelAddress";
        _labelAddress.textColor = [UIColor colorWithRed:68/255.f green:66/255.f blue:67/255.f alpha:1.0];
        _labelAddress.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelAddress;
}

-(UIButton *)btnOrderInfo{
    if(!_btnOrderInfo){
        _btnOrderInfo = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOrderInfo.backgroundColor = [UIColor whiteColor];
       _btnOrderInfo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       _btnOrderInfo.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-35);
       _btnOrderInfo.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_btnOrderInfo setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
        _btnOrderInfo.userInteractionEnabled = NO;
        [_btnOrderInfo setTitleColor:[UIColor colorWithRed:68/255.f green:66/255.f blue:67/255.f alpha:1.0] forState:UIControlStateNormal];
        _btnOrderInfo.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnOrderInfo setTitle:Localized(@"Order_info") forState:UIControlStateNormal];
        CALayer* bordr = [[CALayer alloc]init];
        bordr.frame = CGRectMake(0, 39, SCREEN_WIDTH, 1.f);
        bordr.backgroundColor =  theme_line_color.CGColor;
        [_btnOrderInfo.layer addSublayer:bordr];
    }
    return _btnOrderInfo;
}




@end
