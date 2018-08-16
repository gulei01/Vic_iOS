//
//  GroupBuyHeader.m
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import "GroupBuyHeader.h"

@interface GroupBuyHeader ()

@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;

@end

@implementation GroupBuyHeader

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
}

-(void)layoutConstraints{
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    
    CGFloat height = [WMHelper calculateTextHeight:@"rowHeight" font:[UIFont systemFontOfSize:14.f] width:SCREEN_WIDTH];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height*3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
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
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} range:[str rangeOfString:entity.fightGroup.tuanPrice]];
        self.labelPrice.attributedText = attributeStr;
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


@end
