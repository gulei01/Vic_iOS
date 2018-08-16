//
//  RandomSection.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/5.
//
//

#import "RandomSection.h"

@interface RandomSection ()

@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation RandomSection

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.labelTitle];
        NSArray* formats = @[ @"H:|-10-[labelTitle]-0-|", @"V:|-0-[labelTitle]-0-|"];
        NSDictionary* metrics = @{};
        NSDictionary* views = @{ @"labelTitle":self.labelTitle};
        for (NSString *format in formats) {
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }
    }
    return self;
    
}

-(void)setItem:(NSDictionary *)item{
    if(item){
        _item = item;
        NSArray* empty = [[item objectForKey:@"prompt"] componentsSeparatedByString: @","];
        NSString* str =  [NSString stringWithFormat: @"%@.%@",[empty firstObject],[empty lastObject]];
        NSMutableAttributedString* attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.f]} range:[str rangeOfString:[empty firstObject]]];
        [attributeStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:[str rangeOfString:[empty lastObject]]];
        self.labelTitle.attributedText = attributeStr;
        NSInteger type = [[item objectForKey: @"business_type"] integerValue];
        if(type == 1){
            
        }else if (type == 2){
            _labelTitle.textColor = [UIColor colorWithRed:83/255.f green:134/255.f blue:215/255.f alpha:1.f];
        }else{
            _labelTitle.textColor = theme_navigation_color;
        }
    }
}

#pragma mark =====================================================  property package
-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = [UIColor redColor];
        _labelTitle.font = [UIFont systemFontOfSize:20.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

@end
