
//
//  RandomBuyCell.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/5.
//
//

#import "RandomBuyCell.h"

@interface RandomBuyCell ()

@property(nonatomic,strong) UILabel* labelType;
@property(nonatomic,strong) UIImageView* icon;

@end

@implementation RandomBuyCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

-(void)layoutUI{
    [self addSubview:self.labelType];
    [self addSubview:self.icon];
}

-(void)layoutConstraints{
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:55.f]];
    [self.icon addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:55.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-5.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelType attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelType attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelType attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.labelType attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f]];
}

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        NSString* str =  [NSString stringWithFormat: @"%@\n%@",[item objectForKey: @"title"],[item objectForKey: @"subtitle"]];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.f]} range:[str rangeOfString:[item objectForKey: @"title"]]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor grayColor]} range:[str rangeOfString:[item objectForKey: @"subtitle"]]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5.f];//调整行间距
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        self.labelType.attributedText = attributeStr;
        [self.icon sd_setImageWithURL:[NSURL URLWithString: [item objectForKey: @"image"]]];
    }
}

#pragma mark =====================================================  property package
-(UILabel *)labelType{
    if(!_labelType){
        _labelType = [[UILabel alloc]init];
        _labelType.numberOfLines = 0;
        _labelType.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelType;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        _icon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _icon;
}


@end

#pragma mark =====================================================  RandomBuy2Cell

@interface RandomBuy2Cell ()
@property(nonatomic,strong) UILabel* labelType;
@property(nonatomic,strong) UIImageView* icon;
@end

@implementation RandomBuy2Cell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

-(void)layoutUI{
    [self addSubview:self.labelType];
    [self addSubview:self.icon];
}

-(void)layoutConstraints{
    NSInteger titleHeight = 40,iconSize=0;
    CGSize currentSize = self.frame.size;
    iconSize = currentSize.height-20-titleHeight;
    
    NSArray* formats = @[
                         @"H:|-leftEdge-[labelType]-leftEdge-|",
                         @"H:[icon(==iconSize)]", @"V:|-defEdge-[labelType(==titleHeight)]-topEdge-[icon(==iconSize)]",
                         ];
    NSDictionary* metrics = @{
                               @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10),
                                @"titleHeight":@(titleHeight), @"iconSize":@(iconSize)
                              };
    NSDictionary* views = @{
                            @"labelType":self.labelType, @"icon":self.icon
                            };
    
    for (NSString* format in formats) {
        NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
        [self addConstraints:constraints];
    }
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f]];
    
}

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        NSString* str =  [NSString stringWithFormat: @"%@\n%@",[item objectForKey: @"title"],[item objectForKey: @"subtitle"]];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f]} range:[str rangeOfString:[item objectForKey: @"title"]]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSForegroundColorAttributeName:[UIColor grayColor]} range:[str rangeOfString:[item objectForKey: @"subtitle"]]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5.f];//调整行间距
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        self.labelType.attributedText = attributeStr;
        [self.icon sd_setImageWithURL:[NSURL URLWithString: [item objectForKey: @"image"]]];
    }
}

#pragma mark =====================================================  property package
-(UILabel *)labelType{
    if(!_labelType){
        _labelType = [[UILabel alloc]init];
        _labelType.numberOfLines = 0;
        _labelType.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelType;
}

-(UIImageView *)icon{
    if(!_icon){
        _icon = [[UIImageView alloc]init];
        _icon.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _icon;
}

@end