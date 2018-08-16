//
//  NewHomeSection.h
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import <UIKit/UIKit.h>
#import "NewHomeDelegate.h"

@interface NewHomeSection : UICollectionReusableView

@property(nonatomic,weak) id<NewHomeDelegate> delegate;

@property(nonatomic,strong) NSDictionary* item;

@end
