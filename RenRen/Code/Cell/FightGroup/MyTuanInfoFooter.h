//
//  MyTuanInfoFooter.h
//  KYRR
//
//  Created by kuyuZJ on 16/6/29.
//
//

#import <UIKit/UIKit.h>

@protocol MyTuanInfoFooterDelegate <NSObject>

@optional
-(void)tuanInfoRule:(id)sender;

@end

@interface MyTuanInfoFooter : UICollectionReusableView

@property(nonatomic,weak) id<MyTuanInfoFooterDelegate> delegate;

@end
