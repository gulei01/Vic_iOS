//
//  MPresaleInfo.h
//  KYRR
//
//  Created by kyjun on 16/6/18.
//
//

#import <Foundation/Foundation.h>

@interface MPresaleInfo : NSObject

@property(nonatomic,strong) MStore* store;
@property(nonatomic,strong) NSMutableArray* arrayCustomer;
@property(nonatomic,strong) MPresale* presale;

@end
