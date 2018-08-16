//
//  OrderConfirm.h
//  KYRR
//
//  Created by kyjun on 16/6/18.
//
//

#import <UIKit/UIKit.h>

/**
 *  订单确认界面 - 预售、拼团 没有购物车
 */
@interface OrderConfirm : UITableViewController 

-(instancetype)initWithItem:(MCheckOrder*)entity;




@end
