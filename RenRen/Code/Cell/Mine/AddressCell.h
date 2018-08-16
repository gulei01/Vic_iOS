//
//  AddressCell.h
//  KYRR
//
//  Created by kyjun on 15/11/3.
//
//

#import <UIKit/UIKit.h>
#import "MAddress.h"

@protocol AddressCellDelegate <NSObject>

@optional
-(void)setDefaultAddress:(MAddress*)item;
-(void)editAddress:(MAddress*)item;
-(void)delAddress:(MAddress*)item;

@end

@interface AddressCell : UITableViewCell

@property(nonatomic,strong) MAddress* entity;

@property(nonatomic,weak) id<AddressCellDelegate> delegate;

-(void)disabledDelegate;

@end
