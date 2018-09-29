//
//  GenerateOrderCell.m
//  KYRR
//
//  Created by kyjun on 15/11/5.
//
//

#import "GenerateOrderCell.h"


@interface GenerateOrderCell ()

@property(nonatomic,strong)UILabel* labelName;
@property(nonatomic,strong) UILabel* labelCount;
@property(nonatomic,strong) UILabel* labelPrice;

@end

@implementation GenerateOrderCell

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

-(void)layoutUI{
    self.labelName = [[UILabel alloc]init];
    self.labelName.textAlignment = NSTextAlignmentLeft;
    self.labelName.font = [UIFont systemFontOfSize:14.f];
    self.labelName.numberOfLines = 0;
    [self.contentView addSubview:self.labelName];
    
    self.labelCount = [[UILabel alloc]init];
    self.labelCount.textAlignment = NSTextAlignmentLeft;
    self.labelCount.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelCount];
    
    self.labelPrice = [[UILabel alloc]init];
    self.labelPrice.textAlignment = NSTextAlignmentRight;
    self.labelPrice.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:self.labelPrice];
}

-(void)layoutConstraints{
    self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelCount.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.labelName addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH*3/5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    
    [self.labelCount addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelCount attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelName attribute:NSLayoutAttributeRight multiplier:1.0 constant:10.f]];
    
    [self.labelPrice addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCREEN_WIDTH/5]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-10.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:5.f]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]];
    
     }

-(void)setEntity:(MGoods *)entity{
    if(entity){
        _entity = entity;
        self.labelName.text = entity.goodsName;
        self.labelCount.text = [NSString stringWithFormat:@"x%@",entity.quantity];
        self.labelPrice.text = [NSString stringWithFormat:@"$%.2f",[entity.price floatValue]];
    }
}

-(void)setItemWithDict:(NSDictionary *)item{
    self.labelName.text = [item objectForKey:@"fname"];
    self.labelCount.text = [NSString stringWithFormat:@"x%@",[item objectForKey:@"stock"]];
    self.labelPrice.text = [NSString stringWithFormat:@"$%.2f",[[item objectForKey:@"price"] floatValue]];
}

@end
