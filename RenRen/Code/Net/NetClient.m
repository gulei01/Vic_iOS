//
//  NetClient.m
//  KYRR
//
//  Created by kyjun on 16/6/1.
//
//

#import "NetClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"https://www.vicisland.com/";
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://www.vicisland.ca/";
#warning TODO: //  注意切换生成/发布模式
static NSString * const AFAppDotNetAPIBaseURLStringTest = @"http://wm.wm0530.com/";


@implementation NetClient

static NetClient *sharedClient;

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[NetClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        NSLog(@"garfunkel_log：%@ ggend",sharedClient);
        sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return sharedClient;
}

-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(sharedClient == nil)
        {
            sharedClient = [super allocWithZone:zone];
        }
    });
    return sharedClient;
}

-(id)copy{
    return self;
}

-(id)mutableCopy{
    return self;
}

@end


