//
//  HomeCategoryCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/26.
//
//

#import "HomeCategoryCell.h"

@interface HomeCategoryCell ()

@property(nonatomic,strong) UIImageView* iconCategory;
@property(nonatomic,strong) UILabel* labelCategory;

@end

@implementation HomeCategoryCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI{
    // height = 10+iconHeight+10+labelHeight
    NSInteger iconHeight = 40,labelHeight = 20;
    [self addSubview:self.iconCategory];
    [self addSubview:self.labelCategory];
    
    NSArray* formats = @[@"H:[iconCategory(==iconHeight)]",@"H:|-defEdge-[labelCategory]-defEdge-|", @"V:|-defEdge-[iconCategory(==iconHeight)][labelCategory]-5-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10), @"iconHeight":@(iconHeight), @"labelHeight":@(labelHeight)};
    NSDictionary* views = @{ @"iconCategory":self.iconCategory, @"labelCategory":self.labelCategory};
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @"%@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:self.iconCategory attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self addConstraint:constraint];
}

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        [self.iconCategory sd_setImageWithURL:[NSURL URLWithString:[item objectForKey: @"image"]]];
        self.labelCategory.text = [item objectForKey: @"title"];
    }
}

-(UIImageView *)iconCategory{
    if(!_iconCategory){
        _iconCategory = [[UIImageView alloc]init];
        _iconCategory.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconCategory;
}

-(UILabel *)labelCategory{
    if(!_labelCategory){
        _labelCategory = [[UILabel alloc]init];
        _labelCategory.textAlignment = NSTextAlignmentCenter;
        _labelCategory.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0];
        _labelCategory.font = [UIFont fontWithName: @"Arial Rounded MT Bold" size:11.f];
        _labelCategory.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelCategory;
}



@end
