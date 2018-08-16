//
//  RandomVouchersCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/14.
//
//

#import "RandomVouchersCell.h"

@interface RandomVouchersCell ()

@property(nonatomic,strong) UIButton* btnLeft;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UILabel* labelMoney;
@property(nonatomic,strong) UILabel* labelDate;
@end

@implementation RandomVouchersCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        border.backgroundColor = theme_line_color.CGColor;
        [self.layer addSublayer:border];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.btnLeft];
    [self addSubview:self.labelName];
    [self addSubview:self.labelMoney];
    [self addSubview:self.labelDate];
}

-(void)layoutConstraints{
    NSArray* formats = @[@"H:|-defEdge-[btnLeft(==50)]-leftEdge-[labelName]-defEdge-|", @"V:|-topEdge-[btnLeft]-defEdge-|", @"V:|-topEdge-[labelName(==nameHeight)][labelMoney][labelDate(==nameHeight)]-defEdge-|",
                         @"H:[labelMoney]-leftEdge-|",@"H:[btnLeft][labelDate]-defEdge-|", @"H:[btnLeft][labelDate]-defEdge-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"topEdge":@(10), @"leftEdge":@(10), @"nameHeight":@(25), @"iconSize":@(25)};
    NSDictionary* views = @{ @"btnLeft":self.btnLeft, @"labelMoney":self.labelMoney, @"labelName":self.labelName, @"labelDate":self.labelDate};
    
    for (NSString* format in formats) {
        //NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
}

#pragma mark =====================================================  property package
-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        [self.btnLeft setTitle:[[item objectForKey: @"type"] integerValue]==1?@"立减":@"满减" forState:UIControlStateNormal];
        NSString*  str = [NSString stringWithFormat:@"%@ 使用于 全场",[item objectForKey: @"type_name"]];
        
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:@"全场"]];
        self.labelName.attributedText = attributeStr;
        self.labelMoney.text = [NSString stringWithFormat:@"￥%.2f",[[item objectForKey: @"type_money"] floatValue]];
        self.labelDate.text = [NSString stringWithFormat:@"有效期: %@ 至 %@",[WMHelper timeStampConvertToDateString:[item objectForKey: @"use_start_date"]],[WMHelper timeStampConvertToDateString:[item objectForKey: @"use_end_date"]]];

    }
}

-(UIButton *)btnLeft{
    if(!_btnLeft){
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLeft setBackgroundImage:[UIImage imageNamed:@"icon-red-bg"] forState:UIControlStateNormal];
        [_btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLeft.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnLeft;
}

-(UILabel *)labelName{
    if(!_labelName){
        _labelName = [[UILabel alloc]init];
        _labelName.font = [UIFont systemFontOfSize:14.f];
        _labelName.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _labelName;
}

-(UILabel *)labelMoney{
    if(!_labelMoney){
        _labelMoney = [[UILabel alloc]init];
        _labelMoney.font = [UIFont systemFontOfSize:25.f];
        _labelMoney.textColor = [UIColor redColor];
        _labelMoney.textAlignment = NSTextAlignmentRight;
        _labelMoney.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMoney;
}

-(UILabel *)labelDate{
    if(!_labelDate){
        _labelDate = [[UILabel alloc]init];
        _labelDate.font = [UIFont systemFontOfSize:14.f];
        _labelDate.textColor =theme_Fourm_color;
        _labelDate.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDate;
}

@end
