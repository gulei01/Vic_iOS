//
//  FightGroupItemFooter.h
//  KYRR
//
//  Created by kyjun on 16/6/17.
//
//

#import <UIKit/UIKit.h>
#import <DTCoreText/DTCoreText.h>
#import <DTCoreText/DTWebVideoView.h>

@interface FightGroupItemFooter : UIViewController<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

@property(nonatomic,strong) DTAttributedTextView* contentView;

-(void)loadData:(MFightGroup*)entity array:(NSMutableArray*)array complete:(void(^)(CGSize size))complete;

@end
