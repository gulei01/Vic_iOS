//
//  PointsMallHeader.h
//  KYRR
//
//  Created by kyjun on 16/5/9.
//
//

#import <UIKit/UIKit.h>

@protocol PointsMallHeaderDelegate <NSObject>

@optional
-(void)pointsRecord;
-(void)pointExchange;
-(void)pointsRule;

@end

@interface PointsMallHeader : UICollectionReusableView

-(void)loadData:(NSString*)points topImg:(NSString*)topImg;

@property(nonatomic,weak) id<PointsMallHeaderDelegate> delegate;

@end
