//
//  BuyNowInfoHeader.h
//  DTCoreText
//
//  Created by kyjun on 16/6/14.
//  Copyright © 2016年 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DTCoreText/DTCoreText.h>
#import "MBuyNow.h"

@interface BuyNowInfoHeader : UIViewController<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>
@property(nonatomic,strong) DTAttributedTextView *contentView;

-(void)loadData:(MBuyNow*)entity complete:(void(^)(CGSize size))complete;

@end
