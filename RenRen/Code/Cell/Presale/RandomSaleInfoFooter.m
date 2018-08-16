//
//  RandomSaleFooter.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import "RandomSaleInfoFooter.h"

@interface RandomSaleInfoFooter ()<UITextFieldDelegate>
@property(nonatomic,strong) UIView* weightView;
@property(nonatomic,strong) UILabel* labelWeight;
@property(nonatomic,strong) UITextField* txtWeight;
@property(nonatomic,strong) UIButton* btnSub;
@property(nonatomic,strong) UIButton* btnAdd;

@property(nonatomic,strong) UIView* priceView;
@property(nonatomic,strong) UILabel* labelPrice;

@property(nonatomic,strong) UIImageView* priceArrow;
@property(nonatomic,strong) UILabel* labelMark;
@property(nonatomic,assign) NSInteger limitWeight;
@property(nonatomic,assign) NSInteger weight;
@end

@implementation RandomSaleInfoFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        NSUserDefaults* conf = [NSUserDefaults standardUserDefaults];
        NSDictionary* item = [conf objectForKey:kRandomBuyConfig];
        self.limitWeight = [[item objectForKey: @"weight_limit"]integerValue];
        self.weight = 1;
        
        self.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        border.backgroundColor =[UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0].CGColor;
        [self.layer addSublayer:border];

        [self addSubview:self.weightView];
        [self.weightView addSubview:self.labelWeight];
        [self.weightView addSubview:self.txtWeight];
        [self addSubview:self.priceView];
        [self.priceView addSubview:self.labelPrice];
        [self.priceView addSubview:self.txtMoney];
        [self.priceView addSubview:self.priceArrow];
        [self.priceView addSubview:self.labelMark];
        
        NSArray* formats = @[
                             @"H:|-defEdge-[weightView]-defEdge-|",@"H:|-defEdge-[priceView]-defEdge-|",
                             @"V:|-topEdge-[weightView(==weightHeight)]-0-[priceView]-defEdge-|",
                             @"H:|-leftEdge-[labelWeight][txtWeight(==weightWidth)]-leftEdge-|",@"V:|-topEdge-[labelWeight]-topEdge-|", @"V:|-topEdge-[txtWeight]-topEdge-|",
                             @"H:|-defEdge-[labelPrice][txtMoney(==100)]-5-[priceArrow(==8)]-leftEdge-|",
                             @"V:|-topEdge-[labelPrice(==20)]", @"V:|-topEdge-[txtMoney(==20)]", @"V:|-13-[priceArrow(==14)]",
                             @"V:[labelPrice]-10-[labelMark]-topEdge-|"
                             ];
        NSDictionary* metrics = @{
                                  @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"itemHeight":@(20), @"weightHeight":@(45), @"priceHeight":@(60), @"weightWidth":@(100)
                                  };
        NSDictionary* views = @{
                                @"weightView":self.weightView, @"priceView":self.priceView, @"labelWeight":self.labelWeight, @"txtWeight":self.txtWeight,
                                @"labelPrice":self.labelPrice, @"txtMoney":self.txtMoney, @"priceArrow":self.priceArrow, @"labelMark":self.labelMark
                                };
        
        for (NSString* format in formats) {
           // NSLog( @"%@ %@",[self class],format);
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }
        _txtWeight.text = [NSString stringWithFormat: @"%ldkg",self.weight];
    }
    return self;
}

#pragma mark =====================================================  UITextFeildDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return NO;
    
}

#pragma mark =====================================================  SEL
-(IBAction)btnSubTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(subWeight)]){
        if(self.weight>1){
            self.weight-=1;
            [self.delegate addWeight];
        }else{
            self.weight = 1;
        }
         self.txtWeight.text = [NSString stringWithFormat: @"%ldkg",self.weight];
    }
}

-(IBAction)btnAddTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addWeight)]){
        
        if(self.weight<self.limitWeight){
            self.weight+=1;
            [self.delegate addWeight];
        }else{
            self.weight = self.limitWeight;
        }
        self.txtWeight.text = [NSString stringWithFormat: @"%ldkg",self.weight];
    }
}

-(IBAction)btnPriceTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(changePrice)]){
        [self.delegate changePrice];
    }
}

-(void)setMoneyInputView:(UIPickerView *)pickerView{
    self.txtMoney.inputView = pickerView;
}
#pragma mark =====================================================  property package
-(UIView *)weightView{
    if(!_weightView){
        _weightView = [[UIView alloc]init];
        _weightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _weightView;
}

-(UILabel *)labelWeight{
    if(!_labelWeight){
        _labelWeight = [[UILabel alloc]init];
        _labelWeight.font =[UIFont systemFontOfSize:14.f];
        _labelWeight.text =  @"重量";
        _labelWeight.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelWeight;
}

-(UITextField *)txtWeight{
    if(!_txtWeight){
        _txtWeight = [[UITextField alloc]init];
        _txtWeight.backgroundColor = [UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0];
        _txtWeight.borderStyle = UITextBorderStyleNone;
        _txtWeight.delegate = self;
        _txtWeight.layer.masksToBounds = YES;
         _txtWeight.layer.borderColor = [UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0].CGColor;
        _txtWeight.layer.borderWidth = 1.f;
        _txtWeight.layer.cornerRadius = 25/2;
        _txtWeight.textColor = [UIColor redColor];
        _txtWeight.font = [UIFont systemFontOfSize:15.f];
        _txtWeight.leftView = self.btnSub;
        _txtWeight.leftViewMode = UITextFieldViewModeAlways;
        _txtWeight.rightView = self.btnAdd;
        _txtWeight.rightViewMode = UITextFieldViewModeAlways;
        _txtWeight.textAlignment = NSTextAlignmentCenter;
        _txtWeight.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtWeight;
}

-(UIButton *)btnSub{
    if(!_btnSub){
        _btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSub.backgroundColor = [UIColor whiteColor];
        _btnSub.frame = CGRectMake(0, 0, 30, 25);
        [_btnSub setTitleColor:[UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0] forState:UIControlStateNormal];
        [_btnSub setTitle: @"-" forState:UIControlStateNormal];
        _btnSub.titleLabel.font = [UIFont systemFontOfSize:20.f];
        [_btnSub addTarget:self action:@selector(btnSubTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSub;
}

-(UIButton *)btnAdd{
    if(!_btnAdd){
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAdd.backgroundColor = [UIColor whiteColor];
        _btnAdd.frame = CGRectMake(0, 0, 30, 25);
        [_btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btnAdd setTitle: @"+" forState:UIControlStateNormal];
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:20.f];
        _btnAdd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_btnAdd addTarget:self action:@selector(btnAddTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAdd;
}

-(UIView *)priceView{
    if(!_priceView){
        _priceView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = [UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.].CGColor;
        [_priceView.layer addSublayer:border];
        _priceView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceView;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.text =  @"商品价值";
        _labelPrice.font = [UIFont systemFontOfSize:14.f];
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

-(UITextField *)txtMoney{
    if(!_txtMoney){
        _txtMoney = [[UITextField alloc]init];
        _txtMoney.text =  @"100元以下";
        _txtMoney.font = [UIFont systemFontOfSize:14.f];
        _txtMoney.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _txtMoney;
}

-(UIImageView *)priceArrow{
    if(!_priceArrow){
        _priceArrow = [[UIImageView alloc]init];
        [_priceArrow setImage:[UIImage imageNamed: @"icon-arrow-right"]];
        _priceArrow.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceArrow;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.text =  @"贵重物品请慎重，请将物品打包至可发送状态";
        _labelMark.font = [UIFont systemFontOfSize:12.f];
        _labelMark.textColor = [UIColor grayColor];
        _labelMark.textAlignment = NSTextAlignmentCenter;
        _labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMark;
}

@end
