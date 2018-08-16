//
//  GoodsHeaderDelegate.h
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import <Foundation/Foundation.h>

@protocol GoodsHeaderDelegate <NSObject>

@optional
-(void)didSelectSotre:(id)sender;
-(void)didSelectInfo:(id)sender;
-(void)addShopCar:(id)sender;

@end
