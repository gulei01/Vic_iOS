//
//  OrderConfirmCell.h
//  KYRR
//
//  Created by kyjun on 16/6/20.
//
//

#import <UIKit/UIKit.h>

@interface OrderConfirmCell : UITableViewCell

-(void)loadData:(NSString*)goodName price:(NSString*)price count:(NSString*)count;

@end
