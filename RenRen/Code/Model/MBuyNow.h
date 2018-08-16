//
//  MBuyNow.h
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import "MActivity.h"

/**
 *  秒杀实体模型
 */
@interface MBuyNow : MActivity

@property(nonatomic,copy) NSString* buyNowPrice;

@end
