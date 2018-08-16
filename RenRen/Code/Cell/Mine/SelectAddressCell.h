//
//  SelectAddressCell.h
//  KYRR
//
//  Created by kyjun on 15/11/14.
//
//

#import <UIKit/UIKit.h>
#import "AddressCell.h"

@interface SelectAddressCell : UITableViewCell

@property(nonatomic,strong) MAddress* entity;
@property(nonatomic,weak) id<AddressCellDelegate> delegate;

@end
