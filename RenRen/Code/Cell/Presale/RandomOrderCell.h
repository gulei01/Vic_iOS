//
//  RandomOrderCell.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/18.
//
//

#import <UIKit/UIKit.h>

@protocol RandomOrderCellDelegate <NSObject>

@optional

-(void)fromOrderPay:(NSDictionary*)item;

@end

@interface RandomOrderCell : UICollectionViewCell

@property(nonatomic,strong) NSDictionary* item;

@property(nonatomic,weak) id<RandomOrderCellDelegate> delegate;

@end
