//
//  PayWayCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/14.
//
//

#import "PayWayCell.h"

@interface PayWayCell ()

@property(nonatomic,strong) UIImageView* iconLogo;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelSubTitle;
@property(nonatomic,strong) UIImageView* icon;

@end

@implementation PayWayCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    [self addSubview:self.iconLogo];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelSubTitle];
    [self addSubview:self.icon];
    
    NSArray* formats = @[ @"H:|-leftEdge-[iconLogo(==logoSize)]-itemSpace-[labelTitle]-itemSpace-[icon(==iconSize)]-leftEdge-|", @"V:|-topEdge-[iconLogo(logoSize)]-topEdge-|",
                          @"V:|-topEdge-[labelTitle][labelSubTitle(labelTitle)]-topEdge-|", @"V:|-15-[icon(iconSize)]-15-|",@"H:[iconLogo]-itemSpace-[labelSubTitle]-itemSpace-[icon]"
                          ];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"itemSpace":@(10), @"logoSize":@(30), @"iconSize":@(20)};
    NSDictionary* views = @{ @"iconLogo":self.iconLogo, @"labelTitle":self.labelTitle, @"labelSubTitle":self.labelSubTitle, @"icon":self.icon};
    
    for (NSString* format in formats) {
        // NSLog( @"%@ %@",[self class],format);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
}

#pragma mark =====================================================  property package

-(void)setItem:(MPayWay *)item{
    if(item){
        _item = item;
        [self.iconLogo setImage:[UIImage imageNamed:item.icon]];
        self.labelTitle.text = item.title;
        self.labelSubTitle.text = item.subTitle;
        if(item.selected){
            [self.icon setImage:[UIImage imageNamed: @"icon-agreement-enter"]];
        }else{
            [self.icon setImage:[UIImage imageNamed: @"icon-agreement-default"]];
        }
        
    }
}

-(UIImageView *)iconLogo{
    if(!_iconLogo){
        _iconLogo = [[UIImageView alloc]init];
        _iconLogo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconLogo;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UILabel *)labelSubTitle{
    if(!_labelSubTitle){
        _labelSubTitle = [[UILabel alloc]init];
        _labelSubTitle.font = [UIFont systemFontOfSize:12.f];
        _labelSubTitle.textColor = [UIColor grayColor];
        _labelSubTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelSubTitle;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        _icon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _icon;
}

@end

@implementation MPayWay

-(instancetype)initWithDictionary:(NSDictionary *)keyValues{
    self = [super init];
    if(self){
        _icon = [keyValues objectForKey: @"icon"],
        _title = [keyValues objectForKey: @"title"];
        _subTitle = [keyValues objectForKey: @"subTitle"];
        _payType = [keyValues objectForKey: @"payType"];
        _selected = [[keyValues objectForKey: @"selected"] boolValue];
    }
    return self;
}
@end
