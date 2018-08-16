//
//  GoodsCell.m
//  XYRR
//
//  Created by kyjun on 15/10/27.
//
//

#import "GoodsCell.h"

@interface GoodsCell()

@property(nonatomic,strong) UIImageView* imgDefault;
@property(nonatomic,strong) UIImageView* imgRecommend;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelMarketPrice;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIButton* btnAdd;

@end

@implementation GoodsCell{
    CGFloat imgHeight;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = theme_default_color;
    CGFloat width = (SCREEN_WIDTH)/3;
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
    [self addSubview:self.labelTitle];
    
    self.labelMarketPrice = [[UILabel alloc]init];
    self.labelMarketPrice.textColor = theme_Fourm_color;
    self.labelMarketPrice.font = [UIFont boldSystemFontOfSize:14.f];
    self.labelMarketPrice.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.labelMarketPrice];
    
    self.labelPrice = [[UILabel alloc]init];
    self.labelPrice.textColor = [UIColor redColor];
    self.labelPrice.font = [UIFont boldSystemFontOfSize:14.f];
    self.labelPrice.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.labelPrice];
    
    self.imgRecommend = [[UIImageView alloc]init];
    [self.imgRecommend setImage:[UIImage imageNamed:@"icon-promotion"]];
    self.imgRecommend.hidden = YES;
    [self addSubview:self.imgRecommend];
    
    self.btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnAdd addTarget:self action:@selector(addToShopCarTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnAdd];
}

-(void)layoutConstraints{
    self.imgDefault.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints  = NO;
    self.labelMarketPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgRecommend.translatesAutoresizingMaskIntoConstraints  =NO;
    self.btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.imgDefault addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:imgHeight]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgDefault attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imgDefault attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarketPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarketPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.labelMarketPrice addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelMarketPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMarketPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-40.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelMarketPrice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-40.f]];
    
    [self.imgRecommend addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f ]];
    [self.imgRecommend addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imgRecommend attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f]];
    
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f ]];
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f]];
    
}


-(IBAction)addToShopCarTouch:(UIButton *)button{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addToShopCar:)]){
        [self.delegate addToShopCar:self.entity];
    }
}

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        self.labelPrice.text = [NSString stringWithFormat:@"￥%@",entity.price];
     
        NSString* marketPrice =[NSString stringWithFormat:@"￥%@",entity.maketPrice];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:marketPrice];
        [attr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, marketPrice.length)];
        [attr addAttribute:NSStrikethroughColorAttributeName value:theme_Fourm_color range:NSMakeRange(0, marketPrice.length)];
        
        self.labelMarketPrice.attributedText = attr;
        self.labelTitle.text = entity.goodsName;
        [self.imgDefault sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:kDefaultImage] options:SDWebImageRefreshCached completed:nil];
        CGFloat price = [entity.price floatValue];
        CGFloat maketPrice = [entity.maketPrice floatValue];
        self.imgRecommend.hidden = price>=maketPrice;
        /* begin zeng jun 2015-12-28 注释代码 这里先判断库存后判断的店铺状态 优先级不对
        if([entity.stock integerValue]>0){
            if([entity.storeStatus integerValue]==1){
                self.btnAdd.userInteractionEnabled = YES;
                [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
            }else{
                self.btnAdd.userInteractionEnabled = NO;
                [self.btnAdd setImage:[UIImage imageNamed:@"icon-off"] forState:UIControlStateNormal];
            }
                
        }else {
            self.btnAdd.userInteractionEnabled = NO;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-nothing"] forState:UIControlStateNormal];
        }
         begin zeng jun 2015-12-28*/
        
        //begin zeng jun 2015-12-28 先判断店铺状态再判断库存
        if([entity.storeStatus integerValue]==1){
            if([entity.stock integerValue]>0){
            self.btnAdd.userInteractionEnabled = YES;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
            }else {
                self.btnAdd.userInteractionEnabled = NO;
                [self.btnAdd setImage:[UIImage imageNamed:@"icon-nothing"] forState:UIControlStateNormal];
            }
        }else{
            self.btnAdd.userInteractionEnabled = NO;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-off"] forState:UIControlStateNormal];
        }
        //end zeng jun 2015-12-28
    }
}

@end
