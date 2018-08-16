//
//  MapLocationHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/12.
//
//

#import "MapLocationHeader.h"


@interface MapLocationHeader ()

@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation MapLocationHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.icon];
    [self addSubview:self.labelTitle];
}

-(void)layoutConstraints{
    NSArray* formats = @[ @"H:|-10-[icon(==iconWidth)]", @"V:|-10-[icon(==iconHeight)]",
                          @"H:[icon]-10-[labelTitle]-10-|", @"V:|-0-[labelTitle]-0-|"
                          ];
    NSDictionary* metrics = @{ @"iconWidth":@(20.f), @"iconHeight":@(20.f)};
    NSDictionary* views = @{ @"icon":self.icon, @"labelTitle":self.labelTitle};
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
}

-(void)loadDataWithTitle:(NSString *)title imageName:(NSString *)imageName{
    [self.icon setImage:[UIImage imageNamed:imageName]];
    self.labelTitle.text = title;
}

#pragma mark =====================================================  property package
-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        _icon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _icon;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = theme_Fourm_color;
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

@end
