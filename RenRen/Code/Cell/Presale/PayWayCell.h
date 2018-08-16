//
//  PayWayCell.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/14.
//
//

#import <UIKit/UIKit.h>

@class  MPayWay;

@interface PayWayCell : UICollectionViewCell

@property(nonatomic,strong) MPayWay* item;

@end

@interface MPayWay : NSObject


@property(nonatomic,strong) NSString* icon;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* subTitle;
@property(nonatomic,strong) NSString* payType;
@property(nonatomic,assign) BOOL selected;

@end
