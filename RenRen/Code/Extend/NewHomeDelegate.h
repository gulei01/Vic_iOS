//
//  NewHomeDelegate.h
//  KYRR
//
//  Created by kuyuZJ on 16/10/20.
//
//

#import <Foundation/Foundation.h>

@protocol NewHomeDelegate <NSObject>

@optional
-(void)didSelectedTopicAtIndex:(NSInteger)index imgSize:(CGSize)imgSize;
-(void)didSelectedBannerAtIndex:(NSInteger)index;
-(void)didSelectedLocation;
-(void)didSelectedCategory:(NSInteger)index;

-(void)didSelectedMiaoSha;
-(void)didSelectedManJian;
-(void)didSelectedTuan;

-(void)didSelectedStore:(id)sender;
-(void)didSelectedGoods:(id)store goods:(id)goods;

@end
