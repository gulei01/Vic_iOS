//
//  GuidanceView.h
//  XiangYangWuXian
//
//  Created by Cocoa on 14-4-8.
//  Copyright (c) 2014年 LongYu coltd By Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuidanceView;
typedef void (^GuidanceViewFinishBlock)(GuidanceView*);

@interface GuidanceView : UIView<UIScrollViewDelegate>
//Content properties
@property (nonatomic, retain) UIScrollView *ContentScrollView;

@property (nonatomic, copy) GuidanceViewFinishBlock _finishBlock;

@property (nonatomic, strong) NSArray *images;

- (id)initWithImages:(NSArray *)images
      andFinishBlock:(GuidanceViewFinishBlock)finishBlock;

- (void)showInView:(UIView *)view;

@end
