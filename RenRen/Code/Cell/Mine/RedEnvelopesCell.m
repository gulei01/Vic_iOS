//
//  RedEnvelopesCell.m
//  KYRR
//
//  Created by kyjun on 15/11/10.
//
//

#import "RedEnvelopesCell.h"


@interface RedEnvelopesCell()
@property(nonatomic,strong) UIImageView* line;
@property(nonatomic,strong) UIButton* btnLeft;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UILabel* labelDesc;
@property(nonatomic,strong) UILabel* labelMoney;
@property(nonatomic,strong) UILabel* labelDate;
@property(nonatomic,strong) UIImageView* photoIcon;

@end

@implementation RedEnvelopesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundView = [[UIView alloc]init];
        self.selectedBackgroundView = [[UIView alloc]init];
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
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self.contentView addSubview:self.line];
    
    self.btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnLeft setBackgroundImage:[UIImage imageNamed:@"icon-red-bg"] forState:UIControlStateNormal];
    [self.btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnLeft.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.btnLeft.userInteractionEnabled = NO;
    [self.contentView addSubview:self.btnLeft];
    
    self.labelName = [[UILabel alloc]init];
    self.labelName.font = [UIFont systemFontOfSize:16.f];
    [self.contentView addSubview:self.labelName];
    
    self.labelDesc = [[UILabel alloc]init];
    self.labelDesc.font = [UIFont systemFontOfSize:14.f];
    self.labelDate.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.labelDesc];
    
    self.photoIcon = [[UIImageView alloc]init];
    [self.contentView addSubview:self.photoIcon];
    
    self.labelMoney = [[UILabel alloc]init];
    self.labelMoney.font = [UIFont systemFontOfSize:25.f];
    self.labelMoney.textColor = [UIColor redColor];
    self.labelMoney.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.labelMoney];
    
    self.labelDate = [[UILabel alloc]init];
    self.labelDate.font = [UIFont systemFontOfSize:14.f];
    self.labelDate.textColor =theme_Fourm_color;
    [self.contentView addSubview:self.labelDate];
}

-(void)layoutConstraints{
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnLeft.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDesc.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelMoney.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.btnLeft addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.f]];
    [self.btnLeft addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLeft attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:85.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLeft attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnLeft attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem: self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/3]];
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnLeft attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelDesc addConstraint:[NSLayoutConstraint constraintWithItem: self.labelDesc attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/3]];
    [self.labelDesc addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnLeft attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelMoney addConstraint:[NSLayoutConstraint constraintWithItem: self.labelMoney attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/3]];
    [self.labelMoney addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMoney attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMoney attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelMoney attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDate attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelDate attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnLeft attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.photoIcon addConstraint:[NSLayoutConstraint constraintWithItem: self.photoIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self.photoIcon addConstraint:[NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.line attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.photoIcon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f]];
}


-(void)setEntity:(MRedEnvelopes *)entity{
    if(entity){
        _entity = entity;
       
        [self.btnLeft setTitle:@"" forState:UIControlStateNormal];
        
        NSString*  str = [NSString stringWithFormat:@"%@",entity.name];
        
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[str rangeOfString:Localized(@"All_txt")]];
        self.labelName.attributedText = attributeStr;
        self.labelDesc.text = entity.desc;
        self.labelMoney.text = [NSString stringWithFormat:@"$%.2f",[entity.money floatValue]];
        self.labelDate.text = [NSString stringWithFormat:@"%@ - %@",entity.beginDate,entity.endDate];
        if([entity.status integerValue]==0){
            self.photoIcon.hidden = YES;
        }else if ([entity.status integerValue]==2){
             [self.photoIcon setImage:[UIImage imageNamed:@"icon-red-useed"]];
        }else{
             [self.photoIcon setImage:[UIImage imageNamed:@"icon-red-expired"]];
        }
        
    }
}
@end
