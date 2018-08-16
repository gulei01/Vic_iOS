//
//  HomeHeader.h
//  XYRR
//
//  Created by kyjun on 15/10/17.
//
//

#import <UIKit/UIKit.h>
#import "HomeSectionDelegate.h"

@interface HomeHeader : UICollectionReusableView
@property(nonatomic,strong,nullable) UITextField* txtSearch;
@property(nonatomic,strong ,nullable) UIButton *btnSection;
@property(nonatomic,weak) id<HomeSectionDelegate> delegate;
-(void)loadNotice:(NSString *)notice;
-(void)loadBuyNow:(MBuyNow *)buyNow fightGroup:(MFightGroup *)fightGroup;

@end
