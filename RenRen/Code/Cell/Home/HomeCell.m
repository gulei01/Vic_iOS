//
//  HomeCell.m
//  XYRR
//
//  Created by kyjun on 15/10/22.
//
//

#import "HomeCell.h"


@interface HomeCell()

@property(nonatomic,strong) UIImageView* imgDefault;
@property(nonatomic,strong) UIImageView* imgRecommend;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;

@end

@implementation HomeCell{
    CGFloat imgHeight;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = theme_default_color;
    CGFloat width = (SCREEN_WIDTH-4)/3;
     imgHeight = width - 20;
    [self layoutUI];
    [self layoutConstraints];
}


-(void)layoutUI{
    self.imgDefault = [[UIImageView alloc]init];
    [self addSubview:self.imgDefault];
    
    self.labelTitle = [[UILabel alloc]init];
    self.labelTitle.numberOfLines = 2;
    self.labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    self.labelTitle.font = [UIFont systemFontOfSize:14.f];
    self.labelTitle.textAlignment = NSTextAlignmentLeft;
    self.labelTitle.textColor = theme_title_color;
    [self addSubview:self.labelTitle];
    
    self.labelPrice = [[UILabel alloc]init];
    self.labelPrice.textColor = [UIColor redColor];
    self.labelPrice.font = [UIFont boldSystemFontOfSize:14.f];
    self.labelPrice.textAlignment = NSTextAlignmentLeft;
    self.labelPrice.textColor = theme_price_color;
    [self addSubview:self.labelPrice];
    
    self.imgRecommend = [[UIImageView alloc]init];
    [self.imgRecommend setImage:[UIImage imageNamed:@"icon-promotion"]];
    self.imgRecommend.hidden = YES;
    [self addSubview:self.imgRecommend];
}

-(void)layoutConstraints{
    self.imgDefault.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints  = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgRecommend.translatesAutoresizingMaskIntoConstraints  =NO;
    
    [self.imgDefault addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:imgHeight]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgDefault attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    
    [self.imgRecommend addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f ]];
    [self.imgRecommend addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f]];
    
}

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        self.labelPrice.text = [NSString stringWithFormat:@"￥%@",entity.price];
        self.labelTitle.text = entity.goodsName;
        [self.imgDefault sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:kDefaultImage]];
        CGFloat price = [entity.price floatValue];
        CGFloat maketPrice = [entity.maketPrice floatValue];
        self.imgRecommend.hidden = price>=maketPrice;
        
    }
}

@end
