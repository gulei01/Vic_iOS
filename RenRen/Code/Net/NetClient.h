//
//  NetClient.h
//  KYRR
//
//  Created by kyjun on 16/6/1.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

