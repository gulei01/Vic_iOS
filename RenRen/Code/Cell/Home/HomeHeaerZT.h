//
//  HomeHeaerZT.h
//  KYRR
//
//  Created by kyjun on 15/10/30.
//
//

#import <UIKit/UIKit.h>
#import "HomeSectionDelegate.h"

@interface HomeHeaerZT : UICollectionReusableView
@property(nonatomic,strong,nullable) UITextField* txtSearch;
@property(nonatomic,strong ,nullable) UIButton *btnSection;
@property(nonatomic,weak) id<HomeSectionDelegate> delegate;

-(void)loadAdvWithBottom:(nullable NSArray*)bottom;
-(void)loadNotice:(nullable NSString *)notice;
-(void)loadBuyNow:(MBuyNow*)buyNow fightGroup:(MFightGroup*)fightGroup;
@end
