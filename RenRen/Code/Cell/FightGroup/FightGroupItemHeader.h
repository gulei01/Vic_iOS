//
//  FightGroupItemHeader.h
//  KYRR
//
//  Created by kyjun on 16/6/17.
//
//

#import <UIKit/UIKit.h>

@interface FightGroupItemHeader : UIViewController

-(void)loadData:(MFightGroupInfo*)entity complete:(void(^)(CGSize size))complete;
@end
