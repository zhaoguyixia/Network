//
//  HPUserDataRequest.m
//  hopeTest
//
//  Created by wantexe on 17/3/10.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import "HPUserDataRequest.h"

@implementation HPUserDataRequest
+ (instancetype)shareManager
{
    static HPUserDataRequest *requestManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[HPUserDataRequest alloc] init];
    });
    return requestManager;
}
#pragma mark --request through get，the second method just add a download progress
- (void)getDataWithUrl:(NSString *)url
             andParams:(NSDictionary *)params
            andSuccess:(requestSuccessResult)successBlock
            andFailure:(requestFailureResult)failureBlock
{
    [self getDataWithUrl:url andParams:params andSuccess:successBlock andFailure:failureBlock andProgress:nil];
}

- (void)getDataWithUrl:(NSString *)url
             andParams:(NSDictionary *)params
            andSuccess:(requestSuccessResult)successBlock
            andFailure:(requestFailureResult)failureBlock
           andProgress:(downloadProgress)downProgress
{
    [[HPHttpService shareManager] getRequestWithUrl:url withParam:params withProgress:^(CGFloat progress) {
        downProgress(progress);
    } withSuccessBlock:^(NSURLSessionDataTask *task, id model, HPError *hpError) {
        if (model)
        {
            successBlock(model);
        }
    } withFailureBlock:^(NSURLSessionDataTask *task, HPError *hpError) {
        failureBlock(hpError);
    }];
}

#pragma mark --response through post，the second method just add a download progress
- (void)postDataWithUrl:(NSString *)url
              andParams:(NSDictionary *)params
             andSuccess:(requestSuccessResult)successBlock
             andFailure:(requestFailureResult)failureBlock
{
    [self postDataWithUrl:url andParams:params andSuccess:successBlock andFailure:failureBlock andProgress:nil];
}

- (void)postDataWithUrl:(NSString *)url
              andParams:(NSDictionary *)params
             andSuccess:(requestSuccessResult)successBlock
             andFailure:(requestFailureResult)failureBlock
            andProgress:(uploadProgress)upProgress
{
    [[HPHttpService shareManager] postRequestWithUrl:url withParam:params withProgress:^(CGFloat progress) {
        upProgress(progress);
    } withSuccessBlock:^(NSURLSessionDataTask *task, id model, HPError *hpError) {
        if (model)
        {
            successBlock(model);
        }
    } withFailureBlock:^(NSURLSessionDataTask *tssk, HPError *hpError) {
        failureBlock(hpError);
    }];
}

@end
