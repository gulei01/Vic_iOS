//
//  PaySelect.h
//  RenRen
//
//  Created by Garfunkel on 2018/11/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaySelect : UIViewController
@property(nonatomic,assign) double tip_price;
@property(nonatomic,assign) double total_price;
@property(nonatomic,copy) NSString* order_id;
@property(nonatomic,copy) NSString* order_type;
@property(nonatomic,copy) NSString* payType;
@end

NS_ASSUME_NONNULL_END
