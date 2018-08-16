//
//  PresaleCell.m
//  KYRR
//
//  Created by kyjun on 16/6/7.
//
//

#import "PresaleCell.h"
#import "VerticallyAlignedLabel.h"


@interface PresaleCell ()


@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) VerticallyAlignedLabel* labelTitle;

@property(nonatomic,strong) UILabel* labelCount;
@property(nonatomic,strong) UITextField* txtPresale;
@property(nonatomic,strong) UIButton* btnGo;

@property(nonatomic,strong) UIImageView* line;

@end

@implementation PresaleCell{
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
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelCount];
    [self.contentView addSubview:self.txtPresale];
    [self.contentView addSubview:self.line];
}

-(void)layoutConstraints{
    [self.photo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelCount setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.txtPresale setTranslatesAutoresizingMaskIntoConstraints:NO ];
    [self.line setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:120.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    
    CGFloat height = [WMHelper calculateTextHeight:@"rowHeight" font:[UIFont systemFontOfSize:14.f] width:SCREEN_WIDTH];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height*3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.txtPresale addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPresale attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPresale attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPresale attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.txtPresale attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.txtPresale attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.0f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}



#pragma mark =====================================================  property package
-(void)setEntity:(MPresale *)entity{
    if(entity){
        _entity = entity;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:entity.thumbnails] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
        self.labelTitle.text = entity.goodsName;
        self.labelCount.text =[NSString stringWithFormat:@"已有%@人预定",entity.goodsSales];
        NSString* strIcon = @"￥";
        NSString* strPrice =[NSString stringWithFormat:@"￥%@",entity.marketPrice];;
        NSString* str = [NSString stringWithFormat:@"%@%@ %@",strIcon,entity.presalePrice,strPrice];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f],NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:entity.presalePrice]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0],NSStrikethroughStyleAttributeName:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)} range:[str rangeOfString:strPrice]];
        [self.txtPresale setAttributedText:attributeStr];
        if([entity.goodsStock integerValue] == 0){
            self.btnGo.userInteractionEnabled = NO;
            self.btnGo.backgroundColor = [UIColor grayColor];
            [self.btnGo setTitle:@"已售光" forState:UIControlStateNormal];
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

-(VerticallyAlignedLabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[VerticallyAlignedLabel alloc]init];
        [_labelTitle setTextColor:[UIColor colorWithRed:80/255.f green:80/255.f blue:80/255.f alpha:1.0]];
        _labelTitle.numberOfLines = 3;
        _labelTitle.lineBreakMode = NSLineBreakByClipping;
        _labelTitle.verticalAlignment = VerticalAlignmentTop;
        [_labelTitle setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _labelTitle;
}

-(UILabel *)labelCount{
    if(!_labelCount){
        _labelCount = [[UILabel alloc]init];
        [_labelCount setTextColor:[UIColor colorWithRed:146/255.f green:146/255.f blue:146/255.f alpha:1.0]];
        [_labelCount setFont:[UIFont systemFontOfSize:14.f]];
    }
    return _labelCount;
}

-(UITextField *)txtPresale{
    if(!_txtPresale){
        UIButton* btn  =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 70, 30);
        [btn setBackgroundColor:[UIColor colorWithRed:255/255.f green:138/255.f blue:0/255.f alpha:1.0]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"马上抢 >" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _btnGo = btn;
       _txtPresale = [[UITextField alloc]init];
        _txtPresale.backgroundColor = theme_default_color;
        _txtPresale.borderStyle=UITextBorderStyleNone;
        _txtPresale.layer.borderColor =[UIColor colorWithRed:255/255.f green:138/255.f blue:0/255.f alpha:1.0].CGColor;
        _txtPresale.font = [UIFont systemFontOfSize:14.f];
        _txtPresale.layer.borderWidth = 1.0f;
        _txtPresale.layer.masksToBounds = YES;
        _txtPresale.layer.cornerRadius = 5.f;
        _txtPresale.rightView = btn;
        _txtPresale.rightViewMode = UITextFieldViewModeAlways;
        _txtPresale.userInteractionEnabled = NO;
    }
    return _txtPresale;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = theme_line_color;
    }
    return _line;
}

@end
