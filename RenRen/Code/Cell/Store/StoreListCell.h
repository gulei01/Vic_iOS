//
//  StoreListCell.h
//  KYRR
//
//  Created by kyjun on 15/10/29.
//
//

#import <UIKit/UIKit.h>
#import "MStore.h"

@interface StoreListCell : UICollectionViewCell

@property(nonatomic,strong) MStore* entity;

@end

@interface StoreListTableCell : UITableViewCell
@property(nonatomic,strong) MStore* entity;
@end

@interface StoreActiveCell : UITableViewCell

@property(nonatomic,strong) NSDictionary* item;

@end
