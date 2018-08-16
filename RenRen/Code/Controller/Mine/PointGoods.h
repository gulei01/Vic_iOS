//
//  PointGoods.h
//  KYRR
//
//  Created by kyjun on 16/5/10.
//
//

#import <UIKit/UIKit.h>
#import <DTCoreText/DTCoreText.h>
#import <DTCoreText/DTWebVideoView.h>

@interface PointGoods :UITableViewController<DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate>

-(instancetype)initWithRowID:(NSString*)rowID andPoints:(NSString*)points;

@end
