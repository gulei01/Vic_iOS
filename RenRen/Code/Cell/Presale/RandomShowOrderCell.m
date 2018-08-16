//
//  RandomShowOrderCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/21.
//
//

#import "RandomShowOrderCell.h"

@interface RandomShowOrderCell ()

@property(nonatomic,strong) UIView* leftView;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UIView* middleView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelTime;
@property(nonatomic,strong) UIView* otherView;
@property(nonatomic,strong) UIImageView* iconLocation;
@property(nonatomic,strong) UILabel* labelLocation;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UIView* rightView;
@property(nonatomic,strong) UIImageView* arrow;

@end

@implementation RandomShowOrderCell

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
    [self addSubview:self.leftView];
    [self.leftView addSubview:self.icon];
    [self addSubview:self.middleView];
    [self.middleView addSubview:self.labelTitle];
    [self.middleView addSubview:self.labelTime];
    [self.middleView addSubview:self.otherView];
    [self.otherView addSubview:self.iconLocation];
    [self.otherView addSubview:self.labelLocation];
    [self.otherView addSubview:self.labelCreateDate];
    [self addSubview:self.rightView];
    [self.rightView addSubview:self.arrow];
    
    for (UIView* subView in self.subviews) {
        subView.translatesAutoresizingMaskIntoConstraints = NO;
        for (UIView* empty in subView.subviews) {
            empty.translatesAutoresizingMaskIntoConstraints = NO;
            for (UIView* subEmpty in empty.subviews) {
                subEmpty.translatesAutoresizingMaskIntoConstraints = NO;
            }
        }
    }
    
    [self loadConstraints:@[
                            @"H:|-defEdge-[leftView(==leftWidth)][middleView][rightView(==rightWidth)]-defEdge-|",
                            @"V:|-defEdge-[leftView]-defEdge-|", @"V:|-defEdge-[middleView]-defEdge-|", @"V:|-defEdge-[rightView]-defEdge-|",
                            @"H:[icon(==iconSize)]", @"V:|-topEdge-[icon(==iconSize)]",
                            @"H:|-defEdge-[labelTitle]-defEdge-|", @"H:|-defEdge-[labelTime]-defEdge-|",@"H:|-defEdge-[otherView]-defEdge-|",
                            @"V:|-5-[labelTitle(>=iconSize)][labelTime][otherView(==otherHeight)]-defEdge-|",
                            @"H:|-defEdge-[iconLocation(==locateSize)]-5-[labelLocation][labelCreateDate(==120)]-defEdge-|",
                            @"V:[iconLocation(==locateSize)]", @"V:|-defEdge-[labelLocation]-defEdge-|", @"V:|-defEdge-[labelCreateDate]-defEdge-|",
                            @"H:[arrow(==arrowWidth)]",@"V:[arrow(==arrowHeight)]"
                            ]
                  options:0
                  metrics:@{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10),
                             @"leftWidth":@(50), @"rightWidth":@(20), @"otherHeight":@(20),
                             @"iconSize":@(30),  @"arrowWidth":@(8), @"arrowHeight":@(14),
                             @"lineHeight":@(20), @"locateSize":@(12)
                             }
                    views:@{ @"leftView":self.leftView, @"middleView":self.middleView, @"rightView":self.rightView,
                             @"icon":self.icon, @"labelTitle":self.labelTitle, @"labelTime":self.labelTime, @"otherView":self.otherView,
                             @"iconLocation":self.iconLocation, @"labelLocation":self.labelLocation, @"labelCreateDate":self.labelCreateDate,
                             @"arrow":self.arrow
                             }
                superView:self];
    
    [self.leftView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    [self.rightView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rightView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    [self.rightView addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.rightView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.otherView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconLocation attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.otherView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
}


-(void)loadConstraints:(NSArray*)formats options:(NSLayoutFormatOptions)options metrics:(NSDictionary*)metrics views:(NSDictionary*)views superView:(UIView*)superView{
    for (NSString* format in formats) {
       // NSLog( @" %@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:options metrics:metrics views:views];
        [superView addConstraints:constraints];
    }
}


#pragma mark =====================================================  property package
-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        NSString* type = [item objectForKey: @"type"];
        NSString* str;
        if([ @"buy" isEqualToString:type]){
            str =  @"购买了";
        }else if([ @"buy" isEqualToString:type]){
            str =  @"下单取了";
        }else{
            str =  @"下单送了";
        }
        [self.icon sd_setImageWithURL:[NSURL URLWithString:[self.item objectForKey: @"outsrc"]] placeholderImage:[UIImage imageNamed: @"icon-random-buy"]];
        self.labelTitle.text =[NSString stringWithFormat: @"%@ %@ %@",[self.item objectForKey: @"uname"],str,[self.item objectForKey: @"title"]];
        self.labelTime.text = [NSString stringWithFormat: @"%@分钟送达",[self.item objectForKey: @"spendtime"]];
        self.labelCreateDate.text = [self.item objectForKey: @"add_time"];
        self.labelLocation.text = [self.item objectForKey: @"map_location"];
    }
}

-(UIView *)leftView{
    if(!_leftView){
        _leftView = [[UIView alloc]init];
    }
    return _leftView;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed: @"icon-random-buy"]];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 15.f;
    }
    return _icon;
}

-(UIView *)middleView{
    if(!_middleView){
        _middleView = [[UIView alloc]init];
    }
    return _middleView;
}

-(UILabel *)labelTitle{
    if(!_labelTime){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.numberOfLines = 2;
        _labelTitle.text =  @"赵飞购买了星巴克赵飞购买了星巴克赵飞购买了星巴克赵飞购买了星巴克";
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
    }
    return _labelTitle;
}

-(UILabel *)labelTime{
    if(!_labelTime){
        _labelTime = [[UILabel alloc]init];
        _labelTime.text =  @"16分钟送达";
        _labelTime.font = [UIFont systemFontOfSize:13.f];
        _labelTime.textColor = [UIColor grayColor];
    }
    return _labelTime;
}

-(UIView *)otherView{
    if(!_otherView){
        _otherView = [[UIView alloc]init];
    }
    return _otherView;
}
-(UIImageView *)iconLocation{
    if(!_iconLocation){
        _iconLocation = [[UIImageView alloc]init];
        [_iconLocation setImage:[UIImage imageNamed: @"locate"]];
    }
    return _iconLocation;
}

-(UILabel *)labelLocation{
    if(!_labelLocation){
        _labelLocation = [[UILabel alloc]init];
        _labelLocation.textColor = [UIColor grayColor];
        _labelLocation.font = [UIFont systemFontOfSize:10.f];
        _labelLocation.text =  @"中国建设银行大厦";
    }
    return _labelLocation;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]init];
        _labelCreateDate.textColor = [UIColor grayColor];
        _labelCreateDate.font = [UIFont systemFontOfSize:10.f];
        _labelCreateDate.text =  @"2016-09-09 08:00:00";
    }
    return _labelCreateDate;
}

-(UIView *)rightView{
    if(!_rightView){
        _rightView = [[UIView alloc]init];
    }
    return _rightView;
}

-(UIImageView *)arrow{
    if(!_arrow){
        _arrow = [[UIImageView alloc]init];
        [_arrow setImage:[UIImage imageNamed: @"icon-arrow-right"]];
    }
    return _arrow;
}

@end
