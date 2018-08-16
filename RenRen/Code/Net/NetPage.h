//
//  NetPage.h
//  KYRR
//
//  Created by kyjun on 16/6/1.
//
//

#import <Foundation/Foundation.h>

@interface NetPage : NSObject

@property(nonatomic,assign) NSInteger pageIndex;
@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,assign) NSInteger pageCount;
@property(nonatomic,assign) NSInteger recordCount;


@property(nonatomic,copy) NSString* headerImage;

@end
