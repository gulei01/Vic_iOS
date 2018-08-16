//
//  MapLocationCurrentCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/16.
//
//

#import "MapLocationCurrentCell.h"

@interface MapLocationCurrentCell ()

@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation MapLocationCurrentCell{
    NSInteger angle;
    NSInteger count;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        angle = 10;
        count = 2;
        [self layoutUI];
        [self layoutConstraints];         
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)layoutUI{
    [self addSubview:self.icon];
    [self addSubview:self.labelTitle];
}

-(void)layoutConstraints{
    
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3];
    constraint.priority = 751;
    [self.labelTitle addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*3/4];
    constraint.priority = 751;
    [self.labelTitle addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f];
    [self addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f];
    [self addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f];
    [self.icon addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f];
    [self.icon addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f];
    [self addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5.f];
    [self addConstraint:constraint];
    
}

-(void)loadDataTitle:(NSString *)title{
    self.labelTitle.text = title;
}


-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed: @"icon-locationing"]];
        _icon.translatesAutoresizingMaskIntoConstraints =NO;
    }
    return _icon;
}

-(UILabel *)labelTitle{
    if (!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
       _labelTitle.textColor = [UIColor colorWithRed:50/255.f green:50/255.f blue:50/255.f alpha:1.0];
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

@end
