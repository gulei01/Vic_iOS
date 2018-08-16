//
//  WineListCell.h
//  KYRR
//
//  Created by kuyuZJ on 16/8/26.
//
//

#import <UIKit/UIKit.h>
#import "GoodsCellDelegate.h"

@interface WineListCell : UICollectionViewCell
@property(nonatomic,strong) MGoods* entity;

@property(nonatomic,weak) id<GoodsCellDelegate> delegate;


@end
