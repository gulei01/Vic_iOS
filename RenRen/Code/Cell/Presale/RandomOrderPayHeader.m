//
//  RandomOrderPayHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/14.
//
//

#import "RandomOrderPayHeader.h"

@interface RandomOrderPayHeader ()

@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIView* middleView;
@property(nonatomic,strong) UILabel* labelGoods;
@property(nonatomic,strong) UILabel* labelMoney;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelMark;

@end

@implementation RandomOrderPayHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.topView];
        [self addSubview:self.middleView];
        [self.middleView addSubview:self.labelGoods];
        [self.middleView addSubview:self.labelMoney];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.labelMark];
        
        NSArray* formats = @[@"H:|-defEdge-[topView]-defEdge-|",@"H:|-defEdge-[middleView]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|", @"V:|-defEdge-[topView(==0)][middleView][bottomView(==bottomHeight)]-defEdge-|",
                             @"H:|-leftEdge-[labelGoods][labelMoney]-leftEdge-|", @"V:|-defEdge-[labelGoods]-defEdge-|", @"V:|-defEdge-[labelMoney]-defEdge-|",
                             @"H:|-leftEdge-[labelMark]-leftEdge-|", @"V:|-defEdge-[labelMark]-defEdge-|"];
        NSDictionary* metrics = @{ @"defEdge":@(0), @"topEdge":@(10), @"leftEdge":@(10), @"middleHeight":@(40), @"bottomHeight":@(40)};
        NSDictionary* views = @{ @"topView":self.topView, @"middleView":self.middleView, @"bottomView":self.bottomView, @"labelGoods":self.labelGoods, @"labelMoney":self.labelMoney, @"labelMark":self.labelMark};
        
        for (NSString* format in formats) {
            //NSLog( @"%@ %@",[self class],format);
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }
        
    }
    return self;
}

-(void)loadDataWithName:(NSString *)name money:(CGFloat)money{
    self.labelGoods.text = name;
    self.labelMoney.text = [NSString stringWithFormat: @"￥%.2f",money];
}

#pragma mark =====================================================  property package
-(UIView *)topView{
    if(!_topView){
        _topView = [[UILabel alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

-(UIView *)middleView{
    if(!_middleView){
        _middleView = [[UIView alloc]init];
        _middleView.backgroundColor = [UIColor whiteColor];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        border.backgroundColor = theme_line_color.CGColor;
        [_middleView.layer addSublayer:border];
        _middleView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _middleView;
}

-(UILabel *)labelGoods{
    if(!_labelGoods){
        _labelGoods = [[UILabel alloc]init];
        _labelGoods.font = [UIFont systemFontOfSize:14.f];
        _labelGoods.numberOfLines = 0;
        _labelGoods.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelGoods;
}

-(UILabel *)labelMoney{
    if(!_labelMoney){
        _labelMoney = [[UILabel alloc]init];
        _labelMoney.font = [UIFont systemFontOfSize:14.f];
        _labelMoney.textAlignment = NSTextAlignmentRight;
        _labelMoney.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMoney;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.text =  @"选择支付方式";
        _labelMark.textColor = [UIColor grayColor];
        _labelMark.font = [UIFont systemFontOfSize:14.f];
        _labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMark;
}

@end
