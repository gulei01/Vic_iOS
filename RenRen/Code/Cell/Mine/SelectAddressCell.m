//
//  SelectAddressCell.m
//  KYRR
//
//  Created by kyjun on 15/11/14.
//
//

#import "SelectAddressCell.h"

@interface SelectAddressCell()

@property(nonatomic,strong) UILabel* labelNamePhone;
@property(nonatomic,strong) UILabel* labelAddress;
@property(nonatomic,strong) UIButton* btnEdit;
@property(nonatomic,strong) UIImageView* line;

@end

@implementation SelectAddressCell


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
    
   
    
    self.line = [[UIImageView alloc]init];
    self.line.backgroundColor = theme_line_color;
    [self.contentView addSubview:self.line];
    
}
-(void)layoutConstraints{
 
    self.labelNamePhone.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelAddress.translatesAutoresizingMaskIntoConstraints = NO;
    self.btnEdit.translatesAutoresizingMaskIntoConstraints = NO;
 
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.labelNamePhone addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/2]];
    [self.labelNamePhone addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNamePhone attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15.f]];
    
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH-100]];
    [self.labelAddress addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelNamePhone attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelAddress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15.f]];
    
    
    [self.btnEdit addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.btnEdit addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnEdit attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-15.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}



-(IBAction)btnEditTouch:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(editAddress:)]){
        [self.delegate editAddress:self.entity];
    }
}
 
-(void)setEntity:(MAddress *)entity{
    if(entity){
        _entity = entity;
        self.labelNamePhone.text = [NSString stringWithFormat:@"%@ %@",entity.userName,entity.phoneNum];
        self.labelAddress.text = [NSString stringWithFormat:@"%@ %@ %@ %@",[MSingle shareAuhtorization].location.cityName,entity.areaName,entity.zoneName,entity.address];
      
        self.btnEdit.tag = [entity.rowID integerValue];
        
    }
}


@end
