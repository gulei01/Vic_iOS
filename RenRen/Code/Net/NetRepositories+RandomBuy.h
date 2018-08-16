//
//  NetRepositories+RandomBuy.h
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import "NetRepositories.h"

@interface NetRepositories (RandomBuy)

-(void)randomNetConfirm:(NSDictionary*)arg complete:(responseDictBlock)complete;

-(void)queryRandom:(NSDictionary*)arg complete:(responseDictBlock)complete;

-(void)queryRandomVouchers:(NSDictionary*)arg complete:(responseListBlock)complete;

-(void)saveRandomOrder:(NSDictionary*)arg complete:(responseDictBlock)complete;

-(void)queryRandomOrder:(NSDictionary*)arg page:(NetPage*)page complete:(responseListBlock)complete;

-(void)queryRandomAddress:(NSDictionary *)arg complete:(responseListBlock)complete;

@end
