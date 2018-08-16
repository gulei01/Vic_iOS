//
//  BuyNowSection.m
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import "BuyNowSection.h"

@interface BuyNowSection ()

@property(nonatomic,strong) UIButton* btnIcon;
@property(nonatomic,strong) UILabel* labelStoreName;

@end

@implementation BuyNowSection

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
         self.contentView.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}


-(void)layoutUI{
    [self addSubview:self.btnIcon];
    [self addSubview:self.labelStoreName];
}

-(void)layoutConstraints{
    [self.btnIcon setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelStoreName setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnIcon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnIcon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStoreName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStoreName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStoreName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnIcon attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStoreName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
}

-(void)setEntity:(MStore *)entity{
    if(entity){
        _entity = entity;
        [self.labelStoreName setText:entity.storeName];
    }
}

#pragma mark =====================================================  property package
-(UIButton *)btnIcon{
    if(!_btnIcon){
        _btnIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnIcon setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
    }
    return _btnIcon;
}

-(UILabel *)labelStoreName{
    if(!_labelStoreName ){
        _labelStoreName = [[UILabel alloc]init];
        [_labelStoreName setTextColor:theme_Fourm_color];
        [_labelStoreName setFont:[UIFont systemFontOfSize:14.f]];
        [_labelStoreName setText:@"新一佳-东门店"];
    }
    return _labelStoreName;
}


@end
