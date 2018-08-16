//
//  NewHomeHeader.h
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import <UIKit/UIKit.h>
#import "NewHomeDelegate.h"

@interface NewHomeHeader : UICollectionReusableView

-(void)loadDataWithBanner:(NSArray *)banners loction:(NSString *)location category:(NSArray *)category notice:(NSDictionary *)notice;

@property(nonatomic,weak) id<NewHomeDelegate> delegate;

@end
