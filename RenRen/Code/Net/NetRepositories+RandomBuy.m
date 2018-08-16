//
//  NetRepositories+RandomBuy.m
//  KYRR
//
//  Created by kuyuZJ on 16/9/12.
//
//

#import "NetRepositories+RandomBuy.h"
NSString* const AppNetSubPathRandom = @"App/Freebuy/index";

@implementation NetRepositories (RandomBuy)

-(void)randomNetConfirm:(NSDictionary *)arg complete:(responseDictBlock)complete{
    [[NetClient sharedClient] POST:AppNetSubPathRandom parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"ret"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSDictionary* empty = nil;
        if(flag == 200){
            message = @"";
            if(![WMHelper isNULLOrnil:responseObject]){
                empty = responseObject;
            }
            complete(1,empty,message);
        }else{
            message = [responseObject objectForKey:@"msg"];
            complete(0,empty,message);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryRandom:(NSDictionary *)arg complete:(responseDictBlock)complete{
    [[NetClient sharedClient] POST:AppNetSubPathRandom parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"ret"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSDictionary* empty = nil;
        if(flag == 200){
            message = @"";
            empty = [responseObject objectForKey:@"data"];
            complete(1,empty,message);
        }else{
            message = [responseObject objectForKey:@"msg"];
            NSLog(@"message%@",message);
            complete(0,empty,message);
        }
        NSLog(@"message*%@*",message);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)queryRandomVouchers:(NSDictionary *)arg complete:(responseListBlock)complete{
    [[NetClient sharedClient] POST:AppNetSubPathRandom parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"ret"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 200){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"data"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {                     
                    [empty addObject:obj];
                }];
            
            complete(1,empty,message);
        }else{
            message = [responseObject objectForKey:@"msg"];
            complete(0,empty,message);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)saveRandomOrder:(NSDictionary *)arg complete:(responseDictBlock)complete{
    [[NetClient sharedClient] POST:AppNetSubPathRandom parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"ret"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSDictionary* empty = nil;
        if(flag == 200){
            message = @"";
            if(![WMHelper isNULLOrnil:responseObject]){
                empty = responseObject;
            }
            complete(1,empty,message);
        }else{
            message = [responseObject objectForKey:@"msg"];
            complete(0,empty,message);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryRandomOrder:(NSDictionary *)arg page:(NetPage*)page complete:(responseListBlock)complete{
    [[NetClient sharedClient] POST:AppNetSubPathRandom parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"ret"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 200){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"data"];
            if(![WMHelper isNULLOrnil:page]){
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"number"]]){
                    page.pageSize = [[responseObject objectForKey:@"number"] integerValue];
                }else{
                    page.pageSize = emptyArray.count;
                }
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"total_page"]]){
                    page.pageCount = [[responseObject objectForKey:@"total_page"] integerValue];
                }else if (![WMHelper isNULLOrnil:[responseObject objectForKey:@"totalpage"]]){
                    page.pageCount = [[responseObject objectForKey:@"totalpage"] integerValue];
                }else{
                    if(page.recordCount%page.pageSize == 0){
                        page.pageCount = page.recordCount/page.pageSize;
                    }else{
                        page.pageCount = (page.recordCount/page.pageSize)+1;
                    }
                }
            }
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [empty addObject:obj];
                }];
            complete(1,empty,message);
        }else{
            message = [responseObject objectForKey:@"msg"];
            complete(0,empty,message);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)queryRandomAddress:(NSDictionary *)arg complete:(responseListBlock)complete{
    [[NetClient sharedClient] POST:AppNetSubPathRandom parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"ret"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 200){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"data"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAddress* item = [[MAddress alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
            complete(1,empty,message);
        }else{
            message = [responseObject objectForKey:@"msg"];
            complete(0,empty,message);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

@end
