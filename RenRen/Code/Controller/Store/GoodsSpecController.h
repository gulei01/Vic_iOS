//
//  GoodsSpecController.h
//  RenRen
//
//  Created by Garfunkel on 2018/9/16.
//

#import <UIKit/UIKit.h>
#import "GoodsCellDelegate.h"

@interface GoodsSpecController : UIViewController

-(instancetype)initWithItem:(MGoods *)entity;

@property(nonatomic,strong) MGoods* entity;
@property(nonatomic,strong)NSMutableDictionary* specBtn;
@property(nonatomic,strong)NSMutableDictionary* proBtn;
@property(nonatomic,strong)UIButton* mainBtn;

@property(nonatomic,weak) id<GoodsCellDelegate> delegate;

@end
