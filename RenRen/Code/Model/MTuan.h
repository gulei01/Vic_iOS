//
//  MTuan.h
//  KYRR
//
//  Created by kyjun on 16/6/16.
//
//

#import <Foundation/Foundation.h>

@interface MTuan : NSObject

@property(nonatomic,copy) NSString* rowID;
/**
 *  团长
 */
@property(nonatomic,copy) NSString* userID;
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* expiredDate;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* successNum;
@property(nonatomic,copy) NSString* lastNum;
/**
 *  团长头像
 */
@property(nonatomic,copy) NSString* avatar;
@property(nonatomic,copy) NSString* tuanStatus;


@end

@interface MFightGroupInfo : NSObject

@property(nonatomic,strong) NSMutableArray* arrayTuan;
@property(nonatomic,strong) MTuan* tuanItem;
@property(nonatomic,strong) NSMutableArray* arrayCustomer;
@property(nonatomic,strong) MFightGroup* fightGroup;

@property(nonatomic,strong) NSString* tuanInfoUrl;
@property(nonatomic,strong) NSString* tuanInfoPhoto;

@end
