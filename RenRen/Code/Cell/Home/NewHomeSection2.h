//
//  NewHomeSection2.h
//  KYRR
//
//  Created by kuyuZJ on 16/10/20.
//
//

#import <UIKit/UIKit.h>
#import "NewHomeDelegate.h"

@interface NewHomeSection2 : UICollectionReusableView


@property(nonatomic,weak) id<NewHomeDelegate> delegate;

@property(nonatomic,strong) NSDictionary* item;

@end
