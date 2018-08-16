//
//  LocationAreaCell.m
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import "LocationAreaCell.h"

@interface LocationAreaCell ()
@property(nonatomic,strong) UILabel* labelName;

@end


@implementation LocationAreaCell


- (void)awakeFromNib {
    [self layoutUI];
    [self layoutConstraints];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected){
        self.backgroundColor = theme_navigation_color;
        self.labelName.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
         self.labelName.textColor = theme_title_color;
    }
}
#pragma mark =====================================================  UI 布局
-(void)layoutUI{
    self.labelName = [[UILabel alloc]init];
    self.labelName.textAlignment = NSTextAlignmentCenter;
    self.labelName.font = [UIFont systemFontOfSize:14.f];
    self.labelName.textColor = theme_title_color;
    self.labelName.layer.borderColor = theme_line_color.CGColor;
    self.labelName.layer.borderWidth=1.0f;
    self.labelName.lineBreakMode = NSLineBreakByCharWrapping;
    self.labelName.numberOfLines =2;
    [self.contentView addSubview:self.labelName];
}

-(void)layoutConstraints{
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
}

-(void)setCity:(NSString *)city{
    self.labelName.text =city;
}

-(void)setEntity:(MArea *)entity{
    if(entity){
        _entity = entity;
        self.labelName.text =entity.areaName;
    }
}


@end
