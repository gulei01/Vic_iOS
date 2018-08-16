//
//  MPresale.h
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import "MActivity.h"

/**
 *  预售产品 模型
 */
@interface MPresale : MActivity

@property(nonatomic,copy) NSString* presalePrice;

@end
