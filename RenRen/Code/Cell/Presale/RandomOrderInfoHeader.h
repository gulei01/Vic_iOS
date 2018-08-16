//
//  RandomOrderInfoHeader.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/18.
//
//

#import <UIKit/UIKit.h>

@interface RandomOrderInfoHeader : UICollectionReusableView

@property(nonatomic,strong) NSDictionary* item;
@property(nonatomic,strong) UIButton* btnStatus;
@property(nonatomic,strong) UIButton* btnHome;

@property(nonatomic,strong) UIButton* btnCancel;
@property(nonatomic,strong) UIButton* btnPay;

@end
