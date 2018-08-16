//
//  RandomOrderCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/18.
//
//

#import "RandomOrderCell.h"


@interface RandomOrderCell ()

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UILabel* labelOrder;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UIButton* btnPay;
@end

@implementation RandomOrderCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    
    [self addSubview:self.topView];
    [self.topView addSubview:self.labelOrder];
    [self.topView addSubview:self.labelStatus];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelTitle];
    [self.bottomView addSubview:self.labelName];
    [self.bottomView addSubview:self.btnPay];
    for (UIView * subView in self.subviews) {
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        for (UIView* empty in subView.subviews) {
            empty.translatesAutoresizingMaskIntoConstraints = NO;
        }
    }
    
    NSArray* formats = @[@"H:|-defEdge-[topView]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|", @"V:|-defEdge-[topView][bottomView(topView)]-defEdge-|",
                         @"H:|-leftEdge-[labelOrder]-defEdge-[labelStatus(==statusWidth)]-leftEdge-|", @"V:|-topEdge-[labelOrder]-defEdge-|", @"V:|-topEdge-[labelStatus]-defEdge-|",
                         @"H:|-leftEdge-[labelTitle(==70)][labelName]-leftEdge-[btnPay(==paySize)]-leftEdge-|",@"V:|-defEdge-[labelTitle]-defEdge-|", @"V:|-defEdge-[labelName]-defEdge-|", @"V:|-topEdge-[btnPay]-topEdge-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"paySize":@(60), @"statusWidth":@(100)};
    NSDictionary* views = @{ @"topView":self.topView, @"bottomView":self.bottomView, @"labelOrder":self.labelOrder, @"labelStatus":self.labelStatus, @"labelTitle":self.labelTitle, @"labelName":self.labelName, @"btnPay":self.btnPay};
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
    
}

#pragma mark =====================================================  SEL
-(IBAction)btnPayTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(fromOrderPay:)]){
        [self.delegate fromOrderPay:self.item];
    }
}



#pragma mark =====================================================  property package

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        self.labelOrder.text = [NSString stringWithFormat: @"订单号:%@",[item objectForKey: @"order_id"]];
        self.labelStatus.text = [item objectForKey: @"statustext"];
        if([ @"buy" isEqualToString:[item objectForKey: @"type"]]){
            self.labelTitle.text =  @"购买商品 : ";
        }else{
            self.labelTitle.text =  @"物品信息 : ";
        }
        self.labelName.text = [item objectForKey: @"title"];
        NSInteger status = [[item objectForKey: @"status"]integerValue ];
        if( status== 1){
            self.btnPay.hidden = NO;
        }else{
            self.btnPay.hidden = YES;
        }
        
        
        switch (status) {
            case -1://订单已取消
            {
                self.labelStatus.textColor = theme_Fourm_color;
            }
                break;
            case 0: //订单提交成功
            {
             self.labelStatus.textColor = theme_navigation_color;
            }
                break;
            case 1: //待支付
            {
                self.labelStatus.textColor = theme_navigation_color;
            }
                break;
            case 2: //支付成功
            {
                self.labelStatus.textColor = theme_navigation_color;
            }
                break;
            case 3: //退款中
            {
                self.labelStatus.textColor = theme_navigation_color;
            }
                break;
            case 4: //已退款
            {
                self.labelStatus.textColor = theme_navigation_color;
            }
                break;
            case 5: //已接单
            {
                
            }
                break;
            case 6: //已取货
            {
                
            }
                break;
            case 7: //订单完成
            {
             self.labelStatus.textColor = [UIColor colorWithRed:64/255.f green:156/255.f blue:107/255.f alpha:1.0];
            }
                break;
                
            default:
                break;
        }
    }
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        border.backgroundColor = theme_table_bg_color.CGColor;
        [_topView.layer addSublayer:border];
    }
    return _topView;
}

-(UILabel *)labelOrder{
    if(!_labelOrder){
        _labelOrder = [[UILabel alloc]init];
        _labelOrder.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelOrder;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
        _labelStatus.textAlignment = NSTextAlignmentRight;
        _labelStatus.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelStatus;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_bottomView.layer addSublayer:border];
    }
    return _bottomView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelTitle;
}

-(UILabel *)labelName{
    if(!_labelName){
        _labelName = [[UILabel alloc]init];
        _labelName.numberOfLines = 2;
        _labelName.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelName;
}

-(UIButton *)btnPay{
    if(!_btnPay){
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnPay setTitle: @"去支付" forState:UIControlStateNormal];
        _btnPay.layer.masksToBounds = YES;
        _btnPay.layer.borderColor = theme_line_color.CGColor;
        _btnPay.layer.cornerRadius = 5;
        _btnPay.layer.borderWidth = 1;
        _btnPay.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnPay addTarget:self action:@selector(btnPayTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPay;
}

@end
