//
//  MSubType.h
//  XYRR
//
//  Created by kyjun on 15/10/28.
//
//

#import <Foundation/Foundation.h>
/**
 *  商品子分类
 */
@interface MSubType : NSObject
-(instancetype)initWithItem:(NSDictionary*)item;

/**
 *  分类编号
 */
@property(nonatomic,copy) NSString* rowID;
/**
 *  分类名称
 */
@property(nonatomic,copy) NSString* categoryName;
/**
 *  分类下的商品数量
 */
@property(nonatomic,copy) NSString* goodsNum;

@end
