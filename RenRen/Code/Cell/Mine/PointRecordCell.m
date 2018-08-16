//
//  PointRecordCell.m
//  KYRR
//
//  Created by kyjun on 16/5/10.
//
//

#import "PointRecordCell.h"

@interface PointRecordCell ()

@property(nonatomic,strong) UILabel* labelTitle;
@property(nonatomic,strong) UILabel* labelPoint;
@property(nonatomic,strong) UILabel* labelCreateDate;
@property(nonatomic,strong) UIImageView* line;

@end

@implementation PointRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self layoutUI];
        [self layoutConstratints];
    }
    return  self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark =====================================================  layoutUI
-(void)layoutUI{
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelPoint];
    [self.contentView addSubview:self.labelCreateDate];
    [self.contentView addSubview:self.line];
}

-(void)layoutConstratints{
    self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPoint.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCreateDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.labelTitle addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*2/5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelTitle attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelPoint addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPoint attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelTitle attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelPoint attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCreateDate attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1.f]];
    [self.line addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-1.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.line attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
    
}



#pragma mark =====================================================  property package

-(void)setEntity:(MPointRecord *)entity{
    if(entity){
        _entity = entity;
        NSString* str = [NSString stringWithFormat:@"%@\n%@",entity.typeName,entity.mark];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:41/255.f green:41/255.f blue:41/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:entity.typeName]];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:116/255.f green:116/255.f blue:116/255.f alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:[str rangeOfString:entity.mark]];
        self.labelTitle.attributedText = attributeStr;
        self.labelPoint.text = entity.points;
        self.labelCreateDate.text = entity.createDate;
    }
}

-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.numberOfLines = 0;
        _labelTitle.textAlignment = NSTextAlignmentLeft;
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelTitle;
}

-(UILabel *)labelPoint{
    if(!_labelPoint){
        _labelPoint = [[UILabel alloc]init];
        _labelPoint.textAlignment = NSTextAlignmentCenter;
        _labelPoint.font = [UIFont systemFontOfSize:14.f];
        _labelPoint.textColor =theme_navigation_color;
    }
    return _labelPoint;
}

-(UILabel *)labelCreateDate{
    if(!_labelCreateDate){
        _labelCreateDate = [[UILabel alloc]init];
        _labelCreateDate.textAlignment = NSTextAlignmentRight;
        _labelCreateDate.font = [UIFont systemFontOfSize:14.f];
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
