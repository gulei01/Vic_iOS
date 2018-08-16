//
//  RandomOrderInfoFooter.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/18.
//
//

#import "RandomOrderInfoFooter.h"

@interface RandomOrderInfoFooter ()

@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIView* deliveryView;
@property(nonatomic,strong) UILabel* labelDelivery;
@property(nonatomic,strong) UILabel* labelDeliveryVal;
@property(nonatomic,strong) UIView* timeView;
@property(nonatomic,strong) UILabel* labelTime;
@property(nonatomic,strong) UILabel* labelTimeVal;
@property(nonatomic,strong) UIView* addressView;
@property(nonatomic,strong) UILabel* labelAddress;
@property(nonatomic,strong) UILabel* labelAddressVal;
@property(nonatomic,strong) UIView* orderView;
@property(nonatomic,strong) UILabel* labelOrder;
@property(nonatomic,strong) UILabel* labelOrderVal;

@end

@implementation RandomOrderInfoFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = theme_line_color;
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    NSInteger itemHeight = 40, iconSize = 20, arrowHeight = 14, arrowWidth = 8,  titleWidth = 120,defEdge = 0, leftEdge = 10, topEdge = 10,  itemSpace = 10;
    [self addSubview:self.labelTitle];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.deliveryView];
    [self.deliveryView addSubview:self.labelDelivery];
    [self.deliveryView addSubview:self.labelDeliveryVal];
    [self.bottomView addSubview:self.timeView];
    [self.timeView addSubview:self.labelTime];
    [self.timeView addSubview:self.labelTimeVal];
    [self.bottomView addSubview:self.addressView];
    [self.addressView addSubview:self.labelAddress];
    [self.addressView addSubview:self.labelAddressVal];
    [self.bottomView addSubview:self.orderView];
    [self.orderView addSubview:self.labelOrder];
    [self.orderView addSubview:self.labelOrderVal];
    
    
    [self layoutConstraints:@[ @"H:|-leftEdge-[labelTitle]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|",
                               @"V:|-defEdge-[labelTitle(==itemHeight)][bottomView]-defEdge-|",
                               
                               @"H:|-defEdge-[deliveryView]-defEdge-|",
                               @"H:|-defEdge-[timeView]-defEdge-|",
                               @"H:|-defEdge-[addressView]-defEdge-|",
                               @"H:|-defEdge-[orderView]-defEdge-|",
                               @"V:|-defEdge-[deliveryView][timeView(deliveryView)][addressView(==70)][orderView(deliveryView)]-defEdge-|",
                               
                               @"H:|-leftEdge-[labelDelivery(==titleWidth)][labelDeliveryVal]-defEdge-|", @"V:|-defEdge-[labelDelivery]-defEdge-|", @"V:|-defEdge-[labelDeliveryVal]-defEdge-|",
                               
                              @"H:|-leftEdge-[labelTime(==titleWidth)][labelTimeVal]-defEdge-|", @"V:|-defEdge-[labelTime]-defEdge-|", @"V:|-defEdge-[labelTimeVal]-defEdge-|",
                               
                               @"H:|-leftEdge-[labelAddress(==titleWidth)][labelAddressVal]-leftEdge-|", @"V:|-defEdge-[labelAddress]-defEdge-|", @"V:|-defEdge-[labelAddressVal]-defEdge-|",
                               
                              @"H:|-leftEdge-[labelOrder(==titleWidth)][labelOrderVal]-defEdge-|", @"V:|-defEdge-[labelOrder]-defEdge-|", @"V:|-defEdge-[labelOrderVal]-defEdge-|",
                               
                               ]
                    options:0
                    metrics:@{
                              @"defEdge":@(defEdge), @"leftEdge":@(leftEdge), @"topEdge":@(topEdge), @"itemHeight":@(itemHeight), @"titleWidth":@(80)
                              }
                      views:@{
                              @"labelTitle":self.labelTitle, @"bottomView":self.bottomView,
                              @"deliveryView":self.deliveryView, @"timeView":self.timeView, @"addressView":self.addressView, @"orderView":self.orderView,
                              @"labelDelivery":self.labelDelivery, @"labelDeliveryVal":self.labelDeliveryVal,
                              @"labelTime":self.labelTime, @"labelTimeVal":self.labelTimeVal,
                              @"labelAddress":self.labelAddress, @"labelAddressVal":self.labelAddressVal,
                              @"labelOrder":self.labelOrder, @"labelOrderVal":self.labelOrderVal
                              }
                  superView:self];
    
}

-(void)layoutConstraints:(NSArray*)formats options:(NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views superView:(UIView*)superView{
    for (NSString* format in formats) {
    //    NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
        [superView addConstraints:constraints];
    }
}

#pragma mark =====================================================  property pacakge
-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        self.labelDeliveryVal.text = [[item objectForKey: @"emp_info"] objectForKey: @"realname"];
        self.labelTimeVal.text =  [item objectForKey: @"time"];
      NSString* str = [NSString stringWithFormat: @"%@ %@ \n%@",[item objectForKey: @"uname"],[item objectForKey: @"phone"],[item objectForKey: @"address"]];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
        self.labelAddressVal.attributedText = attributeStr;
        self.labelOrderVal.text = [item objectForKey: @"order_id"];
    }
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.text =  @"其他信息";
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        _labelTitle.textColor = [UIColor grayColor];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UIView *)deliveryView{
    if(!_deliveryView){
        _deliveryView = [[UIView alloc]init];
        _deliveryView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _deliveryView;
}

-(UILabel *)labelDelivery{
    if(!_labelDelivery){
        _labelDelivery = [[UILabel alloc]init];
        _labelDelivery.text =  @"配送方";
        _labelDelivery.textColor = [UIColor grayColor];
        _labelDelivery.font = [UIFont systemFontOfSize:14.f];
        _labelDelivery.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDelivery;
}

-(UILabel *)labelDeliveryVal{
    if(!_labelDeliveryVal){
        _labelDeliveryVal = [[UILabel alloc]init];
        _labelDeliveryVal.font = [UIFont systemFontOfSize:15.f];
        _labelDeliveryVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDeliveryVal;
}

-(UIView *)timeView{
    if(!_timeView){
        _timeView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_timeView.layer addSublayer:border];
        _timeView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _timeView;
}

-(UILabel *)labelTime{
    if(!_labelTime){
        _labelTime = [[UILabel alloc]init];
        _labelTime.text =  @"配送时间";
        _labelTime.textColor = [UIColor grayColor];
        _labelTime.font = [UIFont systemFontOfSize:14.f];
        _labelTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTime;
}

-(UILabel *)labelTimeVal{
    if(!_labelTimeVal){
        _labelTimeVal = [[UILabel alloc]init];
        _labelTimeVal.font = [UIFont systemFontOfSize:15.f];
        _labelTimeVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTimeVal;
}

-(UIView *)addressView{
    if(!_addressView){
        _addressView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_addressView.layer addSublayer:border];
        _addressView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _addressView;
}

-(UILabel *)labelAddress{
    if(!_labelAddress){
        _labelAddress = [[UILabel alloc]init];
        _labelAddress.text =  @"收货信息";
        _labelAddress.textColor = [UIColor grayColor];
        _labelAddress.font = [UIFont systemFontOfSize:14.f];
        _labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelAddress;
}

-(UILabel *)labelAddressVal{
    if(!_labelAddressVal){
        _labelAddressVal = [[UILabel alloc]init];
        _labelAddressVal.font = [UIFont systemFontOfSize:14.f];
        _labelAddressVal.numberOfLines = 3;
        _labelAddressVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelAddressVal;
}

-(UIView *)orderView{
    if(!_orderView){
        _orderView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_orderView.layer addSublayer:border];
        _orderView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _orderView;
}

-(UILabel *)labelOrder{
    if(!_labelOrder){
        _labelOrder = [[UILabel alloc]init];
        _labelOrder.text =  @"订单号";
        _labelOrder.textColor = [UIColor grayColor];
        _labelOrder.font = [UIFont systemFontOfSize:14.f];
        _labelOrder.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelOrder;
}

-(UILabel *)labelOrderVal{
    if(!_labelOrderVal){
        _labelOrderVal = [[UILabel alloc]init];
        _labelOrderVal.font = [UIFont systemFontOfSize:15.f];
        _labelOrderVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelOrderVal;
}

@end
