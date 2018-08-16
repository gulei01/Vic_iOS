//
//  MAdv.h
//  XYRR
//
//  Created by kyjun on 15/10/26.
//
//

#import <Foundation/Foundation.h>

@interface MAdv : NSObject

-(instancetype)initWithItem:(NSDictionary*)item;
-(instancetype)initWithzt:(NSDictionary*)item;

@property(nonatomic,copy) NSString* rowID;
@property(nonatomic,copy) NSString* photoUrl;
@property(nonatomic,copy) NSString* bigPhotoUrl;
@property(nonatomic,copy) NSString* title;

@property(nonatomic,copy) NSString* bannerUrl;

@property(nonatomic,assign) CGSize ztPhotoSize;



@end
