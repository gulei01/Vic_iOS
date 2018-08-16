//
//  SilderScrollView.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/9.
//
//

#import "SilderScrollView.h"

@implementation SilderScrollView
-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
    if (self.ignoreSliders) {
        if ([view isKindOfClass:[UISlider class]] || [view isKindOfClass:[UISwitch class]]) {
            return NO;
        }
        else {
            return YES;
        }
    }
    
    return [super touchesShouldCancelInContentView:view];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event] ;
    if ([result isKindOfClass:[UISlider class]] || [result isKindOfClass:[UISwitch class]])  {
        self.scrollEnabled = NO ;
    }
    else{
        self.scrollEnabled = YES ;
    }
    return result ;
}


@end


