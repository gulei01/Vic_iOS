//
//  CustomerCell.m
//  KYRR
//
//  Created by kyjun on 16/6/8.
//
//

#import "CustomerCell.h"

@interface CustomerCell ()

@property(nonatomic,strong) UIImageView* avatar;
@property(nonatomic,strong) UILabel* labelUserName;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UIImageView* line;

@end


@implementation CustomerCell{
    NSString* defaultImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        defaultImage = @"Icon-default-image";
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
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.labelUserName];
    [self.contentView addSubview:self.labelCreateDate];
    [self.contentView addSubview:self.line];
}

-(void)layoutConstraints{
    self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelUserName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.avatar addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelUserName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelUserName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3+40]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-1.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}


#pragma mark =====================================================  property package

-(void)setEntity:(MCustomer *)entity{
    if(entity){
        _entity = entity;
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:entity.avatar] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
        self.labelUserName.text = entity.userName;
        self.labelCreateDate.text = entity.createDate;
    }
}

-(UIImageView *)avatar{
    if(!_avatar){
        _avatar = [[UIImageView alloc]init];
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 10.f;
    }
    return _avatar;
}

-(UILabel *)labelUserName{
    if(!_labelUserName){
        _labelUserName =[[UILabel alloc]init];
        _labelUserName.textAlignment = NSTextAlignmentLeft;
        _labelUserName.textColor = [UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0];
        _labelUserName.font = [UIFont systemFontOfSize:14.f];
        _labelUserName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _labelUserName;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]init];
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
        _labelCreateDate.textColor = [UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0];
        _labelCreateDate.font= [UIFont systemFontOfSize:12.f];
    }
    return _labelCreateDate;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = theme_line_color;
    }
    return _line;
}

@end
