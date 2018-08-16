//
//  StoreGoodsController.h
//  KYRR
//
//  Created by kyjun on 16/4/15.
//
//

#import <UIKit/UIKit.h>

@interface StoreGoodsController : UIViewController

-(instancetype)initWithStoreID:(NSString*)storeID;
-(instancetype)initWithStoreID:(NSString*)storeID goodsID:(NSString*)goodsID;
@property(nonatomic,strong) NSString* storeName;

@end
