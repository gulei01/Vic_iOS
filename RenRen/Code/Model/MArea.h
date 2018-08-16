//
//  MArea.h
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import <Foundation/Foundation.h>
/**
 *  区域
 */
@interface MArea : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

/**
 *  区域编号
 */
@property(nonatomic,copy) NSString* areaID;
/**
 *  区域名称
 */
@property(nonatomic,copy) NSString* areaName;


@end
