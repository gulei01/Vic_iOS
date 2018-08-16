//
//  RandomSaleInfo.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import <UIKit/UIKit.h>


/**
 *  帮你送 商品信息
 */
@interface RandomSaleInfo : UIViewController
/**
 *  
 *
 *  @param type NSString  'buy' 'send' 'get'
 *
 *  @return
 */
-(instancetype)initWithType:(NSString*)type;

@end
