//
//  GuidanceView.m
//  XiangYangWuXian
//
//  Created by Cocoa on 14-4-8.
//  Copyright (c) 2014年 LongYu coltd By Robin. All rights reserved.
//

#import "GuidanceView.h"
#import "HeaderConstant.h"
#import "HeaderTheme.h"

@implementation GuidanceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:SCREEN];
    if (self) {
        
    }
    return self;
}

- (id)initWithImages:(NSArray *)images
      andFinishBlock:(GuidanceViewFinishBlock)finishBlock
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        
        self.images = [images copy];
        
        self._finishBlock = finishBlock;
        
        [self drawViews];
    }
    return self;
}


- (void)drawViews
{
    self.ContentScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.ContentScrollView.showsHorizontalScrollIndicator = NO;
    self.ContentScrollView.showsVerticalScrollIndicator = NO;
    self.ContentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.images.count, SCREEN_HEIGHT);
    self.ContentScrollView.bounces = NO;
    self.ContentScrollView.delegate = self;
    self.ContentScrollView.pagingEnabled = YES;
    
    [self addSubview:self.ContentScrollView];
    
    for (int i = 0; i<self.images.count; i++) {
        CGRect rect = self.frame;
        rect.origin.x = i*SCREEN_WIDTH;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:rect];
        image.image = [UIImage imageNamed:(self.images[i])];
        [self.ContentScrollView addSubview:image];
        
        
        if (i==self.images.count-1) {
            image.userInteractionEnabled = YES;
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.backgroundColor = [UIColor clearColor];
//            CGRect rect = CGRectMake(SCREEN_WIDTH/2-140/2, SCREEN_HEIGHT/5*4+SCREEN_HEIGHT/70, 140, 44);
//            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [button setTitle:@"立即体验" forState:UIControlStateNormal];
//            
//            button.layer.masksToBounds=YES;
//            button.layer.cornerRadius=10.f;
//            button.layer.borderColor=[UIColor whiteColor].CGColor;
//            button.layer.borderWidth=1.0f;
//            button.frame = rect;
//            [button addTarget:self action:@selector(showRootView:) forControlEvents:UIControlEventTouchUpInside];
//            [image addSubview:button];
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [image addGestureRecognizer:singleTap];
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)sender {

    self._finishBlock(self);
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGuidanceViewFinished object:nil];
    //移除
    [self remove];

}

- (void)showRootView:(id)sender
{
    self._finishBlock(self);
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationGuidanceViewFinished object:nil];
    //移除
    [self remove];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>=scrollView.contentSize.width) {
        self._finishBlock(self);
    }
}

- (void)showInView:(UIView *)view
{
    if (view) {
        [view addSubview:self];
    }
}

- (void)remove
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.3;
    } completion:^(BOOL iscom){
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
