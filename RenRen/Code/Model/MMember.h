//
//  MMember.h
//  KYRR
//
//  Created by kyjun on 15/11/2.
//
//

#import <Foundation/Foundation.h>

@interface MMember : NSObject<NSCoding>

-(instancetype)initWithItem:(NSDictionary*)item;

@property(nonatomic,assign) BOOL isLogin;

@property(nonatomic,copy) NSString* userID;
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* passWord;
@property(nonatomic,copy) NSString* avatar;
@property(nonatomic,copy) NSString* loginType;
@property(nonatomic,copy) NSString* openID;
@property(nonatomic,copy) NSString* language;


@end
