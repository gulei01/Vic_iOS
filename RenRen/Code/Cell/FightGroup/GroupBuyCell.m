//
//  GroupBuyCell.m
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import "GroupBuyCell.h"

@interface GroupBuyCell ()

@property(nonatomic,strong) UIImageView* avatar;
@property(nonatomic,strong) UILabel* labelMark;

@property(nonatomic,strong) MCustomer* customer;
@property(nonatomic,strong) MTuan* tuan;

@end

@implementation GroupBuyCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}


#pragma mark =====================================================  user inteface layout
-(void)layoutUI{
    [self addSubview:self.avatar];
    [self addSubview:self.labelMark];
}

-(void)layoutConstraints{
    self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelMark.translatesAutoresizingMaskIntoConstraints =NO;
    
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
    [self.labelMark addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelMark addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.avatar attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMark attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
}

#pragma mark =====================================================  property package
-(void)setEntity:(MCustomer *)entity{
    if(entity){
        _entity = entity;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:entity.avatar] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
        if([entity.leader integerValue] == 1){
            self.labelMark.text = @"团长";
            self.labelMark.hidden = NO;
        }else{
            self.labelMark.hidden = YES;
        }
    }
}

-(UIImageView *)avatar{
    if(!_avatar){
        _avatar = [[UIImageView alloc]init];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 45/2.f;
    }
    return _avatar;
}

-(UILabel *)labelMark{
    if(!_labelMark){
        _labelMark  = [[UILabel alloc]init];
        _labelMark.backgroundColor = [UIColor redColor];
        _labelMark.textColor = [UIColor whiteColor];
        _labelMark.font = [UIFont systemFontOfSize:10.f];
        _labelMark.layer.masksToBounds = YES;
        _labelMark.layer.cornerRadius = 2.f;
    }
    return _labelMark;
}

@end
