//
//  StoreListFooter.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/26.
//
//

#import "StoreListFooter.h"

@interface StoreListFooter ()

@property(nonatomic,strong) UILabel* labelFooter;
@end

@implementation StoreListFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.labelFooter];
        NSArray* formats = @[@"H:|-leftEdge-[labelFooter]-leftEdge-|", @"V:|-defEdge-[labelFooter]-defEdge-|"];
        NSDictionary* metrics = @{ @"defEdge":@(10), @"leftEdge":@(10)};
        NSDictionary* views = @{ @"labelFooter":self.labelFooter};
        [formats enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //NSLog( @"%@ %@",[self class],obj);
            NSArray* constraints = [NSLayoutConstraint  constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
            [self addConstraints:constraints];
        }];
    }
    return self;
}

-(UILabel *)labelFooter{
    if(!_labelFooter){
        _labelFooter = [[UILabel alloc]init];
        _labelFooter.text =  @"更多商户正在入驻，敬请期待!";
        _labelFooter.textAlignment = NSTextAlignmentCenter;
        _labelFooter.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelFooter;
}

@end
