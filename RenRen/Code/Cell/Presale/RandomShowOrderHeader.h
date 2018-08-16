//
//  RandomShowOrderHeader.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/21.
//
//

#import <UIKit/UIKit.h>

@interface RandomShowOrderHeader : UICollectionReusableView
@property(nonatomic,strong) UIButton* btnHeader;

-(void)loadUsers:(NSString*)users;

@end
