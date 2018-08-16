//
//  TuanCell.h
//  KYRR
//
//  Created by kyjun on 16/6/16.
//
//

#import <UIKit/UIKit.h>

@protocol TuanCellDelegate <NSObject>

@optional
-(void)tuanEnd;

@end

@interface TuanCell : UITableViewCell

@property(nonatomic,strong) MTuan* entity;

@property(nonatomic,weak) id<TuanCellDelegate> delegate;

@end
