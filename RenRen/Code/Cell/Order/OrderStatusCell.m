//
//  OrderStatusCell.m
//  KYRR
//
//  Created by kyjun on 16/4/18.
//
//

#import "OrderStatusCell.h"

@interface OrderStatusCell ()

@property(nonatomic,strong) UIView* infoView;;
@property(nonatomic,strong) UIImageView* infoBackground;

@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UIButton* btnMark;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UIImageView* icon;
@property(nonatomic,strong) UIImageView* lineTop;
@property(nonatomic,strong) UIImageView* lineBottom;





@end

@implementation OrderStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = theme_table_bg_color;
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.infoView];
    [self.infoView addSubview:self.infoBackground];
    [self.infoView addSubview:self.labelStatus];
    [self.infoView addSubview:self.btnMark];
    [self.infoView addSubview:self.labelCreateDate];
    [self.contentView addSubview:self.lineTop];
    [self.contentView addSubview:self.lineBottom];
    
}

-(void)layoutConstraints{
    self.lineTop.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineBottom.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoView.translatesAutoresizingMaskIntoConstraints = NO;
    self.infoBackground.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnMark.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.lineTop addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTop attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    
    [self.lineBottom addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.lineBottom attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.infoBackground attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.labelStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.btnMark addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.self.labelStatus attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
     [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self.infoView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnMark attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.infoView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
}

#pragma mark =====================================================  SEL
-(IBAction)callPhoneTouch:(id)sender{
          NSArray* array =   [self.entity.mark componentsSeparatedByString:@":"];
    if(self.delegate && [self.delegate respondsToSelector:@selector(orderStatusCall:)]){
      NSRange  marange = [self.entity.mark rangeOfString:array[1]];
        marange.length = marange.length-1;
        marange.location = marange.location+1;
        [self.delegate orderStatusCall:array[1]];
    }
}

#pragma mark =====================================================  property package
-(void)setEntity:(MOrderStatus *)entity{
    if(entity){
        _entity = entity;
        self.labelStatus.text = entity.name;
        self.labelCreateDate.text = entity.createDate;
      NSArray* array =   [entity.mark componentsSeparatedByString:@":"];
        if(array.count == 1){
            self.btnMark.userInteractionEnabled = NO;
            [self.btnMark setTitle:entity.mark forState:UIControlStateNormal];
        }else {
            NSString* strPhone = array[1];
            if(strPhone.length == 11  || strPhone.length == 12){
                self.btnMark.userInteractionEnabled = YES;
                NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:entity.mark];
                NSRange marange = [entity.mark rangeOfString:array[0]];
                marange.length = marange.length+1;
                [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:164/255.f green:164/255.f blue:164/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:marange];
                marange = [entity.mark rangeOfString:array[1]];
                marange.length = marange.length-1;
                marange.location = marange.location+1;
                [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:[entity.mark rangeOfString:array[1]]];
                [self.btnMark setAttributedTitle:attributeStr forState:UIControlStateNormal];
            }else{
                self.btnMark.userInteractionEnabled = NO;
                [self.btnMark setTitle:entity.mark forState:UIControlStateNormal];
            }
        }
      
        NSString* imageName = [NSString stringWithFormat:@"icon-order-status-%@",entity.status];
        [self.icon setImage:[UIImage imageNamed:imageName]];
        if([entity.status isEqualToString:@"1"]){
            self.lineTop.hidden = YES;
        }
        if([entity.status integerValue]>3){
            self.lineBottom.hidden = YES;
        }
    }
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

-(UIImageView *)lineTop{
    if(!_lineTop){
        _lineTop = [[UIImageView alloc]init];
        [_lineTop setImage:[UIImage imageNamed:@"icon-line-ver"]];
    }
    return _lineTop;
}

-(UIImageView *)lineBottom{
    if(!_lineBottom){
        _lineBottom = [[UIImageView alloc]init];
        [_lineBottom setImage:[UIImage imageNamed:@"icon-line-ver"]];
    }
    return _lineBottom;
}

-(UIView *)infoView{
    if(!_infoView){
        _infoView = [[UIView alloc]init];
    }
    return _infoView;
}

-(UIImageView *)infoBackground{
    if(!_infoBackground){
        _infoBackground = [[UIImageView alloc]init];
        [_infoBackground setImage:[UIImage imageNamed:@"icon-order-background"]];
    }
    return _infoBackground;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
    }
    return _labelStatus;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]init];
        _labelCreateDate.textColor = [UIColor colorWithRed:164/255.f green:164/255.f blue:164/255.f alpha:1.0];
        _labelCreateDate.font = [UIFont systemFontOfSize:12.f];
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
    }
    return _labelCreateDate;
}

-(UIButton *)btnMark{
    if(!_btnMark){
        _btnMark = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnMark setTitleColor:[UIColor colorWithRed:164/255.f green:164/255.f blue:164/255.f alpha:1.0] forState:UIControlStateNormal];
        _btnMark.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _btnMark.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btnMark.userInteractionEnabled = NO;
        [_btnMark addTarget:self action:@selector(callPhoneTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMark;
}

@end
