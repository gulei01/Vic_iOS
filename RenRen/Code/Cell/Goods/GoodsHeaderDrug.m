//
//  GoodsHeaderDrug.m
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import "GoodsHeaderDrug.h"

@interface GoodsHeaderDrug()

@property(nonatomic,strong) UIImageView* photoLogo;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UIImageView* line;
@property(nonatomic,strong) UILabel* labelprice;
@property(nonatomic,strong) UIButton* btnAddCar;
@property(nonatomic,strong) UIImageView* lineSpace;
@property(nonatomic,strong) UIButton* btnInfo;
@property(nonatomic,strong) UIImageView* imgArrow;
@property(nonatomic,strong) UIImageView* lineSpace2;
@property(nonatomic,strong) UIButton* btnStore;
@property(nonatomic,strong) UIImageView* imgArrow2;
@property(nonatomic,strong) UIImageView* lineSpace3;

@property(nonatomic,strong) UILabel* labelOther;

@end

@implementation GoodsHeaderDrug


- (void)awakeFromNib {
    // Initialization code
    
      self.backgroundColor = theme_default_color;
    
    [self layoutUI];
    [self layoutConstraints];
}


#pragma mark =====================================================  UI布局
-(void)layoutUI{
    self.photoLogo = [[UIImageView alloc]init];
    [self addSubview:self.photoLogo];
    
    self.labelTitle = [[UILabel alloc]init];
    self.labelTitle.font = [UIFont systemFontOfSize:15.f];
    self.labelTitle.numberOfLines=2;
    self.labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    self.labelTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.labelTitle];
    
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self addSubview:self.line];
    
    self.labelprice = [[UILabel alloc]init];
    self.labelprice.textColor = theme_navigation_color;
    self.labelprice.font = [UIFont systemFontOfSize:14.f];
    self.labelprice.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.labelprice];
    
    self.btnAddCar = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnAddCar.backgroundColor = [UIColor colorWithRed:229/255.f green:0/255.f blue:71/255.f alpha:1.0];
    [self.btnAddCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnAddCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    self.btnAddCar.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.btnAddCar.layer.cornerRadius=5.f;
    self.btnAddCar.layer.masksToBounds = YES;
    [self.btnAddCar addTarget:self action:@selector(btnAddShopCarTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnAddCar];
    
    self.lineSpace = [[UIImageView alloc]init];
    self.lineSpace.backgroundColor = theme_line_color;
    [self addSubview:self.lineSpace];
    
    self.btnInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnInfo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnInfo.imageEdgeInsets = UIEdgeInsetsMake(15/2, 0, 15/2, SCREEN_WIDTH-35);
    self.btnInfo.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.btnInfo setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
    [self.btnInfo addTarget:self action:@selector(btnInfoTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnInfo setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    self.btnInfo.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:self.btnInfo];
    self.imgArrow = [[UIImageView alloc]init];
    [self.imgArrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    [self.btnInfo addSubview:self.imgArrow];
    
    self.lineSpace2 = [[UIImageView alloc]init];
    self.lineSpace2.backgroundColor = theme_line_color;
    [self addSubview:self.lineSpace2];

    
    self.btnStore = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnStore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btnStore.imageEdgeInsets = UIEdgeInsetsMake(15/2, 0, 15/2, SCREEN_WIDTH-35);
    self.btnStore.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.btnStore setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
    [self.btnStore addTarget:self action:@selector(btnStoreTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnStore setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
    self.btnStore.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:self.btnStore];
    self.imgArrow2 = [[UIImageView alloc]init];
    [self.imgArrow2 setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    [self.btnStore addSubview:self.imgArrow2];
    
    self.lineSpace3 = [[UIImageView alloc]init];
    self.lineSpace3.backgroundColor = theme_line_color;
    [self addSubview:self.lineSpace3];
    
    self.labelOther = [[UILabel alloc]init];
    self.labelOther.text = @"       也许你还喜欢";
    self.labelOther.textColor = theme_Fourm_color;
    self.labelOther.textAlignment = NSTextAlignmentLeft;
    self.labelOther.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:self.labelOther];

}
-(void)layoutConstraints{
    self.photoLogo.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelprice.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnAddCar.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnInfo.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnStore.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgArrow.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgArrow2.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOther.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineSpace.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineSpace2.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineSpace3.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat height = SCREEN_WIDTH-20;
    
    [self.photoLogo addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
    [self.photoLogo addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photoLogo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.photoLogo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelprice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelprice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelprice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelprice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelprice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:9.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelprice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.btnAddCar addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.btnAddCar addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:9]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnAddCar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.lineSpace addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.f]];
    [self.lineSpace addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelprice attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    
    [self.btnInfo addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnInfo addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineSpace attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.imgArrow addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.btnInfo addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnInfo attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnInfo addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnInfo attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
    [self.lineSpace2 addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.f]];
    [self.lineSpace2 addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnInfo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineSpace2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStore attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    
    [self.imgArrow2 addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.imgArrow2 addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnStore attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnStore addConstraint:[NSLayoutConstraint constraintWithItem:self.imgArrow2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnStore attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
    [self.lineSpace3 addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.f]];
    [self.lineSpace3 addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnStore attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineSpace3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    
    [self.labelOther addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelOther addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lineSpace3 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelOther attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    
}

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        [self.photoLogo sd_setImageWithURL:[NSURL URLWithString:entity.maxImage] placeholderImage:[UIImage imageNamed:kDefaultImage] options:SDWebImageRefreshCached];
        self.labelTitle.text = entity.goodsName;
        self.labelprice.text = [NSString stringWithFormat:@"￥%@",entity.price];
        [self.btnInfo setTitle:@"说明书" forState:UIControlStateNormal];
        [self.btnStore setTitle:entity.storeName forState:UIControlStateNormal];
        self.labelOther.text = @"也许你还喜欢";
    }
}

-(IBAction)btnInfoTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectInfo:)])
        [self.delegate didSelectInfo:sender];
}
-(IBAction)btnStoreTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectSotre:)])
        [self.delegate didSelectSotre:sender];
}

-(IBAction)btnAddShopCarTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(addShopCar:)])
        [self.delegate addShopCar:sender];
}
@end
