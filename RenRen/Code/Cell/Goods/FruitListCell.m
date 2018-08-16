//
//  FruitListCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/7/20.
//
//

#import "FruitListCell.h"

@interface FruitListCell ()
@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UILabel* labelSummary;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIButton* btnAdd;
@property(nonatomic,strong) UIButton* btnStatus;
@end

@implementation FruitListCell

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
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelTitle];
    [self.bottomView addSubview:self.labelStatus];
    [self.bottomView addSubview:self.labelSummary];
    [self.bottomView addSubview:self.labelPrice];
    [self.bottomView addSubview:self.btnAdd];
    [self.bottomView addSubview:self.btnStatus];
}

-(void)layoutConstraints{
    self.photo.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSummary.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnStatus.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-20.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelStatus addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelStatus attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:55.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelStatus attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelSummary addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSummary attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelSummary attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelSummary attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelSummary attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelSummary attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.btnAdd addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAdd attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.btnStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStatus attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:35.f]];
    [self.btnStatus addConstraint:[NSLayoutConstraint  constraintWithItem:self.btnStatus attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:60.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStatus attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelSummary attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint  constraintWithItem:self.btnStatus attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
}

#pragma mark =====================================================  SEL
-(IBAction)addToShopCarTouch:(UIButton *)button{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addToShopCar:)]){
        [self.delegate addToShopCar:self.entity];
    }
}

#pragma mark =====================================================  property package
-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        self.labelTitle.text = entity.goodsName;
        self.labelSummary.text = entity.summary;
        NSString *strPrce = [NSString stringWithFormat: @"￥%@",entity.price];
        NSString *marktePrice =[NSString stringWithFormat: @"市场价￥%@",entity.maketPrice];
        NSString* str = [NSString stringWithFormat: @"%@ %@",strPrce,marktePrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:20.f]} range:[str rangeOfString:strPrce]];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:marktePrice]];
        [attributeStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:[str rangeOfString:marktePrice]];
        self.labelPrice.attributedText = attributeStr;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:entity.fruitImage] placeholderImage:[UIImage imageNamed: @"default-640x300"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(CGSizeEqualToSize(self.entity.thumbnailsSize, CGSizeZero)){
                CGFloat width = SCREEN_WIDTH;
                CGFloat height = image.size.height*width/image.size.width;
                self.entity.thumbnailsSize=CGSizeMake(width, height);
                if(self.tag>100){
                    NSIndexPath *index=[NSIndexPath indexPathForRow:self.tag inSection:0];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationrefReshFruitCell object:index];
                }
            }else{
                //NSLog( @"width = %f height = %f",self.entity.thumbnailsSize.width,self.entity.thumbnailsSize.height);
            }
        }];
        if([entity.storeStatus integerValue] == 1){
            if([entity.stock integerValue]>=10){
                self.labelStatus.hidden = YES;
                self.btnStatus.hidden = YES;
                self.btnAdd.hidden =NO;
            }else if([entity.stock integerValue]<10 && [entity.stock integerValue] > 0){
                self.labelStatus.hidden = NO;
                self.btnStatus.hidden = YES;
                self.btnAdd.hidden =NO;
                self.labelStatus.text =  @"库存紧张";
            }else{
                self.labelStatus.hidden = YES;
                self.btnStatus.hidden = NO;
                self.btnAdd.hidden = YES;
                [self.btnStatus setTitle: @"卖完了" forState:UIControlStateNormal];
            }
        }else{
            self.labelStatus.hidden = YES;
            self.btnStatus.hidden = NO;
            self.btnAdd.hidden = YES;
            [self.btnStatus setTitle: @"休息中" forState:UIControlStateNormal];
        }
        
    }
}

-(UIImageView *)photo{
    if(!_photo){
        _photo =[[UIImageView alloc]init];
        [_photo setImage:[UIImage imageNamed: @"default-640x300"]];
    }
    return _photo;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
    }
    return _bottomView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelTitle;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
        _labelStatus.textColor = [UIColor redColor];
        _labelStatus.font = [UIFont systemFontOfSize:12.f];
        _labelStatus.layer.masksToBounds = YES;
        _labelStatus.layer.cornerRadius = 5.f;
        _labelStatus.layer.borderColor = [UIColor redColor].CGColor;
        _labelStatus.layer.borderWidth = 1.f;
        _labelStatus.textAlignment = NSTextAlignmentCenter;
    }
    return _labelStatus;
}

-(UILabel *)labelSummary{
    if(!_labelSummary){
        _labelSummary = [[UILabel alloc]init];
        _labelSummary.font = [UIFont systemFontOfSize:14.f];
        _labelSummary.textColor = [UIColor colorWithRed:160/255.f green:160/255.f blue:160/255.f alpha:1.0];
    }
    return _labelSummary;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice  = [[UILabel alloc]init];
    }
    return _labelPrice;
}

-(UIButton *)btnAdd{
    if(!_btnAdd){
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd setImage:[UIImage imageNamed: @"icon-fruit-add"] forState:UIControlStateNormal];
        [_btnAdd addTarget:self action:@selector(addToShopCarTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAdd;
}

-(UIButton *)btnStatus{
    if(!_btnStatus){
        _btnStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnStatus.layer.masksToBounds = YES;
        _btnStatus.layer.cornerRadius = 5.f;
        [_btnStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnStatus.backgroundColor = [UIColor grayColor];
        _btnStatus.userInteractionEnabled = NO;
    }
    return _btnStatus;
}

@end

