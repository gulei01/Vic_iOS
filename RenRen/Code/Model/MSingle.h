//
//  MSingle.h
//  XYRR
//
//  Created by kyjun on 15/10/17.
//
//

#import <Foundation/Foundation.h>
#import "MLcation.h"
#import "MMember.h"

@interface MSingle : NSObject
+(instancetype)shareAuhtorization;
/**
 *  当前选择的位置信息
 */
@property(nonatomic,strong,readonly) MLcation* location;

@property(nonatomic,strong,readonly) MMember* userInfo;
@end
