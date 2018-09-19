//
//  AddressCell.m
//  KYRR
//
//  Created by kyjun on 15/11/3.
//
//

#import "AddressCell.h"


@interface AddressCell()

@property(nonatomic,strong) UIButton* btnDefault;
@property(nonatomic,strong) UILabel* labelNamePhone;
@property(nonatomic,strong) UILabel* labelAddress;
@property(nonatomic,strong) UIButton* btnEdit;
@property(nonatomic,strong) UIButton* btnDel;
@property(nonatomic,strong) UIImageView* line;


@end

@implementation AddressCell

- (void)awakeFromNib {
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

#pragma mark =====================================================  试图布局
-(void)layoutUI{
    self.btnDefault = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnDefault setImage:[UIImage imageNamed:@"icon-address-default"] forState:UIControlStateNormal];
    [self.btnDefault setImage:[UIImage imageNamed:@"icon-address-enter"] forState:UIControlStateSelected];
    [self.btnDefault addTarget:self action:@selector(btnDefaultTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnDefault];
    
    
    self.labelNamePhone = [[UILabel alloc]init];
     self.labelNamePhone.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelNamePhone];
    
    self.labelAddress = [[UILabel alloc]init];
    self.labelAddress.numberOfLines=2;
    self.labelAddress.lineBreakMode = NSLineBreakByCharWrapping;
    self.labelAddress.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelAddress];
    
    self.btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnEdit setImage:[UIImage imageNamed:@"icon-edit"] forState:UIControlStateNormal];
    [self.btnEdit addTarget:self action:@selector(btnEditTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnEdit];
    
    self.btnDel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnDel setImage:[UIImage imageNamed:@"icon-del"] forState:UIControlStateNormal];
    [self.btnDel addTarget:self action:@selector(btnDelTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.btnDel];
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self.contentView addSubview:self.line];
    
}
-(void)layoutConstraints{
    self.btnDefault.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelNamePhone.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnEdit.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnDel.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.btnDefault addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.btnDefault addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDefault attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelNamePhone addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.labelNamePhone addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnDefault attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-100]];
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelNamePhone attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.btnDefault attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.btnDel addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.btnDel addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnDel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.btnEdit addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.btnEdit addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.btnDel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}

-(IBAction)btnDefaultTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(setDefaultAddress:)]){
        [self.delegate setDefaultAddress:self.entity];
    }
}

-(IBAction)btnEditTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(editAddress:)]){
        [self.delegate editAddress:self.entity];
    }
}

-(IBAction)btnDelTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(delAddress:)]){
        [self.delegate delAddress:self.entity];
    }
}

-(void)disabledDelegate{
    self.btnEdit.hidden = YES;
    self.btnDel.hidden = YES;
}

-(void)setEntity:(MAddress *)entity{
    if(entity){
        _entity = entity;
        self.labelNamePhone.text = [NSString stringWithFormat:@"%@ %@",entity.userName,entity.phoneNum];
        self.labelAddress.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@,%@",[MSingle shareAuhtorization].location.cityName,entity.areaName,entity.zoneName,entity.address,entity.mapLocation,entity.mapNumber];
        self.btnDefault.selected =entity.isDefault;
        self.btnDefault.tag = [entity.rowID integerValue];
        self.btnEdit.tag = [entity.rowID integerValue];
        self.btnDel.tag = [entity.rowID integerValue];
    }
}


@end
