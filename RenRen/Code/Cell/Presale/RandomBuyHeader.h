//
//  RandomBuyHeader.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/5.
//
//

#import <UIKit/UIKit.h>
#import "RandomBuyDelegate.h"

 typedef void(^RandomBuyHeaderComplete)(CGFloat bannerHeight);

@interface RandomBuyHeader : UICollectionReusableView
 

-(void)loadDataWithType:(NSArray*)arrayType banners:(NSArray*)banners orders:(NSArray*)orders section:(NSDictionary*)item complete:(RandomBuyHeaderComplete)complete;
-(void)loadDataDelivery:(NSString*)count;
@property(nonatomic,weak) id<RandomBuyDelegate> delegate;

@property(nonatomic,strong) UITextField* txtSearch;

@end

@interface RandomBuyHeaderCell : UICollectionViewCell

@property(nonatomic,strong) NSDictionary* item;


@end
