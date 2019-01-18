//
//  OrderCell.h
//  KYRR
//
//  Created by kyjun on 15/11/7.
//
//

#import <UIKit/UIKit.h>
#import "MOrder.h"

@class OrderCell;

@protocol OrderCellDelegate <NSObject>

@optional
-(void)orderGoPay:(MOrder*)item;
-(void)orderCancelOrder:(MOrder*)item;
-(void)orderAddComment:(MOrder*)item;
-(void)orderDelete:(OrderCell*)tableViewCell item:(MOrder*)item;
-(void)orderTracking:(MOrder*)item;
@end

@interface OrderCell : UITableViewCell

@property(nonatomic,strong) MOrder* entity;

@property(nonatomic,weak) id<OrderCellDelegate> delegate;

@end
