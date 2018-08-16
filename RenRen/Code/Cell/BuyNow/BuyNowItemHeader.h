//
//  BuyNowItemHeader.h
//  KYRR
//
//  Created by kyjun on 16/6/22.
//
//

#import <UIKit/UIKit.h>

@interface BuyNowItemHeader : UIViewController
-(void)loadData:(MBuyNow*)entity complete:(void(^)(CGSize size))complete;
@end
