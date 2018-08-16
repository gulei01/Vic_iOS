//
//  RandomBuyCar.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/8.
//
//

#import <UIKit/UIKit.h>

@protocol RandomBuyCarDelegate <NSObject>

@optional
-(void)submitRandomCar;

@end

@interface RandomBuyCar : UIViewController

-(void)setDeliveryPrice:(NSInteger)price andTip:(NSInteger)tip;

-(void)setVouchers:(NSInteger)price;

@property(nonatomic,weak) id<RandomBuyCarDelegate> delegate;
@end
