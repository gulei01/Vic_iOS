//
//  MyTuanInfoFooter.m
//  KYRR
//
//  Created by kuyuZJ on 16/6/29.
//
//

#import "MyTuanInfoFooter.h"
#import "TuanRuleInfo.h"
#import <SVWebViewController/SVWebViewController.h>

@interface MyTuanInfoFooter ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) TuanRuleInfo* btnInfo;
@property(nonatomic,copy) NSString* url;

@end

@implementation MyTuanInfoFooter

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self layoutUI];
        [self layoutConstraints];
    }
    return self;
}

#pragma mark =====================================================  user interface layout
-(void)layoutUI{
    [self addSubview:self.btnInfo];
}
-(void)layoutConstraints{
    self.btnInfo.translatesAutoresizingMaskIntoConstraints = NO;

    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.f],
                           [NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.f],
                           [NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f],
                           [NSLayoutConstraint constraintWithItem:self.btnInfo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.f],
                           ]];
}


#pragma mark =====================================================  SEL
-(void)tuanViewTouch:(UITapGestureRecognizer *)gestureRecognizer{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tuanInfoRule:)]){
        [self.delegate tuanInfoRule:nil];
    }
}

#pragma mark =====================================================  property package

-(TuanRuleInfo *)btnInfo{
    if(!_btnInfo){
        _btnInfo = [[TuanRuleInfo alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90.f)];
        _btnInfo.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tuanViewTouch:)];
        [_btnInfo addGestureRecognizer:singleTap];
    }
    return _btnInfo;
}


@end
