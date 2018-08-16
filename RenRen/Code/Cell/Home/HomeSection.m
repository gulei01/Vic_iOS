//
//  HomeSection.m
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import "HomeSection.h"

@interface HomeSection()

@property(nonatomic,strong) UIImageView* imgArrow;

@end

@implementation HomeSection

- (void)awakeFromNib {
    // Initialization code
    
    [self layoutUI];
    [self layoutConstraints];
}
-(instancetype)init{
    self  = [super init];
    if(self){
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}
-(void)layoutUI{
    self.backgroundColor = theme_default_color;
    self.btnSection = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnSection.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnSection.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-35);
    self.btnSection.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.btnSection setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
    [self.btnSection addTarget:self action:@selector(btnSectionTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSection setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    self.btnSection.titleLabel.font = [UIFont systemFontOfSize:14.f];
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,1.0f);
    border.backgroundColor = theme_line_color.CGColor;
    [self.btnSection.layer addSublayer:border];

    [self addSubview:self.btnSection];
    
    self.imgArrow = [[UIImageView alloc]init];
    [self.imgArrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    [self.btnSection addSubview:self.imgArrow];
}
-(void)layoutConstraints{
    self.btnSection .translatesAutoresizingMaskIntoConstraints = NO;
    self.imgArrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnSection attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.btnSection addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnSection attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnSection addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnSection attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
}

- (IBAction)btnSectionTouch:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(sectionTouch:)])
        [self.delegate sectionTouch:sender];
}

@end
