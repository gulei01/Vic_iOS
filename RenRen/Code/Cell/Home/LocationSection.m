//
//  LocationSection.m
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import "LocationSection.h"

@interface LocationSection ()

@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation LocationSection

- (void)awakeFromNib {
    // Initialization code
    
    [self layoutUI];
    [self layoutConstraints];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1.0];
}

#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    self.labelTitle = [[UILabel alloc]init];
    self.labelTitle.textColor = theme_title_color;
    self.labelTitle.textAlignment = NSTextAlignmentLeft;
    self.labelTitle.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:self.labelTitle];
}
-(void)layoutConstraints{
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-30.f]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:40.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
}

-(void)setSectTitle:(NSString *)title{
    self.labelTitle.text = title;
}

@end
