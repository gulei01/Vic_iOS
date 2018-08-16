//
//  OrderStatusCell.h
//  KYRR
//
//  Created by kyjun on 16/4/18.
//
//

#import <UIKit/UIKit.h>
#import "MOrderStatus.h"


@protocol OrderStatusCellDelegate <NSObject>

-(void)orderStatusCall:(NSString*)phone;

@end

@interface OrderStatusCell : UITableViewCell

@property(nonatomic,strong) MOrderStatus* entity;

@property(nonatomic,weak) id<OrderStatusCellDelegate> delegate;

@end
