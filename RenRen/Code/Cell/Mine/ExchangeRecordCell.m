//
//  ExchangeRecordCell.m
//  KYRR
//
//  Created by kyjun on 16/5/10.
//
//

#import "ExchangeRecordCell.h"

@interface ExchangeRecordCell ()

@property(nonatomic,strong) UIImageView* imagePhoto;
@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UILabel* labelStatus;
@property(nonatomic,strong) UIImageView* line;

@end

@implementation ExchangeRecordCell

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


#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self.contentView addSubview:self.imagePhoto];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelCreateDate];
    [self.contentView addSubview:self.labelStatus];
    [self.contentView addSubview:self.line];
}

-(void)layoutConstraints{
    self.imagePhoto.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelStatus.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.imagePhoto addConstraint:[NSLayoutConstraint constraintWithItem:self.imagePhoto attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.imagePhoto addConstraint:[NSLayoutConstraint constraintWithItem:self.imagePhoto attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imagePhoto attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.imagePhoto attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5.f]];
    
    [self.labelStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.labelStatus addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelStatus attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelStatus attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imagePhoto attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelTitle attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelStatus attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.labelCreateDate addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imagePhoto attribute:NSLayoutAttributeRight multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.labelStatus attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint  constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}

#pragma mark =====================================================  property package
-(void)setEntity:(MPointExchange *)entity{
    if(entity){
        _entity = entity;
        
        [self.imagePhoto sd_setImageWithURL:[NSURL URLWithString:entity.defaultImg] placeholderImage:[UIImage imageNamed:@"Icon-60"]];
        self.labelTitle.text = entity.goodsName;
        self.labelCreateDate.text = [NSString stringWithFormat: @"兑换时间:%@",entity.createDate];
        if([entity.status integerValue] == 1){
            self.labelStatus.text = @"待审核";
            self.labelStatus.backgroundColor = [UIColor grayColor];
            self.labelStatus.textColor = [UIColor whiteColor];
        }else if ([entity.status integerValue] == 2){
            self.labelStatus.text = @"发货中";
            self.labelStatus.backgroundColor = theme_navigation_color;
            self.labelStatus.textColor = [UIColor whiteColor];
        }else if ([entity.status integerValue] == 3){
            self.labelStatus.text = @"未通过";
            self.labelStatus.backgroundColor = [UIColor grayColor];
            self.labelStatus.textColor = [UIColor whiteColor];
        }else{
            self.labelStatus.text = @"已领取";
            self.labelStatus.backgroundColor = [UIColor whiteColor];
            self.labelStatus.textColor = theme_navigation_color;
        }
    }
}

-(UIImageView *)imagePhoto{
    if(!_imagePhoto){
        _imagePhoto = [[UIImageView alloc]init];
    }
    return _imagePhoto;
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.font = [UIFont systemFontOfSize:17.f];
    }
    return _labelTitle;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]init];
        _labelCreateDate.font = [UIFont systemFontOfSize:14.f];
        _labelCreateDate.textColor = [UIColor colorWithRed:122/255.f green:122/255.f blue:122/255.f alpha:1.0];
    }
    return _labelCreateDate;
}

-(UILabel *)labelStatus{
    if(!_labelStatus){
        _labelStatus = [[UILabel alloc]init];
        _labelStatus.font = [UIFont systemFontOfSize:14.f];
        _labelStatus.textAlignment = NSTextAlignmentCenter;
    }
    return _labelStatus;
}

-(UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]init];
        _line.backgroundColor = theme_line_color;
    }
    return _line;
}


@end
