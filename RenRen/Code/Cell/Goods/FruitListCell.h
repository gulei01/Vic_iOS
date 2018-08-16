//
//  FruitListCell.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/20.
//
//

#import <UIKit/UIKit.h>
#import "GoodsCellDelegate.h"

@interface FruitListCell : UICollectionViewCell
@property(nonatomic,weak) id<GoodsCellDelegate> delegate;
@property(nonatomic,strong) MGoods* entity;

@end
