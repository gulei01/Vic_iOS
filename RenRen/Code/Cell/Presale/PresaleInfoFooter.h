//
//  PresaleInfoFooter.h
//  KYRR
//
//  Created by kuyuZJ on 16/6/24.
//
//

#import <UIKit/UIKit.h>
#import <DTCoreText/DTCoreText.h>
#import <DTCoreText/DTWebVideoView.h>

@interface PresaleInfoFooter : UIViewController<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

@property(nonatomic,strong) DTAttributedTextView* contentView;

-(void)loadData:(MPresale*)entity array:(NSMutableArray*)array complete:(void(^)(CGSize size))complete;

@end
