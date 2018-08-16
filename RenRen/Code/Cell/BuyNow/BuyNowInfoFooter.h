//
//  BuyNowInfoFooter.h
//  KYRR
//
//  Created by kyjun on 16/6/22.
//
//

#import <UIKit/UIKit.h>
#import <DTCoreText/DTCoreText.h>
#import <DTCoreText/DTWebVideoView.h>

@interface BuyNowInfoFooter : UIViewController<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

@property(nonatomic,strong) DTAttributedTextView* contentView;

-(void)loadData:(MBuyNow*)entity array:(NSMutableArray*)array complete:(void(^)(CGSize size))complete;

@end
