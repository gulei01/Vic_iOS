//
//  MyTuanCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/6/29.
//
//

#import "MyTuanCell.h"

@interface MyTuanCell ()

@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UIImageView* icon;

@property(nonatomic,strong) UIView* bottomView;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UITextField* txtFeild;
@property(nonatomic,strong) UIButton*  btnLeft;
@property(nonatomic,strong) UILabel* labelRight;

@end

@implementation MyTuanCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
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
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.labelTitle];
    [self.bottomView addSubview:self.txtFeild];
    [self.contentView addSubview:self.photo];
    [self.photo addSubview:self.icon];
}

-(void)layoutConstraints{
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.photo setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.txtFeild setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*7/15]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-20.f]];
    [self.photo addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20.f]];
    
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.photo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    CGFloat height = [WMHelper calculateTextHeight:@"rowHeight" font:[UIFont systemFontOfSize:17.f] width:SCREEN_WIDTH];
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height*2]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.txtFeild addConstraint:[NSLayoutConstraint constraintWithItem:self.txtFeild attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtFeild attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtFeild attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.bottomView addConstraint:[NSLayoutConstraint constraintWithItem:self.txtFeild attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
}



#pragma mark =====================================================  property package
-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:[item objectForKey: @"default_image"]] placeholderImage:[UIImage imageNamed:@"Icon-60"]];        
        self.labelTitle.text = [item objectForKey: @"foodname"];
        [self.btnLeft setTitle:[NSString stringWithFormat:@"%@人团",[item objectForKey: @"successnum"]] forState:UIControlStateNormal];
        NSString* strIcon = @"￥";
        NSString* str = [NSString stringWithFormat:@"%@%@",strIcon,[item objectForKey: @"price"]];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 1)];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSForegroundColorAttributeName:[UIColor whiteColor]} range:[str rangeOfString:[item objectForKey: @"price"]]];
        [self.txtFeild setAttributedText:attributeStr];
        NSInteger status = [[item objectForKey: @"status"] integerValue];
        
        if(status == 1){
            [self.icon setImage:[UIImage imageNamed: @"icon-group-success"]];
        }else if (status == 0){
             [self.icon setImage:[UIImage imageNamed: @"icon-group-waiting"]];
        }else{
            [self.icon setImage:[UIImage imageNamed: @"icon-group-fail"]];
        }
        
    }
}

-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
        [_photo setImage:[UIImage imageNamed:@"Icon-60"]];
    }
    return _photo;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        [_icon setImage:[UIImage imageNamed:@"icon-group-success"]];
    }
    return _icon;
}

-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc]init];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 88.f, SCREEN_WIDTH, 2.f);
        border.backgroundColor = theme_line_color.CGColor;
        [_bottomView.layer addSublayer:border];
    }
    return _bottomView;
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

-(UITextField *)txtFeild{
    if(!_txtFeild){
        _txtFeild = [[UITextField alloc]init];
        [_txtFeild setBackgroundColor:[UIColor colorWithRed:79/255.f green:79/255.f blue:79/255.f alpha:1.0]];
        _txtFeild.borderStyle=UITextBorderStyleNone;
        _txtFeild.layer.borderColor =theme_line_color.CGColor;
        _txtFeild.font = [UIFont systemFontOfSize:14.f];
        _txtFeild.layer.borderWidth = 1.0f;
        _txtFeild.layer.masksToBounds = YES;
        _txtFeild.layer.cornerRadius = 5.f;
        _txtFeild.leftView = self.btnLeft;
        _txtFeild.leftViewMode =UITextFieldViewModeAlways;
        _txtFeild.rightView = self.labelRight;
        _txtFeild.rightViewMode = UITextFieldViewModeAlways;
        [_txtFeild setTextAlignment:NSTextAlignmentCenter];
        _txtFeild.userInteractionEnabled = NO;
    }
    return _txtFeild;
}

-(UIButton *)btnLeft{
    if(!_btnLeft){
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLeft setFrame:CGRectMake(0, 0, 80.f, 40.f)];
        _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnLeft.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 80-30);
        _btnLeft.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_btnLeft setImage:[UIImage imageNamed:@"icon-group"] forState:UIControlStateNormal];
        [_btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_btnLeft setBackgroundColor:[UIColor colorWithRed:79/255.f green:79/255.f blue:79/255.f alpha:1.0]];
    }
    return _btnLeft;
}

-(UILabel *)labelRight{
    if(!_labelRight){
        _labelRight = [[UILabel alloc]init];
        [_labelRight setFrame:CGRectMake(0, 0, 120.f, 40.f)];
        [_labelRight setBackgroundColor:[UIColor redColor]];
        [_labelRight setTextColor:[UIColor whiteColor]];
        _labelRight.textAlignment = NSTextAlignmentCenter;
        [_labelRight setText:@"查看详情 >" ];
    }
    return _labelRight;
}


@end
