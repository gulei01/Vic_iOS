//
//  HomeSectionDelegate.h
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import <Foundation/Foundation.h>

@protocol HomeSectionDelegate <NSObject>
-(void)sectionTouch:(id)sender;

@optional
-(void)didSelectType:(id)sender;
-(void)didSelectBannerPhoto:(NSInteger)index;
-(void)didSelectSpecialPhoto:(NSInteger)index;
-(void)homeSectionSearch:(NSString*)keyWord;

@end
