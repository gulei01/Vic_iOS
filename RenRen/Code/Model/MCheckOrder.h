//
//  MCheckOrder.h
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import <Foundation/Foundation.h>

/**
 *  针对 拼团和预售需要有一个订单提交前的检验
 */

@interface MCheckOrder : NSObject


-(instancetype)initWithPresale:(NSDictionary*)item;
-(instancetype)initWithFightGroup:(NSDictionary*)item;

@property(nonatomic,assign) BOOL isPresale;

/**
 *  预售商品
 */
@property(nonatomic,strong) MPresale* presale;
/**
 *  收货地址
 */
@property(nonatomic,strong) MAddress* address;
/**
 *  团购商品
 */
@property(nonatomic,strong) MFightGroup* fightGroup;
@property(nonatomic,copy) NSString* tuanID;
/**
 *  打包费
 */
@property(nonatomic,copy) NSString* packingFee;
/**
 *  快递费
 */
@property(nonatomic,copy) NSString* shipFee;


@end
