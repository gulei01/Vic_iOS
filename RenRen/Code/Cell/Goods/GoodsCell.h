//
//  GoodsCell.h
//  XYRR
//
//  Created by kyjun on 15/10/27.
//
//

#import <UIKit/UIKit.h>
#import "MGoods.h"
#import "GoodsCellDelegate.h"

@interface GoodsCell : UICollectionViewCell
@property(nonatomic,strong) MGoods* entity;

@property(nonatomic,weak) id<GoodsCellDelegate> delegate;
@end
