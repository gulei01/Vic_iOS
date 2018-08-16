//
//  PresaleInfoHeader.h
//  KYRR
//
//  Created by kyjun on 16/6/18.
//
//

#import <UIKit/UIKit.h>
#import <DTCoreText/DTCoreText.h>
#import "MPresale.h"

@interface PresaleInfoHeader : UIViewController

-(void)loadData:(MPresale*)entity complete:(void(^)(CGSize size))complete;


@end
