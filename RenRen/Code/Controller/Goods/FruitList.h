//
//  FruitList.h
//  KYRR
//
//  Created by kuyuZJ on 16/7/20.
//
//

#import <UIKit/UIKit.h>

@interface FruitList : UIViewController

-(instancetype)initWithCategoryID:(NSInteger)categoryID;
-(instancetype)initWithCategoryID:(NSInteger)categoryID storeID:(NSString*)storeID;

@end
