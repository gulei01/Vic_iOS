//
//  RandomDeliverHelp.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/22.
//
//

#import <UIKit/UIKit.h>

@protocol RandomDeliverHelpDelegate <NSObject>

@optional
-(void)closeDeliveryHelp:(id)sender;

@end

@interface RandomDeliverHelp : UIView

@property(nonatomic,strong) NSDictionary* item;

@property(nonatomic,weak) id<RandomDeliverHelpDelegate> delegate;

@end
