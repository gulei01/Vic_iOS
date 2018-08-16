//
//  BuyNowCell.h
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import <UIKit/UIKit.h>

@protocol BuyNowCellDelegate <NSObject>

@optional
-(void)buyNowStore:(MBuyNow*)sender;
-(void)buyNowGo:(MBuyNow*)sender;

@end

@interface BuyNowCell : UITableViewCell

@property(nonatomic,strong) MBuyNow* entity;

@property(nonatomic,weak) id<BuyNowCellDelegate> delegate;

@end
