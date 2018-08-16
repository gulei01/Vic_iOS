//
//  ActivityPart.h
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import <UIKit/UIKit.h>
#import "MBuyNow.h"
#import "MPresale.h"

@interface ActivityPart : UIView

-(void)loadData:(MBuyNow *)buyNow fightGroup:(MFightGroup *)fightGroup;

@end
