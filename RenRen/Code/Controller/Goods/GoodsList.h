//
//  GoodsList.h
//  XYRR
//
//  Created by kyjun on 15/10/27.
//
//

#import <UIKit/UIKit.h>

@interface GoodsList : UIViewController 

-(instancetype)initWithCategoryID:(NSInteger)categoryID isSelf:(NSInteger)isSelf;
-(instancetype)initWithCategoryID:(NSInteger)categoryID storeID:(NSString*)storeID;
@end
