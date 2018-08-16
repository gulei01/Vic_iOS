//
//  RandomShowOrderHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/21.
//
//

#import "RandomShowOrderHeader.h"

@interface RandomShowOrderHeader ()
@property(nonatomic,strong) UILabel* labelCount;
@property(nonatomic,strong) UILabel* labelGo;
@property(nonatomic,strong) UIImageView* arrow;
@property(nonatomic,strong) UIView* bottomView;
@end

@implementation RandomShowOrderHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.btnHeader];
        [self.btnHeader addSubview:self.labelCount];
        [self.btnHeader addSubview:self.labelGo];
        [self.btnHeader addSubview:self.arrow];
        [self addSubview:self.bottomView];
        
        NSArray* formats = @[
                             @"H:|-defEdge-[btnHeader]-defEdge-|",@"H:|-defEdge-[bottomView]-defEdge-|",
                             @"V:|-defEdge-[btnHeader][bottomView(==bottomHeight)]-defEdge-|",
                             @"H:|-leftEdge-[labelCount][labelGo(==goWidth)][arrow(==arrowWidth)]-leftEdge-|",
                             @"V:|-defEdge-[labelCount]-defEdge-|", @"V:|-defEdge-[labelGo]-defEdge-|", @"V:[arrow(==arrowHeight)]"
                             ];
        NSDictionary* metrics = @{
                                  @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"bottomHeight":@(10), @"goWidth":@(50),
                                   @"arrowHeight":@(14), @"arrowWidth":@(8)
                                  };
        NSDictionary* views = @{
                                @"btnHeader":self.btnHeader, @"bottomView":self.bottomView, @"labelCount":self.labelCount, @"labelGo":self.labelGo, @"arrow":self.arrow
                                 };
        
        for (NSString* format in formats) {
            //NSLog( @"%@ %@",[self class],format);
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }
        
        [self.btnHeader addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnHeader attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    }
    return self;
}

-(void)loadUsers:(NSString *)users{
    NSString* str = [NSString stringWithFormat: @"已有 %@ 人使用了万能跑腿",users];
    NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:users]];
    self.labelCount.attributedText = attributeStr;
}

#pragma mark =====================================================  property package
-(UIButton *)btnHeader{
    if(!_btnHeader){
        _btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnHeader.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnHeader;
}

-(UILabel *)labelCount{
    if(!_labelCount){
        _labelCount = [[UILabel alloc]init];
        _labelCount.font = [UIFont systemFontOfSize:14.f];
        _labelCount.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCount;
}

-(UILabel *)labelGo{
    if(!_labelGo){
        _labelGo = [[UILabel alloc]init];
        _labelGo.textColor = [UIColor redColor];
        _labelGo.text =  @"立即下单";
        _labelGo.font = [UIFont systemFontOfSize:12.f];
        _labelGo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelGo;
}

-(UIImageView *)arrow{
    if(!_arrow){
        _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"icon-arrow-right"]];
        _arrow.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _arrow;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = theme_table_bg_color;
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

@end
