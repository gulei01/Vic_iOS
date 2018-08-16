//
//  MyTuanInfoHeader.m
//  KYRR
//
//  Created by kuyuZJ on 16/6/29.
//
//

#import "MyTuanInfoHeader.h"

@interface MyTuanInfoHeader ()
@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UILabel* labelLine;
@end

@implementation MyTuanInfoHeader

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
    [self addSubview:self.photo];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelPrice];
    [self addSubview:self.icon];
    [self addSubview:self.labelLine];
}

-(void)layoutConstraints{
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelLine.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];

    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
 
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelLine addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.f]];
      [self.labelLine addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLine attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}

#pragma mark =====================================================  property package
-(void)setEntity:(MFightGroupInfo *)entity{
    if(entity){
        _entity = entity;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:entity.fightGroup.thumbnails] placeholderImage:[UIImage imageNamed:@"Icon-60"] options:SDWebImageRefreshCached];
        self.labelTitle.text = entity.fightGroup.goodsName;
        
        NSString* count = [NSString stringWithFormat:@"%@人团:",entity.tuanItem.successNum];
        NSString* money = [NSString stringWithFormat:@"￥%@/件",entity.fightGroup.tuanPrice];
        NSString* str = [NSString stringWithFormat:@"%@%@",count,money];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:money]];
         [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[str rangeOfString:count]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:[str rangeOfString:entity.fightGroup.tuanPrice]];
        self.labelPrice.attributedText = attributeStr;
        self.labelPrice.textAlignment = NSTextAlignmentCenter;
        
        if([entity.tuanItem.tuanStatus integerValue] == 1){
            [self.icon setImage:[UIImage imageNamed: @"icon-group-success"]];
        }else if ([entity.tuanItem.tuanStatus integerValue] == 0){
            [self.icon setImage:[UIImage imageNamed: @"icon-group-waiting"]];
        }else{
            [self.icon setImage:[UIImage imageNamed: @"icon-group-fail"]];
        }

    }
}

-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
        [_photo setImage:[UIImage imageNamed:@"Icon-60"]];
        _photo.layer.borderColor = [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1.0].CGColor;
        _photo.layer.borderWidth = 1.f;
    }
    return _photo;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        [_labelTitle setTextColor:[UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.0]];
        _labelTitle.numberOfLines = 3;
        _labelTitle.lineBreakMode = NSLineBreakByClipping;
        [_labelTitle setFont:[UIFont systemFontOfSize:14.f]];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTitle;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        [_labelPrice setTextColor:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0]];
        [_labelPrice setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _labelPrice;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed:@"icon-group-success"]];
    }
    return _icon;
}

-(UILabel *)labelLine{
    if(!_labelLine){
        _labelLine = [[UILabel alloc]init];
        _labelLine.backgroundColor = theme_line_color;
    }
    return _labelLine;
}

@end
