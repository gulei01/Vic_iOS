//
//  FruitInfoHeader.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/21.
//
//

#import <UIKit/UIKit.h>

@interface FruitInfoHeader : UIViewController

-(void)loadData:(MGoods*)entity complete:(void(^)(CGSize size))complete;

@end
