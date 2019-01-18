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
@property(nonatomic,strong) UILabel* addNumLabel;
@property(nonatomic,strong) UIButton* btnSub;
@property(nonatomic,strong) UIButton* btnSelect;
@property(nonatomic,strong) UILabel* specSelectNum;
@property(nonatomic,strong) UILabel* labelDeposit;

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
    [self addSubview:self.addNumLabel];
    [self addSubview:self.btnSub];
    [self addSubview:self.btnSelect];
    [self addSubview:self.specSelectNum];
    [self addSubview:self.labelDeposit];
   
    
    
//    [self layoutConstains];
    
    NSArray* formats = @[@"H:|-leftEdge-[imgDefault(==100)]-spaceEdge-|", @"V:|-padding-[imgDefault(==imgSize)]-padding-|",
                         @"H:[imgDefault]-padding-[labelTitle]-padding-|",@"H:[imgDefault]-padding-[labelMiaoSha(==30)]",
                         @"H:[imgDefault]-padding-[labelPrice]-defEdge-|",
                         @"H:[imgDefault]-padding-[labelDeposit]-defEdge-|",
                         @"V:|-padding-[labelTitle(==35)]-(-2)-[labelDeposit(==16)]",
                         @"V:|-padding-[labelTitle(==35)]-(-2)-[labelMiaoSha(==16)]-2-[labelPrice(==18)]-padding-|",
                         @"H:|-90-[imgRecommend(==30)]",@"V:|-defEdge-[imgRecommend(==30)]",
                          @"H:[btnSub(==iconSize)][addNumLabel(==30)][btnAdd(==iconSize)]-padding-|", @"V:[btnAdd(==iconSize)]-padding-|",
                         @"V:[btnSub(==iconSize)]-padding-|",@"V:[addNumLabel(==iconSize)]-padding-|",
                         @"H:[btnSelect(==selectSize)]-padding-|",@"V:[btnSelect(==iconSize)]-padding-|",
                         @"H:[specSelectNum(==16)]-2-|",@"V:[specSelectNum(==16)]-25-|"
                         ];
    NSDictionary* metrics = @{ @"defEdge":@(0),@"spaceEdge":@(SCREEN_WIDTH-90-80), @"leftEdge":@(10),  @"padding":@(7),@"topEdge":@(10), @"imgSize":@(imgSize),@"iconSize":@(25),@"selectSize":@(70)};
    NSDictionary* views = @{ @"imgDefault":self.imgDefault, @"imgRecommend":self.imgRecommend, @"btnAdd":self.btnAdd,@"btnSub":self.btnSub,@"addNumLabel":self.addNumLabel, @"labelTitle":self.labelTitle, @"labelMiaoSha":self.labelMiaoSha, @"labelPrice":self.labelPrice, @"btnSelect":self.btnSelect,@"specSelectNum":self.specSelectNum,@"labelDeposit":self.labelDeposit};
    
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
    NSString *num = button.tag == 1 ? @"1" : @"-1";
    NSLog(@"garfunkel_log:clickAddGood");
    if(self.delegate && [self.delegate respondsToSelector:@selector(addToShopCar:num:)]){
        [self.delegate addToShopCar:self.entity num:num];
    }
//    if([num integerValue] == 1)
//        [[NSNotificationCenter defaultCenter]postNotificationName:FXLShoppingSelectingBtn object:nil userInfo:@{@"fxlShoppingSelectingBtn":button}];
    //NSLog(@"garfunkel add_cart:%@",num);
}

-(void)showGoodDetail{
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOpenGoodDetail object:@{@"item":self.entity}];
}

-(void)selectTouch:(UIButton *)button{
//    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOpenSpec object:(self.entity)];
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOpenSpec object:@{@"item":self.entity,@"btn":button}];
}

//-(IBAction)tapPhotoTouch:(id)sender{
//    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectGoodPhoto:)]){
//        [self.delegate didSelectGoodPhoto:self.entity];
//    }
//}

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        self.labelPrice.text = [NSString stringWithFormat:@"$%@",entity.price];
        self.labelTitle.text = entity.goodsName;
        [self.imgDefault sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:kDefaultImage] options:SDWebImageRefreshCached completed:nil];
        CGFloat price = [entity.price floatValue];
        CGFloat maketPrice = [entity.maketPrice floatValue];
        self.imgRecommend.hidden = price>=maketPrice;
        if([entity.storeStatus integerValue]==1){
            if([entity.stock integerValue]>0){
                self.btnSelect.userInteractionEnabled = YES;
                self.btnAdd.userInteractionEnabled = YES;
                [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
            }else {
                self.btnSelect.userInteractionEnabled = NO;
                self.btnAdd.userInteractionEnabled = NO;
                [self.btnAdd setImage:[UIImage imageNamed:@"icon-nothing"] forState:UIControlStateNormal];
            }
        }else{
            self.btnSelect.userInteractionEnabled = NO;
            self.btnAdd.userInteractionEnabled = NO;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-off"] forState:UIControlStateNormal];
        }
        if(entity.isMiaoSha){
            self.labelMiaoSha.hidden = NO;
        }else{
            self.labelMiaoSha.hidden = YES;
        }
        //NSLog(@"garfunkel_log:showQuantity:%@",entity.quantity);
        if(entity.has_format){
            self.btnAdd.hidden = YES;
            self.addNumLabel.hidden = YES;
            self.btnSub.hidden = YES;
            self.btnSelect.hidden = NO;
            if (![entity.quantity isEqualToString:@"0"]) {
                self.specSelectNum.hidden = NO;
                self.specSelectNum.text = entity.quantity;
            }else{
                self.specSelectNum.hidden = YES;
            }
        }else{
            self.btnAdd.hidden = NO;
            self.btnSelect.hidden = YES;
            self.specSelectNum.hidden = YES;
            if ([entity.quantity isEqualToString:@"0"]) {
                self.addNumLabel.hidden = YES;
                self.btnSub.hidden = YES;
            }else{
                self.addNumLabel.hidden = NO;
                self.btnSub.hidden = NO;
                self.addNumLabel.text = entity.quantity;
            }
        }
        
        if([entity.deposit floatValue] > 0){
            self.labelDeposit.text = [NSString stringWithFormat:@"%@:$%@",Localized(@"Deposit_price"),entity.deposit];
        }else{
            self.labelDeposit.text = @"";
        }
    }
}

#pragma mark =====================================================  property package
-(UIImageView *)imgDefault{
    if(!_imgDefault){
        _imgDefault = [[UIImageView alloc]init];
//        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPhotoTouch:)];
//        [_imgDefault addGestureRecognizer:tap];
        _imgDefault.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showGoodDetail)];
        [_imgDefault addGestureRecognizer:labelTapGestureRecognizer];
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
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _labelTitle.preferredMaxLayoutWidth = self.frame.size.width-10;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.userInteractionEnabled=YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showGoodDetail)];
        [_labelTitle addGestureRecognizer:labelTapGestureRecognizer];
        
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

-(UILabel *)labelMiaoSha{
    if(!_labelMiaoSha){
        _labelMiaoSha = [[UILabel alloc]init];
        _labelMiaoSha.backgroundColor = [UIColor redColor];
        _labelMiaoSha.text =  @"Spike";
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
-(UILabel *)addNumLabel{
    if(!_addNumLabel){
        _addNumLabel = [[UILabel alloc] init];
        _addNumLabel.text = @"20";
        _addNumLabel.textAlignment = NSTextAlignmentCenter;
        _addNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _addNumLabel;
}

-(UIButton *)btnAdd{
    if(!_btnAdd){
        _btnAdd  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAdd.tag = 1;
        [_btnAdd addTarget:self action:@selector(addToShopCarTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnAdd;
}

-(UIButton *)btnSub{
    if(!_btnSub){
        _btnSub  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSub.tag = 2;
        [_btnSub setImage:[UIImage imageNamed:@"icon-sub"] forState:UIControlStateNormal];
        [_btnSub addTarget:self action:@selector(addToShopCarTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnSub.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnSub;
}

-(UIButton *)btnSelect{
    if(!_btnSelect){
        _btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSelect setTitle:Localized(@"Optional_spec") forState:UIControlStateNormal];
        _btnSelect.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_btnSelect setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btnSelect.layer.cornerRadius = 5.0;
        _btnSelect.layer.borderWidth = 1.0f;
        _btnSelect.layer.borderColor = [UIColor grayColor].CGColor;
        [_btnSelect addTarget:self action:@selector(selectTouch:) forControlEvents:UIControlEventTouchUpInside];
        _btnSelect.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _btnSelect;
}

-(UILabel *)specSelectNum{
    if(!_specSelectNum){
        _specSelectNum = [[UILabel alloc]init];
        _specSelectNum.textColor = [UIColor whiteColor];
        _specSelectNum.layer.masksToBounds = YES;
        _specSelectNum.layer.cornerRadius = 8;
        _specSelectNum.backgroundColor = [UIColor redColor];
        _specSelectNum.textAlignment = NSTextAlignmentCenter;
        _specSelectNum.font = [UIFont systemFontOfSize:12.f];
        
        _specSelectNum.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _specSelectNum;
}

-(UILabel *)labelDeposit{
    if(!_labelDeposit){
        _labelDeposit = [[UILabel alloc]init];
        _labelDeposit.textColor = [UIColor grayColor];
        _labelDeposit.font = [UIFont systemFontOfSize:12.f];
        
        _labelDeposit.text = Localized(@"Deposit_price");
        
        _labelDeposit.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelDeposit;
}

@end
