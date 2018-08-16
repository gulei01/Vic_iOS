//
//  MapCell.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/19.
//
//

#import <UIKit/UIKit.h>

@interface MapCell : UITableViewCell

-(void)loadAnnotation:(double)lat lng:(double)lng entity:(MOrderStatus*)entity;

@end
