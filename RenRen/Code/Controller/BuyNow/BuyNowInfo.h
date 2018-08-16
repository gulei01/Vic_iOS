//
//  BuyNowInfo.h
//  DTCoreText
//
//  Created by kyjun on 16/6/14.
//  Copyright © 2016年 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyNowInfo : UIViewController

-(instancetype)initWithItem:(MBuyNow*)item;
@property(nonatomic,strong) NSString* storeName;

@end
