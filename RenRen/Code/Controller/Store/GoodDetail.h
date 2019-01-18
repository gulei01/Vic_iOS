//
//  GoodDetail.h
//  RenRen
//
//  Created by Garfunkel on 2019/1/9.
//

#import <UIKit/UIKit.h>

@interface GoodDetail : UIViewController
-(instancetype)initWithItem:(MGoods *)entity;
@property(nonatomic,strong) MGoods* entity;
@end
