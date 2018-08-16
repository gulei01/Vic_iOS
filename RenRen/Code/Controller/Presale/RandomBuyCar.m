//
//  RandomBuyCar.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/8.
//
//

#import "RandomBuyCar.h"

@interface RandomBuyCar ()

@property(nonatomic,strong) UIView* leftView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UILabel* labelCoupon;//优惠
@property(nonatomic,strong) UILabel* labelMark;
@property(nonatomic,strong) UIButton* btnSubmit;
@property(nonatomic,assign) NSInteger couponPrice;
@property(nonatomic,assign) NSInteger deliveryPrice;
@property(nonatomic,assign) NSInteger tipPrice;

@end

@implementation RandomBuyCar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CALayer* border = [[CALayer alloc]init];
    border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1.f);
    border.backgroundColor = theme_line_color.CGColor;
    [self.view.layer addSublayer:border];
    [self layoutUI];
    [self layoutConstraints];
    self.couponPrice = 0;
    self.deliveryPrice = 0;
    self.tipPrice = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.view addSubview:self.leftView];
    [self.leftView addSubview:self.labelTitle];
    [self.leftView addSubview:self.labelPrice];
    [self.leftView addSubview:self.labelCoupon];
    [self.leftView addSubview:self.labelMark];
    [self.view addSubview:self.btnSubmit];
}

-(void)layoutConstraints{
    NSArray* formats = @[ @"H:|-defaultEdge-[leftView]-itemSpace-[btnSubmit(btnWidth)]-defaultEdge-|", @"V:|-defaultEdge-[leftView]-defaultEdge-|", @"V:|-defaultEdge-[btnSubmit]-defaultEdge-|",
                          @"H:|-HEdge-[labelTitle(>=titleWidth)]-defaultEdge-[labelPrice]-itemSpace-[labelCoupon(==75)]-defaultEdge-|",
                          @"H:|-HEdge-[labelMark]-HEdge-|",
                          @"V:|-defaultEdge-[labelTitle(==titleHeight)]-defaultEdge-[labelMark]-defaultEdge-|",
                          @"V:|-defaultEdge-[labelPrice(==titleHeight)]",
                          @"V:|-defaultEdge-[labelCoupon(==titleHeight)]"];
    NSDictionary* metrics = @{ @"defaultEdge":@(0), @"HEdge":@(10), @"VEdge":@(10), @"itemSpace":@(5), @"btnWidth":@(SCREEN_WIDTH/4), @"titleHeight":@(30), @"titleWidth":@(90), @"priceWidth":@(45.f)};
    NSDictionary* views = @{ @"leftView":self.leftView, @"btnSubmit":self.btnSubmit,
                             @"labelTitle":self.labelTitle, @"labelPrice":self.labelPrice, @"labelCoupon":self.labelCoupon, @"labelMark":self.labelMark};
    
    for (NSString* format in formats) {
        //  NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }
}

-(void)setDeliveryPrice:(NSInteger)price andTip:(NSInteger)tip{
    self.deliveryPrice = price;
    self.tipPrice = tip;
    [self loadData];
}

-(void)loadData{
    self.labelPrice.text =[NSString stringWithFormat: @"￥%ld元",(self.deliveryPrice+self.tipPrice-self.couponPrice)];
    if(self.tipPrice>0){
        self.labelTitle.text =  @"配送费+小费";
    }else{
        self.labelTitle.text =  @"配送费";
    }

}

-(void)setVouchers:(NSInteger)price{
    if(price>0){
        self.couponPrice = price;
        _labelCoupon.text = [NSString stringWithFormat: @"已优惠 ￥%ld",price];
    }else{
        self.couponPrice = 0;
        _labelCoupon.text = @"";
    }
    [self loadData];
}

-(IBAction)btnSubmitTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(submitRandomCar)]){
        [self.delegate submitRandomCar];
    }
}

#pragma mark =====================================================  property package
-(UIView *)leftView{
    if(!_leftView){
        _leftView = [[UIView alloc]init];
        _leftView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _leftView;
}

-(UIButton *)btnSubmit{
    if(!_btnSubmit){
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.backgroundColor = [UIColor redColor];
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSubmit setTitle: @"提交订单" forState:UIControlStateNormal];
        _btnSubmit.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnSubmit addTarget:self action:@selector(btnSubmitTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnSubmit.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnSubmit;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.text =  @"配送费";
        _labelTitle.font =[UIFont systemFontOfSize:14.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textColor = [UIColor redColor];
        _labelPrice.font = [UIFont systemFontOfSize:14.f];
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

-(UILabel *)labelCoupon{
    if(!_labelCoupon){
        _labelCoupon = [[UILabel alloc]init];
        _labelCoupon.textColor = [UIColor grayColor];
        _labelCoupon.font = [UIFont systemFontOfSize:12.f];
        _labelCoupon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCoupon;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.text =  @"配送费用与骑士结算";
        _labelMark.textColor = [UIColor grayColor];
        _labelMark.font = [UIFont systemFontOfSize:12.f];
        _labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMark;
}

@end
