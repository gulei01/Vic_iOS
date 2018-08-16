//
//  ShoppingCell.h
//  KYRR
//
//  Created by kyjun on 15/11/4.
//
//

#import <UIKit/UIKit.h>
#import "MGoods.h"
#import "MStore.h"

@protocol ShopCellDelegate <NSObject>

@optional
-(void)selectedGoods:(MGoods*)item;
-(void)addGoodsCount:(MGoods*)item;
-(void)subtractionGoodsCount:(MGoods*)item;
-(void)didSelectedGoodsTitle:(MGoods*)item store:(MStore*)store;

@end

@interface ShoppingCell : UITableViewCell

@property(nonatomic,strong) MGoods* entity;

@property(nonatomic,strong) MStore* storeItem;

@property(nonatomic,strong) UILabel* labelStock;

@property(nonatomic,weak) id<ShopCellDelegate> delegate;

@end
