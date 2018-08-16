//
//  RandomOrderPay.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/14.
//
//

#import <UIKit/UIKit.h>

@interface RandomOrderPay : UIViewController

-(instancetype)initWithOrderID:(NSString *)orderID money:(CGFloat)money goodsName:(NSString *)goodsName fromOrder:(BOOL)fromOrder;

@end
