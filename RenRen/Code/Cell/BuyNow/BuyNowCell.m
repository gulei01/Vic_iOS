//
//  BuyNowCell.m
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import "BuyNowCell.h"
#import "ZQCountDownView.h"
#import "VerticallyAlignedLabel.h"

@interface BuyNowCell ()
@property(nonatomic,strong) UIButton* btnStoreName;
@property(nonatomic,strong) UIImageView* arrow;
@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) VerticallyAlignedLabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UIButton* btnGo;
@property(nonatomic,strong) ZQCountDownView* timerView;
@property(nonatomic,strong) UIImageView* line;

@end



@implementation BuyNowCell {
    NSString* defaultImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        defaultImage  = @"Icon-default-image";
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)layoutUI{
    [self.contentView addSubview:self.btnStoreName];
    [self.btnStoreName addSubview:self.arrow];
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelPrice];
    [self.contentView addSubview:self.btnGo];
    [self.contentView addSubview:self.timerView];
    [self.contentView addSubview:self.line];
}

-(void)layoutConstraints{
    [self.btnStoreName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.arrow setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.photo setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelPrice setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.btnGo setTranslatesAutoresizingMaskIntoConstraints:NO ];
    self.timerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.line setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.btnStoreName addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStoreName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStoreName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStoreName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnStoreName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:8.f]];
    [self.arrow addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:14.f]];
    [self.btnStoreName addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.btnStoreName attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.btnStoreName addConstraint:[NSLayoutConstraint constraintWithItem:self.arrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnStoreName attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    
    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnStoreName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeTop multiplier:1.0 constant:-5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    CGFloat height = [WMHelper calculateTextHeight:@"rowHeight" font:[UIFont systemFontOfSize:14.f] width:SCREEN_WIDTH];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height*3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnStoreName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-18.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.btnGo addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnGo addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-18.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.btnGo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.timerView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.timerView addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-18.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10.0f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}

#pragma mark =====================================================  SEL
-(void)beginBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.btnGo.hidden = NO;
        self.btnGo.backgroundColor = [UIColor redColor];
        self.timerView.hidden = YES;
        [self.btnGo setTitle:@"马上抢>" forState:UIControlStateNormal];
    });
}
-(void)endBuy{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.btnGo.userInteractionEnabled = NO;
        self.btnGo.backgroundColor = [UIColor grayColor];
        [self.btnGo setTitle:@"已结束" forState:UIControlStateNormal];
    });
}

-(IBAction)btnStoreNameTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(buyNowStore:)]){
        [self.delegate buyNowStore:self.entity];
    }
}

-(IBAction)btnGoTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(buyNowGo:)]){
        [self.delegate buyNowGo:self.entity];
    }
}

#pragma mark =====================================================  property package
-(void)setEntity:(MBuyNow *)entity{
    if(entity){
        _entity = entity;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:entity.thumbnails] placeholderImage:[UIImage imageNamed:defaultImage]];
        self.labelTitle.text = entity.goodsName;
        
        [self.btnStoreName setTitle:entity.storeName forState:UIControlStateNormal];
        NSString* strIcon = @"￥";
        NSString* marktPrice = [NSString stringWithFormat:@"￥%@",entity.marketPrice];
        NSString* str = [NSString stringWithFormat:@"%@%@ %@",strIcon,entity.buyNowPrice,marktPrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:entity.buyNowPrice]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:marktPrice]];
        [self.labelPrice setAttributedText:attributeStr];
        
        NSDate* beginDate = [WMHelper convertToDateWithStr:entity.beginDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* nowDate = [NSDate date];
       
        NSTimeInterval beginInterval= [nowDate timeIntervalSinceDate:beginDate];
        
        NSDate* endData = [WMHelper convertToDateWithStr:entity.endDate format:@"yyyy-MM-dd HH:mm:ss"];
        NSTimeInterval endInterval = [nowDate timeIntervalSinceDate:endData];         
        
        if([entity.goodsStock integerValue] == 0 ){//库存为0/店铺休息中
            self.btnGo.hidden = NO;
            self.timerView.hidden = YES;
            self.btnGo.backgroundColor = [UIColor grayColor];
            self.btnGo.userInteractionEnabled = NO;
            [self.btnGo setTitle: @"抢完啦" forState:UIControlStateNormal];
        }else{
            if(endInterval>=0){//活动结束
                self.btnGo.userInteractionEnabled = NO;
                self.btnGo.hidden = NO;
                self.timerView.hidden = YES;
                self.btnGo.backgroundColor = [UIColor grayColor];
                [self.btnGo setTitle:@"已结束" forState:UIControlStateNormal];
            }else{
                if(beginInterval>0){//活动开始
                    self.btnGo.hidden = NO;
                    self.timerView.hidden = YES;
                    [self.btnGo setBackgroundColor:[UIColor redColor]];
                    self.btnGo.userInteractionEnabled = YES;
                    [self.btnGo setTitle: @"马上抢>" forState:UIControlStateNormal];
                    [NSTimer scheduledTimerWithTimeInterval:-endInterval target:self selector:@selector(endBuy) userInfo:nil repeats:NO];
                }else{//活动没开始
                    self.btnGo.hidden = YES;
                    self.timerView.hidden = NO;
                    self.timerView.countDownTimeInterval = -beginInterval;
                    [NSTimer scheduledTimerWithTimeInterval:-beginInterval target:self selector:@selector(beginBuy) userInfo:nil repeats:NO];
                }
            }
        }
    }
}


-(UIButton *)btnStoreName{
    if(!_btnStoreName){
        _btnStoreName = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnStoreName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnStoreName.imageEdgeInsets = UIEdgeInsetsMake(15/2, 15, 15/2, SCREEN_WIDTH-35);
        _btnStoreName.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [_btnStoreName setImage:[UIImage imageNamed:@"icon-store"] forState:UIControlStateNormal];
        [_btnStoreName addTarget:self action:@selector(btnStoreNameTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_btnStoreName setTitleColor:theme_Fourm_color forState:UIControlStateNormal];
        _btnStoreName.titleLabel.font = [UIFont systemFontOfSize:14.f];
        CALayer *border = [CALayer layer];
        border.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,1.0f);
        border.backgroundColor = theme_line_color.CGColor;
        [_btnStoreName.layer addSublayer:border];
        
    }
    return _btnStoreName;
}

-(UIImageView *)arrow{
    if(!_arrow ){
        _arrow = [[UIImageView alloc]init];
        [_arrow setImage:[UIImage imageNamed:@"icon-arrow-right"]];
    }
    return _arrow;
}

-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
        _photo.layer.borderColor = [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1.0].CGColor;
        _photo.layer.borderWidth = 1.f;
    }
    return _photo;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed:@"icon-buy-icon"]];
    }
    return _icon;
}

-(VerticallyAlignedLabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[VerticallyAlignedLabel alloc]init];
        [_labelTitle setTextColor:[UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.0]];
        _labelTitle.numberOfLines = 3;
        _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
        _labelTitle.verticalAlignment = VerticalAlignmentTop;
        [_labelTitle setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _labelTitle;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        
    }
    return _labelPrice;
}

-(UIButton *)btnGo{
    if(!_btnGo){
        _btnGo = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGo setBackgroundColor:[UIColor redColor]];
        [_btnGo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnGo setTitle:@"马上抢>" forState:UIControlStateNormal];
        _btnGo.layer.masksToBounds = YES;
        _btnGo.layer.cornerRadius = 5.f;
        [_btnGo addTarget:self action:@selector(btnGoTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGo;
}

-(ZQCountDownView *)timerView{
    if(!_timerView){
        _timerView = [[ZQCountDownView alloc]initWithFrame:CGRectMake(0, 0, 80, 20.f)];
        // _timerView.backgroundColor = [UIColor redColor];
        _timerView.themeColor = [UIColor redColor];
        //_timerView.colonBackgroundColor = [UIColor redColor];
        _timerView.textColor = [UIColor whiteColor];
        _timerView.colonColor = [UIColor redColor];
        _timerView.textFont = [UIFont systemFontOfSize:14.f];
        _timerView.layer.masksToBounds = YES;
        _timerView.layer.cornerRadius = 5.f;
        
    }
    return _timerView;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = theme_line_color;
    }
    return _line;
}







@end
