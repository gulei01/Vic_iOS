//
//  NewHomeCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import "NewHomeCell.h"

@interface NewHomeCell ()

@property(nonatomic,strong) UIImageView* photo;
@property(nonatomic,strong) UILabel* labelPrice;

@end

@implementation NewHomeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.photo];
    [self addSubview:self.labelPrice];
    
    NSArray* formats = @[ @"H:[photo(==60)]",@"H:|-defEdge-[labelPrice]-defEdge-|",
                           @"V:|-defEdge-[photo(==60)]-defEdge-[labelPrice]-5-|"];
    NSDictionary* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10),};
    NSDictionary* views = @{ @"photo":self.photo, @"labelPrice":self.labelPrice};
    
    [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog( @" %@ %@",[self class],obj);
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }];
    NSLayoutConstraint* constraints = [NSLayoutConstraint constraintWithItem:self.photo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self addConstraint:constraints];
}

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        [self.photo sd_setImageWithURL:[NSURL URLWithString:[item objectForKey: @"default_image"]] placeholderImage:[UIImage imageNamed:kDefaultGoodsImage]];
        self.labelPrice.text = [NSString stringWithFormat: @"￥%@",[item objectForKey: @"price"]];
    }
}

#pragma mark =====================================================  propertyp package
-(UIImageView *)photo{
    if(!_photo){
        _photo = [[UIImageView alloc]init];
        _photo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _photo;
}

-(UILabel *)labelPrice{
    if(!_labelPrice){
        _labelPrice = [[UILabel alloc]init];
        _labelPrice.textColor = [UIColor redColor];
        _labelPrice.font = [UIFont systemFontOfSize:12.f];
        _labelPrice.text =  @"￥0.99";
        _labelPrice.textAlignment = NSTextAlignmentCenter;
        _labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelPrice;
}

@end
