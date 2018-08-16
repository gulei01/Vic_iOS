//
//  RandomOrderStatusCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/21.
//
//

#import "RandomOrderStatusCell.h"

@interface RandomOrderStatusCell ()

@property(nonatomic,strong) UIView* leftView;
@property(nonatomic,strong) UIImageView* topLine;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UIImageView* bottomLine;
@property(nonatomic,strong) UIImageView* rightView;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UILabel* labelTime;
@property(nonatomic,strong) UILabel* labelMark;

@end

@implementation RandomOrderStatusCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.leftView];
        [self.leftView addSubview:self.topLine];
        [self.leftView addSubview:self.icon];
        [self.leftView addSubview:self.bottomLine];
        [self addSubview:self.rightView];
        [self.rightView addSubview:self.labelStatus];
        [self.rightView addSubview:self.labelTime];
        [self.rightView addSubview:self.labelMark];
        
        NSArray* formats = @[
                             @"H:|-defEdge-[leftView(==leftWidth)][rightView]-leftEdge-|",
                             @"V:|-defEdge-[leftView]-defEdge-|", @"V:|-topEdge-[rightView]-topEdge-|",
                             @"H:[topLine(==lineWidth)]",@"H:[bottomLine(==lineWidth)]", @"H:[icon(==iconSize)]",
                             @"V:|-defEdge-[topLine(==30)]-2-[icon(==iconSize)]-2-[bottomLine]-defEdge-|",
                             @"H:|-leftEdge-[labelStatus][labelTime]-leftEdge-|", @"H:|-leftEdge-[labelMark]-leftEdge-|",
                             @"V:|-defEdge-[labelStatus][labelMark(labelStatus)]-defEdge-|", @"V:|-defEdge-[labelTime(labelStatus)]"
                             ];
        NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"leftWidth":@(40),
                                   @"iconSize":@(20), @"lineWidth":@(1)
                                   };
        NSDictionary* views = @{ @"leftView":self.leftView, @"rightView":self.rightView,
                                 @"topLine":self.topLine, @"icon":self.icon, @"bottomLine":self.bottomLine, @"topHeight":@(10),
                                 @"labelStatus":self.labelStatus, @"labelTime":self.labelTime, @"labelMark":self.labelMark
                                 };
        
        for (NSString* format in formats) {
            //NSLog( @" %@ %@ ",[self class],format);
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }
        
        [self.leftView addConstraint:[NSLayoutConstraint constraintWithItem:self.topLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
        [self.leftView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
        [self.leftView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomLine attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
        
    }
    return self;
}


#pragma mark =====================================================  property package

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        self.labelTime.text = [item objectForKey: @"add_time"];
        self.labelStatus.text = [item objectForKey: @"mark"];
        NSInteger status = [[item objectForKey: @"order_status"]integerValue];
        if(self.tag==0){
            [self.icon setImage:[UIImage imageNamed: @"icon-pepole-enter"]];
            self.topLine.hidden = YES;
        }else if (self.tag == 55){
            self.bottomLine.hidden = YES;
        }else{
            self.topLine.hidden = NO;
            self.bottomLine.hidden = NO;
        }
        
        switch (status) {
            case -1://订单已取消
            {
                
            }
                break;
            case 0: //订单提交成功
            {
                
            }
                break;
            case 1: //待支付
            {
                
            }
                break;
            case 2: //支付成功
            {
                
            }
                break;
            case 3: //退款中
            {
                
            }
                break;
            case 4: //已退款
            {
                
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
                
            }
                break;
                
            default:
                break;
        }
        self.labelMark.text = [item objectForKey: @"note"];
    }
}


-(UIView *)leftView{
    if(!_leftView){
        _leftView = [[UIView alloc]init];
        _leftView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _leftView;
}


-(UIImageView *)topLine{
    if(!_topLine){
        _topLine = [[UIImageView alloc]init];
        [_topLine setImage:[UIImage imageNamed: @"line-vertical"]];
        _topLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topLine;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed: @"icon-pepole-default"]];
        _icon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _icon;
}

-(UIImageView *)bottomLine{
    if(!_bottomLine){
        _bottomLine = [[UIImageView alloc]init];
        [_bottomLine setImage:[UIImage imageNamed: @"line-vertical"]];
        _bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomLine;
}
-(UIImageView *)rightView{
    if(!_rightView){
        _rightView = [[UIImageView alloc]init];
        [_rightView setImage:[UIImage imageNamed:@"icon-order-background"]];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightView;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
        _labelStatus.font = [UIFont systemFontOfSize:15.f];
        _labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelStatus;
}

-(UILabel *)labelTime{
    if(!_labelTime){
        _labelTime = [[UILabel alloc]init];
        _labelTime.font = [UIFont systemFontOfSize:12.f];
        _labelTime.textColor = [UIColor grayColor];
        _labelTime.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTime;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark = [[UILabel alloc]init];
        _labelMark.font = [UIFont systemFontOfSize:12.f];
        _labelMark.textColor = [UIColor grayColor];
        _labelMark.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMark;
}




@end
