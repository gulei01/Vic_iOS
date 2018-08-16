//
//  RandomBuyDelegate.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/6.
//
//

#import <Foundation/Foundation.h>

@protocol RandomBuyDelegate <NSObject>

-(void)didSelecteType:(NSDictionary*)item;

-(void)randomSearch:(NSString*)keyWord;

-(void)showRandomMap:(id)sender;

-(void)showRandomOrder:(id)sender;

-(void)selectedAdPhoto:(id)sender;

@end
