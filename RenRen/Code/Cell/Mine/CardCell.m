//
//  CardCell.m
//  RenRen
//
//  Created by Garfunkel on 2018/10/18.
//

#import "CardCell.h"

@interface CardCell()

@property(nonatomic,strong) UIImageView* btnDefault;
@property(nonatomic,strong) UILabel* labelName;
@property(nonatomic,strong) UILabel* labelCardNum;
@property(nonatomic,strong) UIImageView* line;


@end

@implementation CardCell

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
    self.btnDefault = [[UIImageView alloc]init];
    [self.btnDefault setImage:[UIImage imageNamed:@"icon-address-default"]];
    [self.contentView addSubview:self.btnDefault];
    
    
    self.labelName = [[UILabel alloc]init];
    self.labelName.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelName];
    
    self.labelCardNum = [[UILabel alloc]init];
    self.labelCardNum.numberOfLines=2;
    self.labelCardNum.lineBreakMode = NSLineBreakByCharWrapping;
    self.labelCardNum.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelCardNum];
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self.contentView addSubview:self.line];
}

-(void)layoutConstraints{
    self.btnDefault.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCardNum.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnDefault addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.btnDefault addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-100]];
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnDefault attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelCardNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCardNum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-100]];
    [self.labelCardNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCardNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCardNum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelName attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCardNum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnDefault attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}

-(void)btnDefaultTouch{
    
}

-(void)setDict:(NSDictionary *)dict{
    if(dict){
        _dict = dict;
        NSString* is_default = [dict objectForKey:@"is_default"];
        if([is_default integerValue] == 1)
            [self.btnDefault setImage:[UIImage imageNamed:@"icon-address-enter"]];
        else
            [self.btnDefault setImage:[UIImage imageNamed:@"icon-address-default"]];
        
        NSString* name = [dict objectForKey:@"name"];
        NSString* card_num = [dict objectForKey:@"card_num"];
        
        self.labelName.text = [NSString stringWithFormat:@"%@:%@",Localized(@"CREDITHOLDER_NAME"),name];
        self.labelCardNum.text = [NSString stringWithFormat:@"%@:%@",Localized(@"CREDIT_CARD_NUM"),card_num];
    }
}

@end
