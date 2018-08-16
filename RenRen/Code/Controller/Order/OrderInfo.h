//
//  OrderInfo.h
//  KYRR
//
//  Created by kyjun on 16/4/18.
//
//

#import <UIKit/UIKit.h>
#import "MOrder.h"

@interface OrderInfo : UIViewController

@property(nonatomic,strong) NSString* orderID;
@property(nonatomic,strong) MOrder* entity;

@end
