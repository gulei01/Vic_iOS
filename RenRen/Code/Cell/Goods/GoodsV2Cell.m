//
//  GoodsV2Cell.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/20.
//
//

#import "GoodsV2Cell.h"

@interface GoodsV2Cell ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UIImageView* imgDefault;
@property(nonatomic,strong) UIImageView* imgRecommend;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelMiaoSha;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIButton* btnAdd;

@end

@implementation GoodsV2Cell{
    NSInteger bottomHeight;
    NSInteger imgSize;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    // height = 10+imgSize+5+bottomHeight
    
    imgSize = 70;
    
    [self addSubview:self.imgDefault];
    [self addSubview:self.imgRecommend];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelMiaoSha];
    [self addSubview:self.labelPrice];
    [self addSubview:self.btnAdd];
   
    
    
//    [self layoutConstains];
    
    NSArray* formats = @[@"H:|-leftEdge-[imgDefault(==100)]-spaceEdge-|", @"V:|-padding-[imgDefault(==imgSize)]-padding-|",
                         @"H:[imgDefault]-padding-[labelTitle]-padding-|",@"H:[imgDefault]-padding-[labelMiaoSha(==30)]",@"H:[imgDefault]-padding-[labelPrice]-defEdge-|",@"V:|-padding-[labelTitle(==30)]-(-2)-[labelMiaoSha(==16)]-2-[labelPrice(==18)]-padding-|",
                         @"H:|-90-[imgRecommend(==30)]",@"V:|-defEdge-[imgRecommend(==30)]",
                          @"H:[btnAdd(==iconSize)]-padding-|", @"V:[btnAdd(==iconSize)]-padding-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0),@"spaceEdge":@(SCREEN_WIDTH-90-80), @"leftEdge":@(10),  @"padding":@(7),@"topEdge":@(10), @"imgSize":@(imgSize),
                               @"iconSize":@(25)};
    NSDictionary* views = @{ @"imgDefault":self.imgDefault, @"imgRecommend":self.imgRecommend, @"btnAdd":self.btnAdd, @"labelTitle":self.labelTitle, @"labelMiaoSha":self.labelMiaoSha, @"labelPrice":self.labelPrice};
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    
    _labelTitle.textAlignment = NSTextAlignmentLeft;
    _labelMiaoSha.textAlignment = NSTextAlignmentLeft;
    _labelPrice.textAlignment = NSTextAlignmentLeft;
}

//- (void)layoutConstains {
//  
//
//
//
//}

//自己更改100
-(IBAction)addToShopCarTouch:(UIButton *)button{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:FXLShoppingSelectingBtn object:nil userInfo:@{@"fxlShoppingSelectingBtn":button}];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(addToShopCar:)]){
        [self.delegate addToShopCar:self.entity];
    }
}

//-(IBAction)tapPhotoTouch:(id)sender{
//    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectGoodPhoto:)]){
//        [self.delegate didSelectGoodPhoto:self.entity];
//    }
//}

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        self.labelPrice.text = [NSString stringWithFormat:@"￥%@",entity.price];
        self.labelTitle.text = entity.goodsName;
        [self.imgDefault sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:kDefaultImage] options:SDWebImageRefreshCached completed:nil];
        CGFloat price = [entity.price floatValue];
        CGFloat maketPrice = [entity.maketPrice floatValue];
        self.imgRecommend.hidden = price>=maketPrice;
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
        if(entity.isMiaoSha){
            self.labelMiaoSha.hidden = NO;
        }else{
            self.labelMiaoSha.hidden = YES;
        }
    }
}

#pragma mark =====================================================  property package
-(UIImageView *)imgDefault{
    if(!_imgDefault){
        _imgDefault = [[UIImageView alloc]init];
        _imgDefault.userInteractionEnabled = NO;
//        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhotoTouch:)];
//        [_imgDefault addGestureRecognizer:tap];
        _imgDefault.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgDefault;
}

-(UIImageView *)imgRecommend{
    if(!_imgRecommend){
        _imgRecommend = [[UIImageView alloc]init];
        [_imgRecommend  setImage:[UIImage imageNamed:@"icon-promotion"]];
        _imgRecommend.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imgRecommend;
}


-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        _labelTitle.numberOfLines = 2;
        _labelTitle.lineBreakMode = NSLineBreakByClipping;
        _labelTitle.preferredMaxLayoutWidth = self.frame.size.width-10;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UILabel *)labelMiaoSha{
    if(!_labelMiaoSha){
        _labelMiaoSha = [[UILabel alloc]init];
        _labelMiaoSha.backgroundColor = [UIColor redColor];
        _labelMiaoSha.text =  @"秒杀";
        _labelMiaoSha.textColor = [UIColor whiteColor];
        _labelMiaoSha.textAlignment = NSTextAlignmentLeft;
        _labelMiaoSha.font = [UIFont systemFontOfSize:12.f];
        _labelMiaoSha.layer.masksToBounds = YES;
        _labelMiaoSha.layer.cornerRadius = 5.f;
        _labelMiaoSha.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelMiaoSha;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.font = [UIFont systemFontOfSize:14.f];
        _labelPrice.textColor = [UIColor redColor];
        _labelPrice.textAlignment = NSTextAlignmentLeft;
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

-(UIButton *)btnAdd{
    if(!_btnAdd){
        _btnAdd  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd addTarget:self action:@selector(addToShopCarTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnAdd;
}

@end
