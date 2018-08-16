//
//  SubCategoryCell.m
//  KYRR
//
//  Created by kyjun on 15/10/29.
//
//

#import "SubCategoryCell.h"

@interface SubCategoryCell()
/**
 *  分类名称
 */
@property(nonatomic,strong) UILabel* labelName;
/**
 *  当前分类下商品数量
 */
@property(nonatomic,strong) UILabel* labelNum;

@end

@implementation SubCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = theme_dropdown_bg_color;
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
    self.labelName = [[UILabel alloc]init];
    [self.contentView addSubview:self.labelName];
    
    self.labelNum = [[UILabel alloc]init];
    self.labelNum.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.labelNum];
}

-(void)layoutConstraints{
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelNum.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.labelNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.labelNum addConstraint:[NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/3]];
    
    
}


-(void)setEntity:(MSubType *)entity{
    if(entity){
        _entity = entity;
        self.labelName.text = entity.categoryName;
       /* CGFloat num = [entity.goodsNum integerValue];
        if(num>0)
            self.labelNum.hidden = NO;
        else
            self.labelNum.hidden = YES;*/
        self.labelNum.text = entity.goodsNum;
        
    }
}

@end
