//
//  GoodsV2Cell.h
//  KYRR
//
//  Created by kuyuZJ on 16/10/20.
//
//

#import <UIKit/UIKit.h>
#import "GoodsCellDelegate.h"


@interface GoodsV2Cell : UICollectionViewCell

@property(nonatomic,strong) MGoods* entity;

@property(nonatomic,weak) id<GoodsCellDelegate> delegate;

@end
