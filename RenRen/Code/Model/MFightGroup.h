//
//  MFightGroup.h
//  KYRR
//
//  Created by kyjun on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import "MActivity.h"
/**
 *  拼团购 模型
 */
@interface MFightGroup : MActivity

@property(nonatomic,copy) NSString* pingNum;
@property(nonatomic,copy) NSString* tuanPrice;


@end
