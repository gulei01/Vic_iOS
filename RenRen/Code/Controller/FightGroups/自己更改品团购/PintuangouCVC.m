//
//  PintuangouCVC.m
//  KYRR
//
//  Created by ios on 17/5/29.
//
//

#import "PintuangouCVC.h"


@interface PintuangouCVC ()

@property(nonatomic,strong) UIImageView* photo;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelTitle;

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView* iconView;
@property(nonatomic,strong) UILabel*iconLable;
@property(nonatomic,strong) UILabel*moneyLabel;
@property(nonatomic,strong) UILabel *btnRight;

#define cellWidth (SCREEN_WIDTH -30)/2

#define cellHeight 220

@end

@implementation PintuangouCVC

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self layoutUI];
        [self layoutConstraints];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:YES];
    
    // Configure the view for the selected state
}

-(void)layoutUI{
    
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.bgView];
    
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10, cellHeight - 72, 20, 20)];
    _iconView.image = [[UIImage imageNamed:@"icon-group"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    _iconView.backgroundColor = theme_navigation_color;
    _iconView.clipsToBounds = YES;
    _iconView.layer.cornerRadius = 8;
    [self.contentView addSubview:_iconView];
    
    
    _iconLable = [[UILabel alloc]initWithFrame:CGRectMake(40, cellHeight - 72, cellWidth-50, 20)];
    _iconLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_iconLable];

    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (cellWidth-20)/2, 35)];
    _moneyLabel.text = @"$9.9";
    _moneyLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_moneyLabel];
    
    _btnRight = [[UILabel alloc]initWithFrame:CGRectMake(cellWidth/2-5, 0, (cellWidth-20)/2, 35)];
    _btnRight.backgroundColor = theme_navigation_color;
    _btnRight.text = @"马上抢 >";
    _btnRight.textAlignment = NSTextAlignmentLeft;
    _btnRight.clipsToBounds = YES;
    _btnRight.layer.cornerRadius = 5;
    _btnRight.textColor = [UIColor whiteColor];
    [_bgView addSubview:_btnRight];
    
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(cellWidth/2-5, 0, 3, 35)];
    spaceView.backgroundColor = theme_navigation_color;
    [_bgView addSubview:spaceView];

}

-(void)layoutConstraints{
    [self.photo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:cellWidth]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:cellHeight - 100]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:cellWidth-20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:cellHeight-95]];
    
    
}



#pragma mark =====================================================  property package
-(void)setEntity:(MFightGroup *)entity{
    if(entity){
        _entity = entity;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:entity.thumbnails] placeholderImage:[UIImage imageNamed:@"Icon-60"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if(CGSizeEqualToSize(self.entity.thumbnailsSize, CGSizeZero)){
                CGFloat width = SCREEN_WIDTH;
                CGFloat height = image.size.height*width/image.size.width;
                self.entity.thumbnailsSize=CGSizeMake(width, height);
                /*  NSIndexPath *index=[NSIndexPath indexPathForRow:self.tag inSection:0];
                 [[NSNotificationCenter defaultCenter] postNotificationName:NotificationrefReshFightGroupCell object:index];*/
            }
        }];
        
        self.labelTitle.text = entity.goodsName;
        self.iconLable.text = [NSString stringWithFormat:@"%@人团",entity.pingNum];
        NSString* strIcon = @"￥";
        NSString* str = [NSString stringWithFormat:@"%@%@",strIcon,entity.tuanPrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSForegroundColorAttributeName:[UIColor whiteColor]} range:[str rangeOfString:entity.tuanPrice]];
        [self.moneyLabel setAttributedText:attributeStr];
        
    }
}

-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
        _photo.backgroundColor = [UIColor greenColor];
    
    }
    return _photo;
}


-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        [_labelTitle setFont:[UIFont systemFontOfSize:16.f]];
        _labelTitle.numberOfLines = 2;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _labelTitle;
}


- (UIView *)bgView {

    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(10, cellHeight - 45, cellWidth-20, 35)];
        _bgView.backgroundColor = [UIColor colorWithRed:79/255.f green:79/255.f blue:79/255.f alpha:1.0];
        _bgView.clipsToBounds = YES;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;

}



@end
