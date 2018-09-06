//
//  GoodsCellDelegate.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/21.
//
//

#import <Foundation/Foundation.h>

@protocol GoodsCellDelegate <NSObject>
@optional
-(void)addToShopCar:(MGoods*)item num:(NSString *) num;
-(void)didSelectGoodPhoto:(MGoods*)item;
@end
