//
//  Pager.h
//  XYRR
//
//  Created by kyjun on 15/10/27.
//
//

#import <Foundation/Foundation.h>

@interface Pager : NSObject
/**
 *  当前页码
 */
@property(nonatomic) NSInteger pageIndex;
/**
 *  每页显示的数目条数
 */
@property(nonatomic) NSInteger pageSize;
/**
 *  总页数
 */
@property(nonatomic) NSInteger pageCount;
/**
 *  总记录数
 */
@property(nonatomic) NSInteger recordCount;
/**
 *  数据
 */
@property(nonatomic,strong) NSMutableArray *arrayData;

@end
