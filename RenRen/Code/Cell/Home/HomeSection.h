//
//  HomeSection.h
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import <UIKit/UIKit.h>
#import "HomeSectionDelegate.h"


@interface HomeSection : UICollectionReusableView

@property(nonatomic,strong) UIButton* btnSection;

@property(nonatomic,weak) id<HomeSectionDelegate> delegate;

@end
