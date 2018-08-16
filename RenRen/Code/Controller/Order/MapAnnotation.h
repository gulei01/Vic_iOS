//
//  MapAnnotation.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/19.
//
//

#import <UIKit/UIKit.h>
#import "KCAnnotation.h"

@interface MapAnnotation : UIViewController

-(instancetype)initWith:(double)lng lat:(double)lat entity:(MOrderStatus*)entity;

@end
