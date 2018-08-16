//
//  MActivity.h
//  KYRR
//
//  Created by kuyuZJ on 16/6/24.
//
//

#import <Foundation/Foundation.h>

@interface MActivity : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,copy) NSString* thumbnails;
@property(nonatomic,copy) NSString* goodsName;
@property(nonatomic,copy) NSString* storeID;
@property(nonatomic,copy) NSString* storeName;
/**
 *  店面状态 1 营业 2 休息
 */
@property(nonatomic,copy) NSString* storeStatus;
@property(nonatomic,copy) NSString* marketPrice;
@property(nonatomic,copy) NSString* beginDate;
@property(nonatomic,copy) NSString* endDate;
@property(nonatomic,copy) NSString* goodsSales;
@property(nonatomic,copy) NSString* goodsStock;
@property(nonatomic,copy) NSString* goodsContent;

/**
 *  缩略图尺寸
 */
@property(nonatomic,assign)CGSize thumbnailsSize;
/**
 *  商品描述尺寸
 */
@property(nonatomic,assign)CGSize contentSize;

@end
