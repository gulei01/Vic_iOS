//
//  OrderConfirmCell.m
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import "OrderConfirmCell.h"

@interface OrderConfirmCell ()

@property(nonatomic,strong)UILabel* labelName;
@property(nonatomic,strong) UILabel* labelCount;
@property(nonatomic,strong) UILabel* labelPrice;

@end

@implementation OrderConfirmCell

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
    [self.contentView addSubview:self.labelName];
    [self.contentView addSubview:self.labelCount];
    [self.contentView addSubview:self.labelPrice];
}

-(void)layoutConstraints{
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCount.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*3/5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelName attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
}

-(void)loadData:(NSString *)goodName price:(NSString *)price count:(NSString *)count{
    self.labelName.text = goodName;
    self.labelCount.text = [NSString stringWithFormat:@"x%@",count];
    self.labelPrice.text = [NSString stringWithFormat:@"￥%@",price];
}

#pragma mark =====================================================  peroperty package
-(UILabel *)labelName{
    if(!_labelName){
        _labelName = [[UILabel alloc]init];
        _labelName.textAlignment = NSTextAlignmentLeft;
        _labelName.font = [UIFont systemFontOfSize:14.f];
        _labelName.numberOfLines =0;
        _labelName.textColor = [UIColor colorWithRed:68/255.f green:66/255.f blue:67/255.f alpha:1.0];
        _labelName.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _labelName;
}

-(UILabel *)labelCount{
    if(!_labelCount){
        _labelCount = [[UILabel alloc]init];
        _labelCount.textAlignment = NSTextAlignmentLeft;
        _labelCount.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelCount;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textAlignment = NSTextAlignmentRight;
        _labelPrice.font = [UIFont systemFontOfSize:14.f];
    }
    return _labelPrice;
}



@end
