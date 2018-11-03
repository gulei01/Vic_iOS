//
//  NetRepositories.m
//  KYRR
//
//  Created by kyjun on 16/6/1.
//
//

#import "NetRepositories.h"
#import "MyGroupModel.h"
#import "MyGroupModel2.h"

///Shop/shop_list
NSString* const AppNetSubPath = @"index.php?g=Api";
NSString* const AppNetSubPath_Points = @"mobile/Jf/index";



@implementation NetRepositories

-(void)netConfirm:(NSDictionary *)arg complete:(responseDictBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSDictionary* empty = nil;
////        生成随机休眠数
//        float rand = (arc4random()%501);
//        rand = rand/100;
//        NSLog(@"&&&&&&&&我是一个随机数%.2f&&&&&&&&&&",rand);
//        [NSThread sleepForTimeInterval:rand];
        
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


@implementation NetRepositories (Store)
-(void)queryStore:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MStore* item = [[MStore alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryStore:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MStore* item = [[MStore alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)searchStore:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MStore* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MStore alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict])
                [empty setValuesForKeysWithDictionary:emptyDict];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

@end

@implementation NetRepositories (Goods)

-(void)queryGoods:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MGoods* item = [[MGoods alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryGoods:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlockXiaolong)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        
        NSMutableArray *group = nil;

        
        if(flag == 1){
            message = @"";
            NSString* shopStatus = nil;
            empty =[[NSMutableArray alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            
            
            if(![WMHelper isNULLOrnil:emptyDict]){
                //NSArray* emptyArray = [foodDict objectForKey:@"goods_list"];
                NSArray* emptyArray = [emptyDict objectForKey:@"foods"];
                /////*****////
                NSArray *groupArr = [emptyDict objectForKey:@"group"];
                
                if(![WMHelper isNULLOrnil:page]){
                    page.recordCount = [[emptyDict objectForKey:@"count"]integerValue];
                    if(![WMHelper isNULLOrnil:[emptyDict objectForKey:@"total_page"]]){
                        page.pageCount = [[emptyDict objectForKey:@"total_page"] integerValue];
                    }else if (![WMHelper isNULLOrnil:[emptyDict objectForKey:@"totalpage"]]){
                        page.pageCount = [[emptyDict objectForKey:@"totalpage"] integerValue];
                    }
                    page.pageSize = emptyArray.count;
                    NSString* emptyStr = [emptyDict objectForKey:@"shopstatus"];
                    if(![WMHelper isEmptyOrNULLOrnil:emptyStr]){
                        shopStatus = emptyStr;
                    }
                }
                if(![WMHelper isNULLOrnil:emptyArray])
                    
                    [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        MGoods* item = [[MGoods alloc]init];
                        [item setValuesForKeysWithDictionary:obj];
                        if(![WMHelper isEmptyOrNULLOrnil:shopStatus]){
                            item.storeStatus = shopStatus;
                        }
                        [empty addObject:item];
                        
                    }];
                
                
                if (![WMHelper isNULLOrnil:groupArr]) {
                    
                    group = [[NSMutableArray alloc]init];
                    
                    
                    for (int i = 0; i < groupArr.count + 1; i ++) {
                        
                        MyGroupModel* item = [[MyGroupModel alloc]init];
                        
                        if (i == 0) {
                            
                            item.rowID = @"0";
                            item.sid = @"263";
                            item.title = Localized(@"All_txt");
                            
                            
                        }else {
                        
                            [item setValuesForKeysWithDictionary:groupArr[i - 1]];
                        
                        }
                        
                        for (int j = 0; j < empty.count; j ++) {
                            
                            MGoods*goodsModel = empty[j];
                            
                            if ([item.rowID isEqualToString:goodsModel.group_id]) {
                                
                                [item.saveKindArray addObject:goodsModel];
                                
                            }
                            
                        }
                        
                        [group addObject:item];

                    }
                   

                }
                  
                
            }
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message,group);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络||异常",[[NSMutableArray alloc] init]);
    }];
}

-(void)queryGoodsWithSearch:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:page]){
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"total_page"]]){
                    page.pageCount = [[responseObject objectForKey:@"total_page"] integerValue];
                }else if (![WMHelper isNULLOrnil:[responseObject objectForKey:@"totalpage"]]){
                    page.pageCount = [[responseObject objectForKey:@"totalpage"] integerValue];
                }
                page.pageSize = emptyArray.count;
                
            }
            if(![WMHelper isNULLOrnil:emptyArray])
                
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MGoods* item = [[MGoods alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    item.storeStatus = @"1";
                    [empty addObject:item];
                }];
            
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)searchGoods:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MGoods* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MGoods alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict])
                [empty setValuesForKeysWithDictionary:emptyDict];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)querySubType:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MSubType* item = [[MSubType alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

@end

@implementation NetRepositories (Comment)

-(void)queryComment:(NSDictionary*)arg complete:(responseListAndOtherBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        MOther* other = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"list"];
            if(![WMHelper isNULLOrnil:emptyArray]){
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MComment* item = [[MComment alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
            }
            NSDictionary* emptyDict = [responseObject objectForKey:@"num"];
            if(![WMHelper isNULLOrnil:emptyDict]){
                other = [[MOther alloc]init];
                other.totalNum = [emptyDict objectForKey:@"all"];
                other.badNum = [emptyDict objectForKey:@"score_bad"];
                other.goodNum = [emptyDict objectForKey:@"score_good"];
                other.bestNum = [emptyDict objectForKey:@"score_best"];
                
                other.totalComment = [responseObject objectForKey:@"score"];
                other.foodComment = [responseObject objectForKey:@"score1"];
                other.shipComment = [responseObject objectForKey:@"score2"];
            }
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,other,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,nil,@"网络异常");
    }];
    
}
-(void)queryComment:(NSDictionary*)arg page:(NetPage*)page complete:(responseListAndOtherBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        MOther* other = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"list"];
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

            if(![WMHelper isNULLOrnil:emptyArray]){
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MComment* item = [[MComment alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
            }
            NSDictionary* emptyDict = [responseObject objectForKey:@"num"];
            if(![WMHelper isNULLOrnil:emptyDict]){
                other = [[MOther alloc]init];
                other.totalNum = [emptyDict objectForKey:@"all"];
                other.badNum = [emptyDict objectForKey:@"score_bad"];
                other.goodNum = [emptyDict objectForKey:@"score_good"];
                other.bestNum = [emptyDict objectForKey:@"score_best"];
                
                other.totalComment = [responseObject objectForKey:@"score"];
                other.foodComment = [responseObject objectForKey:@"score1"];
                other.shipComment = [responseObject objectForKey:@"score2"];
            }
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,other,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,nil,@"网络异常");
    }];
}
-(void)updateComment:(NSDictionary*)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MMember* empty = nil;
        if(flag == 1){
            message = @"";
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

@end


@implementation NetRepositories (Order)
-(void)queryOrder:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MOrder* item = [[MOrder alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}
-(void)queryOrder:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
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
                    MOrder* item = [[MOrder alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}
-(void)searchOrder:(NSDictionary *)arg complete:(responseItemBlock)complete{
    
}

-(void)queryOrderStatus:(NSDictionary *)arg complete:(responseListAndDictBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MOrderStatus* item = [[MOrderStatus alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    if([item.status integerValue] == 2){
                        
                    }
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,responseObject,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,nil,@"网络异常");
    }];
    
}

@end


@implementation NetRepositories (UserInfo)

//登录的网络请求
-(void)login:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MMember* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MMember alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict])
                [empty setValuesForKeysWithDictionary:emptyDict];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)register:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MMember* empty = nil;
        if(flag == 1){
            message = @"";
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)searchUserInfo:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MMember* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MMember alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict])
                [empty setValuesForKeysWithDictionary:emptyDict];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryAddress:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAddress* item = [[MAddress alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)queryAddress:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:page]){
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"total_page"]]){
                    page.pageCount = [[responseObject objectForKey:@"total_page"] integerValue];
                }else if (![WMHelper isNULLOrnil:[responseObject objectForKey:@"totalpage"]]){
                    page.pageCount = [[responseObject objectForKey:@"totalpage"] integerValue];
                }
                page.pageSize = emptyArray.count;
                
            }
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAddress* item = [[MAddress alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)searchAddres:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MAddress* empty = nil;
        if(flag == 1){
            message = @"";
            
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray]){
                NSDictionary* emptyDict = [emptyArray firstObject];
                if(![WMHelper isNULLOrnil:emptyDict]){
                    empty =[[MAddress alloc] init];
                    [empty setValuesForKeysWithDictionary:emptyDict];
                }
            }
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)updateAddres:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MAddress* empty = nil;
        if(flag == 1){
            message = @"";
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)queryRedEnvelop:(NSDictionary*)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MRedEnvelopes* item = [[MRedEnvelopes alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryRedEnvelop:(NSDictionary *)arg page:(NetPage*)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:page]){
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"total_page"]]){
                    page.pageCount = [[responseObject objectForKey:@"total_page"] integerValue];
                }else if (![WMHelper isNULLOrnil:[responseObject objectForKey:@"totalpage"]]){
                    page.pageCount = [[responseObject objectForKey:@"totalpage"] integerValue];
                }
                page.pageSize = emptyArray.count;
                
            }
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MRedEnvelopes* item = [[MRedEnvelopes alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}
@end


@implementation NetRepositories (ShopCar)
-(void)queryShopCar:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MStore* item = [[MStore alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryShopCar_V2:(NSDictionary *)arg complete:(void (^)(NSInteger, MCar *, NSString *))complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MCar* empty = nil;
        if(flag == 1){
            message = @"";
            empty = [[MCar alloc]initWithItem:responseObject];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)updateShopCar:(NSDictionary *)arg complete :(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MAddress* empty = nil;
        if(flag == 1){
            message = @"";
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)checkShopCar:(NSDictionary *)arg complete:(responseBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        if(flag == 1){
            message = @"";
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,@"网络异常");
    }];
}

-(void)submitShopCarCheck:(NSDictionary*)arg complete:(responseDictBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSDictionary* empty = responseObject;
        if(flag == 1){
            message = @"";
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];

}


@end


@implementation NetRepositories (Location)
-(void)queryArea:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MArea* item = [[MArea alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryCircle:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MCircle* item = [[MCircle alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}
@end


@implementation NetRepositories (Advertisement)

-(void)queryAdvertisement:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAdv* item = [[MAdv alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)queryAdvertZT:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAdv* item = [[MAdv alloc]initWithzt:obj];
                   // [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];

}

-(void)queryAdvertBanner:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MAdv* item = [[MAdv alloc]initWithItem:obj];
                    // [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];

}

-(void)searchNotice:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MSystemNotice* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MSystemNotice alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict])
                [empty setValuesForKeysWithDictionary:emptyDict];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

@end


@implementation NetRepositories (PointsMall)

-(void)queryPointMallIndex:(NSDictionary *)arg page:(NetPage*)page complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:AppNetSubPath_Points parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MPointIndex* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MPointIndex alloc] init];
            NSArray* emptyArray = [responseObject objectForKey: @"list"];
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
            [empty setValuesForKeysWithDictionary:responseObject];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)queryPointRecord:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:AppNetSubPath_Points parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
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
                    MPointRecord* item = [[MPointRecord alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)queryPointExchange:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:AppNetSubPath_Points parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
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
                    MPointExchange* item = [[MPointExchange alloc]init];
                    [item setValuesForKeysWithDictionary:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)searchPoint:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:AppNetSubPath_Points parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MPoint* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MPoint alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict])
                [empty setValuesForKeysWithDictionary:emptyDict];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];

}

-(void)exchangeGoods:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:AppNetSubPath_Points parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MAddress* empty = nil;
        if(flag == 1){
            message = @"";
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

@end


@implementation NetRepositories (BuyNow)
-(void)queryBuyNow:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MBuyNow* item = [[MBuyNow alloc]initWithItem:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
    
}

-(void)queryBuyNow:(NSDictionary *)arg page:(NetPage *)page complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:page]){
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"total_page"]]){
                    page.pageCount = [[responseObject objectForKey:@"total_page"] integerValue];
                }else if (![WMHelper isNULLOrnil:[responseObject objectForKey:@"totalpage"]]){
                    page.pageCount = [[responseObject objectForKey:@"totalpage"] integerValue];
                }
                page.pageSize = emptyArray.count;
                page.headerImage = [responseObject objectForKey:@"image_url"];
            }
            
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MBuyNow* item = [[MBuyNow alloc]initWithItem:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)searchBuyNow:(NSDictionary *)arg complete:(responseListAndOtherBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* emptyArray = nil;
        MBuyNow* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[MBuyNow alloc] init];
            NSDictionary* emptyDict = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyDict])
                [empty setValuesForKeysWithDictionary:emptyDict];
            
            emptyArray =[[NSMutableArray alloc] init];
            NSArray* array = [responseObject objectForKey:@"orders"];
            if(![WMHelper isNULLOrnil:array])
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MCustomer* item = [[MCustomer alloc]initWithItem:obj];
                    [emptyArray addObject:item];
                }];
            
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,emptyArray,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,nil,@"网络异常");
    }];
}

@end


@implementation NetRepositories (Presale)
-(void)queryPresale:(NSDictionary *)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MBuyNow* item = [[MBuyNow alloc]initWithItem:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];

}

-(void)queryPresale:(NSDictionary *)arg page:(NetPage *)page complte:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:page]){
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"total_page"]]){
                    page.pageCount = [[responseObject objectForKey:@"total_page"] integerValue];
                }else if (![WMHelper isNULLOrnil:[responseObject objectForKey:@"totalpage"]]){
                    page.pageCount = [[responseObject objectForKey:@"totalpage"] integerValue];
                }
                page.pageSize = emptyArray.count;
                 page.headerImage = [responseObject objectForKey:@"image_url"];
            }
            
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MPresale* item = [[MPresale alloc]initWithItem:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)searchPresale:(NSDictionary *)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MPresaleInfo* empty = nil;
        if(flag == 1){
            message = @"";
            if(![WMHelper isNULLOrnil:responseObject]){
                empty = [[MPresaleInfo alloc]init];
                [empty setValuesForKeysWithDictionary:responseObject];
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


@implementation NetRepositories (PintuangouVC)

-(void)queryPintuangouVC:(NSDictionary*)arg complete:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MFightGroup* item = [[MFightGroup alloc]initWithItem:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];

}

-(void)queryPintuangouVC:(NSDictionary*)arg page:(NetPage*)page complte:(responseListBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSMutableArray* empty = nil;
        if(flag == 1){
            message = @"";
            empty =[[NSMutableArray alloc] init];
            NSArray* emptyArray = [responseObject objectForKey:@"info"];
            if(![WMHelper isNULLOrnil:page]){
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                if(![WMHelper isNULLOrnil:[responseObject objectForKey:@"total_page"]]){
                    page.pageCount = [[responseObject objectForKey:@"total_page"] integerValue];
                }else if (![WMHelper isNULLOrnil:[responseObject objectForKey:@"totalpage"]]){
                    page.pageCount = [[responseObject objectForKey:@"totalpage"] integerValue];
                }
                page.pageSize = emptyArray.count;
            }
            
            if(![WMHelper isNULLOrnil:emptyArray])
                [emptyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MFightGroup* item = [[MFightGroup alloc]initWithItem:obj];
                    [empty addObject:item];
                }];
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];
}

-(void)searchPintuangouVC:(NSDictionary*)arg complete:(responseItemBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        MFightGroupInfo* empty = nil;
        if(flag == 1){
            message = @"";
            if(![WMHelper isNULLOrnil:responseObject]){
                empty = [[MFightGroupInfo alloc]init];
                [empty setValuesForKeysWithDictionary:responseObject];
            }
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常!");
    }];
}

-(void)queryMyFightGroup:(NSDictionary*)arg page:(NetPage*)page complte:(responseDictBlock)complete{
    NSString* postPath = [NSString stringWithFormat:@"%@%@",AppNetSubPath,languagePara];
    [[NetClient sharedClient] POST:postPath parameters:arg progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSInteger flag = [[responseObject objectForKey:@"status"] integerValue];
        [WMHelper outPutJsonString:responseObject];
        NSString* message = nil;
        NSDictionary* empty = nil;
        if(flag == 1){
            message = @"";    
            if(![WMHelper isNULLOrnil:page]){
                page.recordCount = [[responseObject objectForKey:@"count"]integerValue];
                page.pageSize = [[responseObject objectForKey: @"number"]integerValue];
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
            if(![WMHelper isNULLOrnil:responseObject])
                empty = responseObject;
        }else{
            message = [responseObject objectForKey:@"fail"];
        }
        complete(flag,empty,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(400,nil,@"网络异常");
    }];}
@end
