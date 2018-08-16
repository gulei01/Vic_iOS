//
//  GoodsHeader.m
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import "GoodsHeader.h"

@interface GoodsHeader()

@property(nonatomic,strong) UIImageView* photoLogo;
@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UIView* titleView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIButton* btnAddCar;
@property(nonatomic,strong) UIView* storeView;
@property(nonatomic,strong) UIButton* btnStore;
@property(nonatomic,strong) UIView* otherView;
@property(nonatomic,strong) UILabel* labelOther;
@property(nonatomic,strong) UIImageView* imgArrow;

@end

@implementation GoodsHeader

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = theme_default_color;
    [self layoutUI];
    [self layoutConstraints];
    
}


#pragma mark =====================================================  UI布局
-(void)layoutUI{
    [self addSubview:self.photoLogo];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleView];
    [self.titleView addSubview:self.labelTitle];
    [self.titleView addSubview:self.labelPrice];
    [self.titleView addSubview:self.btnAddCar];
    [self.bottomView addSubview:self.storeView];
    [self.storeView addSubview:self.btnStore];
    [self.storeView addSubview:self.imgArrow];
    [self.bottomView addSubview:self.otherView];
    [self.otherView addSubview:self.labelOther];
}
-(void)layoutConstraints{
    
    self.photoLogo.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAddCar.translatesAutoresizingMaskIntoConstraints = NO;
    self.storeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnStore.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgArrow.translatesAutoresizingMaskIntoConstraints = NO;
    self.otherView.translatesAutoresizingMaskIntoConstraints =NO;
    self.labelOther.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];

    [self.btnAddCar addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnAddCar addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15.f]];
    [self.titleView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.storeView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.storeView addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.storeView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
    [self.otherView addConstraint:[NSLayoutConstraint constraintWithItem:self.otherView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.otherView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.otherView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.otherView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelOther addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.otherView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.otherView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.otherView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.otherView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.otherView addConstraint:[NSLayoutConstraint constraintWithItem:self.otherView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.otherView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
}

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        [self.photoLogo sd_setImageWithURL:[NSURL URLWithString:entity.maxImage] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cacheType = SDImageCacheTypeNone;
            if(CGSizeEqualToSize(self.entity.thumbnailsSize, CGSizeZero)){
                CGFloat width = (SCREEN_WIDTH-20);
                CGFloat height = image.size.height*width/image.size.width;
                self.entity.thumbnailsSize=CGSizeMake(width, height);
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshGoodsInfo object:nil];
            }
        } ];
        self.labelTitle.text = entity.goodsName;
        self.labelPrice.text = [NSString stringWithFormat:@"￥%@",entity.price];
        [self.btnStore setTitle:entity.storeName forState:UIControlStateNormal];
        if([entity.storeStatus integerValue]==1){
            if([entity.stock integerValue]<=0){
                self.btnAddCar.userInteractionEnabled = NO;
                self.btnAddCar.backgroundColor = [UIColor lightGrayColor];
                [self.btnAddCar setTitle:@"没货了" forState:UIControlStateNormal];
            }
        }else{
            self.btnAddCar.userInteractionEnabled = NO;
            self.btnAddCar.backgroundColor = [UIColor lightGrayColor];
            [self.btnAddCar setTitle:@"休息中" forState:UIControlStateNormal];
        }
        self.labelOther.text = @"也许你还喜欢";
    }
}

-(IBAction)btnStoreTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectSotre:)])
        [self.delegate didSelectSotre:sender];
}

-(IBAction)btnAddCarTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addShopCar:)])
        [self.delegate addShopCar:self.entity];
}

#pragma mark =====================================================  property package
-(UIImageView *)photoLogo{
    if(!_photoLogo){
        _photoLogo =[[UIImageView alloc]init];
    }
    return _photoLogo;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView =[[UIView alloc]init];
    }
    return _bottomView;
}

-(UIView *)titleView{
    if(!_titleView){
        _titleView = [[UIView alloc]init];
    }
    return _titleView;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:15.f];
        _labelTitle .numberOfLines=2;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 39.f, SCREEN_WIDTH-20, 1.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_labelTitle.layer addSublayer:border];
    }
    return _labelTitle;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textColor = theme_navigation_color;
        _labelPrice.font = [UIFont systemFontOfSize:14.f];
        _labelPrice.textAlignment = NSTextAlignmentLeft;
    }
    return _labelPrice;
}

-(UIButton *)btnAddCar{
    if(!_btnAddCar){
        _btnAddCar = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAddCar.backgroundColor = [UIColor colorWithRed:229/255.f green:0/255.f blue:71/255.f alpha:1.0];
        [_btnAddCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnAddCar setTitle:@"加入购物车" forState:UIControlStateNormal];
        _btnAddCar.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnAddCar.layer.cornerRadius=5.f;
        _btnAddCar.layer.masksToBounds = YES;
        [_btnAddCar addTarget:self action:@selector(btnAddCarTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddCar;
}

-(UIView *)storeView{
    if(!_storeView){
        _storeView = [[UIView alloc]init];
        _storeView.backgroundColor = theme_line_color;
    }
    return _storeView;
}

-(UIButton *)btnStore{
    if(!_btnStore){
        _btnStore =[UIButton buttonWithType:UIButtonTypeCustom];
        _btnStore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnStore .imageEdgeInsets = UIEdgeInsetsMake(15/2, 10, 15/2, SCREEN_WIDTH-45);
        _btnStore.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [ _btnStore setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
        [ _btnStore addTarget:self action:@selector(btnStoreTouch:) forControlEvents:UIControlEventTouchUpInside];
        [ _btnStore setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        _btnStore.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnStore.backgroundColor = [UIColor whiteColor];
    }
    return _btnStore;
}

-(UIImageView *)imgArrow{
    if(!_imgArrow){
        _imgArrow =[[UIImageView alloc]init];
        [_imgArrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    }
    return _imgArrow;
}

-(UIView *)otherView{
    if(!_otherView){
        _otherView = [[UIView alloc]init];
    }
    return _otherView;
}

-(UILabel *)labelOther{
    if(!_labelOther){
        _labelOther = [[UILabel alloc]init];
        _labelOther.text = @"       也许你还喜欢";
        _labelOther.textColor = theme_Fourm_color;
        _labelOther .textAlignment = NSTextAlignmentLeft;
        _labelOther.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelOther;
}



@end
