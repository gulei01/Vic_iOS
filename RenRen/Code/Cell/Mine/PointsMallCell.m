//
//  PointsMallCell.m
//  KYRR
//
//  Created by kyjun on 16/5/9.
//
//

#import "PointsMallCell.h"

@interface PointsMallCell ()

@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIButton* btnPhoto;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* labelPoint;
@property(nonatomic,strong) UIButton* btnExchange;

@end

@implementation PointsMallCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.btnPhoto];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.icon];
    [self.bottomView addSubview:self.labelPoint];
    [self.bottomView addSubview:self.btnExchange];
}

-(void)layoutConstraints{
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnPhoto.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPoint.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnExchange.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat width = SCREEN_WIDTH/2-20;
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.btnPhoto addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPhoto attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.btnPhoto addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPhoto attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPhoto attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnPhoto attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnPhoto attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.icon addConstraint:[NSLayoutConstraint  constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelPoint addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelPoint addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.btnExchange addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExchange attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self.btnExchange addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExchange attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExchange attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnExchange attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    
}

#pragma mark =====================================================  property package

-(void)setEntity:(MPoint *)entity{
    if(entity){
        _entity = entity;
        self.labelTitle.text = entity.goodsName;
       // [self.btnPhoto sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
        [self.btnPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:entity.defaultImg] forState:UIControlStateNormal];
         [self.btnPhoto setImageEdgeInsets:UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f)];
        self.labelPoint.text = entity.points;
    }
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = [UIColor colorWithRed:56/255.f green:56/255.f blue:56/255.f alpha:1.0];
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        _labelTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _labelTitle;
}

-(UIButton *)btnPhoto{
    if(!_btnPhoto){
        _btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPhoto.userInteractionEnabled = NO;
    }
    return _btnPhoto;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}

-(UILabel *)labelPoint{
    if(!_labelPoint){
        _labelPoint = [[UILabel alloc]init];
        _labelPoint.textColor = theme_navigation_color;
        _labelPoint.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelPoint;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed: @"icon-point-point"]];
    }
    return _icon;
}

-(UIButton *)btnExchange{
    if(!_btnExchange){
        _btnExchange = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnExchange.backgroundColor = theme_navigation_color;
        _btnExchange.layer.masksToBounds = YES;
        _btnExchange.layer.cornerRadius = 5.f;
        [_btnExchange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnExchange setTitle: @"立即兑换" forState:UIControlStateNormal];
        _btnExchange.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnExchange.userInteractionEnabled = NO;
    }
    return _btnExchange;
}

@end
