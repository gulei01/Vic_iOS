//
//  MCustomer.h
//  KYRR
//
//  Created by kyjun on 16/6/14.
//
//

#import <Foundation/Foundation.h>

@interface MCustomer : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;

@property(nonatomic,copy) NSString* userID;
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* orderID;
@property(nonatomic,copy) NSString* avatar;
@property(nonatomic,copy) NSString* leader;
@property(nonatomic,copy) NSString* createDate;



@end
