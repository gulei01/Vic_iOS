//
//  NetRepositories+Wang.m
//  KYRR
//
//  Created by kuyuZJ on 16/10/19.
//
//

#import "NetRepositories+Wang.h"


@implementation NetRepositories (Wang)
//五个按钮的数据
-(void)requestPost:(NSDictionary *)arg complete:(responseDictBlock)complete{
    NSLog(@"garfunkel arg:%@",arg);
    [[NetClient sharedClient] POST:AppNetSubPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSDictionary* empty = nil;
        if(flag == 1){
            message = @"";
            if(![WMHelper isNULLOrnil:responseObject]){
                empty = responseObject;
                
            }
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

@end
