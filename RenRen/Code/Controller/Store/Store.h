//
//  Store.h
//  KYRR
//
//  Created by kyjun on 16/3/23.
//
//

#import <UIKit/UIKit.h>

/**
 *  商家 - 显示商品列表 评论列表 商家信息
 */
@interface Store : UIViewController

-(instancetype)initWithItem:(MStore*)item;
-(instancetype)initWithItem:(MStore*)item goods:(MGoods*)goods;

@end
