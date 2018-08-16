//
//  RandomSaleFooter.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import <UIKit/UIKit.h>

@protocol RandomSaleInfoFooterDelegate <NSObject>

@optional
-(void)addWeight;
-(void)subWeight;
-(void)changePrice;

@end

@interface RandomSaleInfoFooter : UICollectionReusableView

@property(nonatomic,weak) id<RandomSaleInfoFooterDelegate> delegate;

@property(nonatomic,strong) UITextField* txtMoney;

@end
