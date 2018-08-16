//
//  LocationAreaCell.h
//  XYRR
//
//  Created by kyjun on 15/10/16.
//
//

#import <UIKit/UIKit.h>
#import "MArea.h"
/**
 *  区域
 */
@interface LocationAreaCell : UICollectionViewCell


@property(nonatomic,strong) MArea* entity;

-(void)setCity:(NSString*)city;

@end
