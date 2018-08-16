//
//  GoodsHeader.h
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import <UIKit/UIKit.h>
#import "MGoods.h"
#import "GoodsHeaderDelegate.h"

@interface GoodsHeader : UICollectionReusableView

@property(nonatomic,strong) MGoods* entity;

@property(nonatomic,weak) id<GoodsHeaderDelegate> delegate;

@end
