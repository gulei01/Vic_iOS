//
//  ReceivesAddressCell.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/10.
//
//

#import <UIKit/UIKit.h>

@protocol RecevicesAddressCellDelegate <NSObject>

@optional
-(void)editRecevicesAddress:(MAddress*)item;

@end

@interface ReceivesAddressCell : UICollectionViewCell

@property(nonatomic,strong) MAddress* item;

@property(nonatomic,weak) id<RecevicesAddressCellDelegate> delegate;

@end
