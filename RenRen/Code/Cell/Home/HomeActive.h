//
//  HomeActive.h
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import <UIKit/UIKit.h>
#import "NewHomeDelegate.h"

@interface HomeActive : UIView

@property(nonatomic,weak) id<NewHomeDelegate> delegate;

-(void)loadDataWithMiaoSha:(NSDictionary *)miaoSha manJian:(NSDictionary *)manJian tuan:(NSDictionary *)tuan;

@end
