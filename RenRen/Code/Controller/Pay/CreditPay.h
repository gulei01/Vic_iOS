//
//  CreditPay.h
//  RenRen
//
//  Created by Garfunkel on 2018/10/17.
//

#import <UIKit/UIKit.h>

@interface CreditPay : UIViewController
@property(nonatomic,assign) double tip_price;
@property(nonatomic,assign) double total_price;
@property(nonatomic,copy) NSString* order_id;
@property(nonatomic,copy) NSString* order_type;
@end
