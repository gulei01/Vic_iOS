//
//  OrderDetailCell.m
//  KYRR
//
//  Created by kyjun on 16/1/13.
//
//

#import "OrderDetailCell.h"

@interface OrderDetailCell ()
@property(nonatomic,strong) UILabel* labelFoodName;
@property(nonatomic,strong) UILabel* labelNum;
@property(nonatomic,strong) UILabel* labelPrice;
@property(nonatomic,strong) UILabel* labelDesc;

@end

@implementation OrderDetailCell

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

-(void)layoutUI{
    [self.contentView addSubview:self.labelFoodName];
    [self.contentView addSubview:self.labelNum];
    [self.contentView addSubview:self.labelPrice];
    [self.contentView addSubview:self.labelDesc];
}

-(void)layoutConstraints{
    self.labelFoodName.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelNum.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelDesc.translatesAutoresizingMaskIntoConstraints = NO;
 
    CGFloat width = SCREEN_WIDTH - 10;
    
    [self.labelFoodName addConstraints:@[
                                         [NSLayoutConstraint constraintWithItem:self.labelFoodName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width*2/3],
                                         [NSLayoutConstraint constraintWithItem:self.labelFoodName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45]
                                         ]];
    [self.labelNum addConstraints:@[
                                         [NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width/6-10],
                                         [NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45]
                                         ]];
    [self.labelPrice addConstraints:@[
                                    [NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width/6+10],
                                    [NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:45]
                                    ]];
    
    [self.contentView addConstraints:@[
                                       [NSLayoutConstraint constraintWithItem:self.labelFoodName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelFoodName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelNum attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.labelFoodName attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f],
                                       [NSLayoutConstraint constraintWithItem:self.labelDesc attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10.f]
                                       ]];
    
}

#pragma mark =====================================================  Properte package

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        self.labelFoodName.text = [item objectForKey:@"fname"];
        self.labelNum.text = [NSString stringWithFormat:@"x%@",[item objectForKey:@"quantity"]];
        self.labelPrice.text = [NSString stringWithFormat:@"￥%@",[item objectForKey:@"price"]];
        self.labelDesc.text = [item objectForKey:@"spec_desc"];
    }
}

-(UILabel *)labelFoodName{
    if(!_labelFoodName){
        _labelFoodName = [[UILabel alloc]init];
        _labelFoodName.font = [UIFont systemFontOfSize:15.f];
        _labelFoodName.numberOfLines = 2;
        _labelFoodName.lineBreakMode = NSLineBreakByCharWrapping;
        _labelFoodName.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
    }
    return _labelFoodName;
}


-(UILabel *)labelNum {
    if(!_labelNum){
        _labelNum = [[UILabel alloc]init];
        _labelNum.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelNum.font = [UIFont systemFontOfSize:14.f];
        _labelNum.textAlignment = NSTextAlignmentCenter;
    }
    return _labelNum;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelPrice.font = [UIFont systemFontOfSize:14.f];
        _labelPrice.textAlignment = NSTextAlignmentRight;
    }
    return _labelPrice;
}

-(UILabel *)labelDesc{
    if(!_labelDesc){
        _labelDesc = [[UILabel alloc]init];
        _labelDesc.textColor = [UIColor colorWithRed:71/255.f green:71/255.f blue:71/255.f alpha:1.0];
        _labelDesc.font = [UIFont systemFontOfSize:13.f];
        _labelDesc.textAlignment = NSTextAlignmentLeft;
    }
    return _labelDesc;
}


@end
