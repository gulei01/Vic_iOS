//
//  NewHomeFooter.h
//  KYRR
//
//  Created by kuyuZJ on 16/10/18.
//
//

#import <UIKit/UIKit.h>
#import "NewHomeDelegate.h"
// 第二个轮播设置
@interface NewHomeFooter : UICollectionReusableView

@property(nonatomic,weak) id<NewHomeDelegate> delegate;

-(void)loadDataWithTopic:(NSArray *)topic miaoSha:(NSDictionary *)miaoSha manJian:(NSDictionary *)manJian tuan:(NSDictionary *)tuan;

@end
