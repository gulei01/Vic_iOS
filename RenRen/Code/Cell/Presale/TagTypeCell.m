//
//  TagTypeCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/10.
//
//

#import "TagTypeCell.h"

@interface TagTypeCell ()


@end

@implementation TagTypeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self layoutUI];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.labelTag];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTag attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTag attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTag attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTag attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  property package
-(void)setTagType:(NSString *)tagType{
    if(tagType){
        _tagType = tagType;
        self.labelTag.text = tagType;
    }
}
-(UILabel *)labelTag{
    if(!_labelTag){
        _labelTag = [[UILabel alloc]init];
        _labelTag.layer.masksToBounds = YES;
        _labelTag.layer.borderColor = [UIColor colorWithRed:229/255.f green:229/255.f blue:229/255.f alpha:1.0].CGColor;
        _labelTag.layer.borderWidth = 1.f;
        _labelTag.layer.cornerRadius = 15.f;
        _labelTag.font = [UIFont systemFontOfSize:14.f];
        _labelTag.textAlignment = NSTextAlignmentCenter;
        _labelTag.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTag;
}

@end
