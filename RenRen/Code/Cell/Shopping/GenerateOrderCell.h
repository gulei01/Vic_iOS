//
//  GenerateOrderCell.h
//  KYRR
//
//  Created by kyjun on 15/11/5.
//
//

#import <UIKit/UIKit.h>
#import "MGoods.h"

@interface GenerateOrderCell : UITableViewCell

@property(nonatomic,strong) MGoods* entity;

-(void)setItemWithDict:(NSDictionary*)item;

@end
