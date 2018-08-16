//
//  RandomDeliverHelp.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/22.
//
//

#import "RandomDeliverHelp.h"


@interface RandomDeliverHelp ()
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIButton* btnClose;
@property(nonatomic,strong) UIView* middleView;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UILabel* labelDistance;
@property(nonatomic,strong) UILabel* labelDistanceVal;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelRule;
@property(nonatomic,strong) UILabel* labelMark;



@end

@implementation RandomDeliverHelp

//浮层中配送说明
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        [self addSubview:self.topView];
        [self.topView addSubview:self.labelTitle];
        [self.topView addSubview:self.btnClose];
        [self addSubview:self.middleView];
        [self.middleView addSubview:self.labelPrice];
        [self.middleView addSubview:self.labelDistance];
        [self.middleView addSubview:self.labelDistanceVal];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.labelRule];
        [self.bottomView addSubview:self.labelMark];
        
        NSArray* formats = @[
                             @"H:|-defEdge-[topView]-defEdge-|",@"H:|-defEdge-[middleView]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|",
                             @"V:|-topEdge-[topView(==topHeight)][middleView]-topEdge-[bottomView(==100)]-defEdge-|",
                             @"H:|-leftEdge-[labelTitle][btnClose(==iconSize)]-leftEdge-|",
                             @"V:|-defEdge-[labelTitle]-defEdge-|", @"V:|-defEdge-[btnClose]-defEdge-|",
                             @"H:|-leftEdge-[labelPrice]-defEdge-|",@"H:|-leftEdge-[labelDistance][labelDistanceVal]-leftEdge-|",
                             @"V:|-defEdge-[labelPrice][labelDistance(==35)]-defEdge-|",@"V:|-defEdge-[labelPrice][labelDistanceVal(==35)]-defEdge-|",
                             @"H:|-leftEdge-[labelRule]-defEdge-|",@"H:|-leftEdge-[labelMark]-defEdge-|",
                             @"V:|-topEdge-[labelRule(==20)][labelMark]-defEdge-|"
                             ];
        NSDictionary* metrics = @{
                                  @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10),  @"topHeight":@(40), @"iconSize":@(30),
                                  @"titleHeight":@(40)
                                  };
        NSDictionary* views = @{
                                @"topView":self.topView, @"middleView":self.middleView, @"bottomView":self.bottomView,
                                @"labelTitle":self.labelTitle, @"btnClose":self.btnClose,
                                @"labelPrice":self.labelPrice, @"labelDistance":self.labelDistance, @"labelDistanceVal":self.labelDistanceVal,
                                @"labelRule":self.labelRule, @"labelMark":self.labelMark
                                };
        
        for (NSString* format in formats) {
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }
        
    }
    return self;
}

#pragma mark =====================================================  SEL
-(void)btnClose:(UIButton*)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(closeDeliveryHelp:)]){
        [self.delegate closeDeliveryHelp:sender];
    }
}

#pragma mark =====================================================  property package
-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        NSString* price = [item objectForKey: @"price"];
        NSString* str =  [NSString stringWithFormat: @"%@ 元",price];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:56]} range:[str rangeOfString:price]];
        self.labelPrice.attributedText = attributeStr;
        self.labelDistance.text =[NSString stringWithFormat: @"%@ 公里",[item objectForKey: @"distance"]];
        self.labelDistanceVal.text = str;
    }
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.text =  @"配送说明";
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.font = [UIFont boldSystemFontOfSize:17.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UIButton *)btnClose{
    if(!_btnClose){
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnClose setTitle: @"x" forState:UIControlStateNormal];
        _btnClose.titleLabel.font = [UIFont systemFontOfSize:44];
        [_btnClose addTarget:self action:@selector(btnClose:) forControlEvents:UIControlEventTouchUpInside];
        _btnClose.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnClose;
}

-(UIView *)middleView{
    if(!_middleView){
        _middleView = [[UILabel alloc]init];
        _middleView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _middleView;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

-(UILabel *)labelDistance{
    if(!_labelDistance){
        _labelDistance = [[UILabel alloc]init];
        _labelDistance.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDistance;
}

-(UILabel *)labelDistanceVal{
    if(!_labelDistanceVal){
        _labelDistanceVal = [[UILabel alloc]init];
        _labelDistanceVal.textAlignment = NSTextAlignmentRight;
        _labelDistanceVal.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDistanceVal;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UILabel alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_bottomView.layer addSublayer:border];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UILabel *)labelRule{
    if(!_labelRule){
        _labelRule = [[UILabel alloc]init];
        NSUserDefaults* defConfi = [NSUserDefaults standardUserDefaults];
        NSDictionary* empty = [defConfi objectForKey: kRandomBuyFeeConfig];
        _labelRule.text =  [empty objectForKey: @"title"];
        _labelRule.font = [UIFont boldSystemFontOfSize:15.f];
        _labelRule.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelRule;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.numberOfLines = 0;
        _labelMark.font = [UIFont systemFontOfSize:12.f];
        _labelMark.textColor = [UIColor grayColor];
        NSUserDefaults* defConfi = [NSUserDefaults standardUserDefaults];
        NSDictionary* empty = [defConfi objectForKey: kRandomBuyFeeConfig];
        NSString* str = [empty objectForKey: @"description"];
        NSArray* emptyArray =  [str componentsSeparatedByString: @"|"];
        NSString* newStr = [NSString stringWithFormat: @"%@\n%@",[emptyArray firstObject],[emptyArray lastObject]];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:newStr];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [newStr length])];
        _labelMark.attributedText = attributeStr;
        _labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMark;
}








@end
