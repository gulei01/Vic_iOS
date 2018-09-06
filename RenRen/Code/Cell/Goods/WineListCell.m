//
//  WineListCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/8/26.
//
//

#import "WineListCell.h"

@interface WineListCell ()
@property(nonatomic,strong) UIView* topView;
@property(nonatomic,strong) UIImageView* thumbnail;
@property(nonatomic,strong) UIImageView* iconSales;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIButton* btnAdd;

@end

@implementation WineListCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.topView];
    [self.topView addSubview:self.thumbnail];
    [self.topView addSubview:self.iconSales];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelTitle];
    [self.bottomView addSubview:self.labelPrice];
    [self.bottomView addSubview:self.btnAdd];
}

-(void)layutConstraints{
    NSArray* formats = @[@"H:|-0-[topView]-0-|", @"V:|-0-[topView]",
                         @"H:|-0-[thumbnail]-0-|", @"V:|-0-[thumbnail]-0-|",
                         @"H:[iconSales(==iconSize)]-5-|", @"V:|-5-[iconSales(==iconSize)]",
                         @"H:|-0-[bottomView]-0-|", @"V:[topView][bottomView]-0-|",
                         @"H:|-5-[labelTitle]-5-|", @"V:[thumbnail][labelTitle(==titleHeight)]",
                         @"H:[btnAdd(==addSize)]-5-|", @"V:[btnAdd(==addSize)]-5-|",
                         @"H:|-5-[labelPrice]-10-[btnAdd]", @"V:[labelTitle][labelPrice]-5-|"
                         ];
    
    NSDictionary* metrics = @{ @"titleHeight":@(35), @"priceHeight":@(20), @"iconSize":@(30), @"addSize":@(30)};
    NSDictionary* views = @{ @"topView":self.topView, @"thumbnail":self.thumbnail, @"iconSales":self.iconSales, @"bottomView":self.bottomView, @"labelTitle":self.labelTitle, @"labelPrice":self.labelPrice, @"btnAdd":self.btnAdd};
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [ self addConstraints:constraints];
    }
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f];
    [self.topView addConstraint:constraint];
}

#pragma mark =====================================================  SEL
-(IBAction)addToShopCarTouch:(UIButton *)button {
    if(self.delegate && [self.delegate respondsToSelector:@selector(addToShopCar:num:)]){
        [self.delegate addToShopCar:self.entity num:@"1"];
    }
}


-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        NSArray* arrayPrice = [entity.price componentsSeparatedByString: @"."];
        NSString* strPrice = [NSString stringWithFormat:@"￥%@",entity.price];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:strPrice];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:12.f]} range:[strPrice rangeOfString: @"￥"]];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[strPrice rangeOfString: entity.price]];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:24.f]} range:[strPrice rangeOfString: arrayPrice[0]]];
        
        self.labelPrice.attributedText = attributeStr;
        self.labelTitle.text = entity.goodsName;
        [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:kDefaultImage] options:SDWebImageRefreshCached completed:nil];
        CGFloat price = [entity.price floatValue];
        CGFloat maketPrice = [entity.maketPrice floatValue];
        self.iconSales.hidden = price>=maketPrice;
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
    }
}

#pragma mark =====================================================  property pcakage
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}
-(UIImageView *)thumbnail{
    if(!_thumbnail){
        _thumbnail = [[UIImageView alloc]init];
        _thumbnail.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _thumbnail;
}

-(UIImageView *)iconSales{
    if(!_iconSales){
        _iconSales = [[UIImageView alloc]init];
        _iconSales.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconSales;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.numberOfLines = 2;
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textColor = [UIColor redColor];
        _labelPrice.font = [UIFont boldSystemFontOfSize:14.f];
        _labelPrice.textAlignment = NSTextAlignmentLeft;
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

-(UIButton *)btnAdd{
    if(!_btnAdd){
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd addTarget:self action:@selector(addToShopCarTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnAdd;
}

@end
