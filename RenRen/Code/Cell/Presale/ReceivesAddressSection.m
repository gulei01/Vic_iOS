//
//  ReceivesAddressSection.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import "ReceivesAddressSection.h"

@interface ReceivesAddressSection ()

@property(nonatomic,strong) UILabel* labelTitle;

@end

@implementation ReceivesAddressSection

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.labelTitle];
        CALayer* border = [[CALayer alloc]init];
        border.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        border.backgroundColor =[UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0].CGColor;
        [self.layer addSublayer:border];
        for (NSString* format in @[@"H:|-leftEdge-[labelTitle]-defEdge-|", @"V:|-topEdge-[labelTitle]-defEdge-|"]) {
             //NSLog( @"%@ %@",[self class],format);
            NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:@{ @"defEdge":@(0), @"topEdge":@(10), @"leftEdge":@(10)} views:@{ @"labelTitle":self.labelTitle}];
            [self addConstraints:constraints];
        }
    }
    return self;
}

-(void)setTitleVal:(NSString *)val{
    if(val){
        self.labelTitle.text = val;
    }
}

#pragma mark =====================================================  property package
-(UILabel *)labelTitle{
    if(!_labelTitle){
        _labelTitle = [[UILabel alloc]init];
        _labelTitle.textColor = [UIColor grayColor];
        _labelTitle.font = [UIFont systemFontOfSize:14.f];
        _labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _labelTitle;
}

@end
