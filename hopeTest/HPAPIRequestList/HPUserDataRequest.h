//
//  HPUserDataRequest.h
//  hopeTest
//
//  Created by wantexe on 17/3/10.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPUserDataRequest : NSObject

/**
 create a singleton

 @return HPUserDataRequest Object
 */
+ (instancetype)shareManager;
#pragma mark --request through get，the second method just add a download progress
/**
 request data through get method

 @param url url
 @param params url params
 @param successBlock request successBlock
 @param failureBlock request failureBlock
 */
- (void)getDataWithUrl:(NSString *)url
             andParams:(NSDictionary *)params
            andSuccess:(requestSuccessResult)successBlock
            andFailure:(requestFailureResult)failureBlock;
/**
 just add a progress
 */
- (void)getDataWithUrl:(NSString *)url
             andParams:(NSDictionary *)params
            andSuccess:(requestSuccessResult)successBlock
            andFailure:(requestFailureResult)failureBlock
           andProgress:(downloadProgress)downProgress;

#pragma mark --response through post，the second method just add a download progress
/**
 response data through post method
 
 @param url url
 @param params url params
 @param successBlock response successBlock
 @param failureBlock response failureBlock
 */
- (void)postDataWithUrl:(NSString *)url
             andParams:(NSDictionary *)params
            andSuccess:(requestSuccessResult)successBlock
            andFailure:(requestFailureResult)failureBlock;
/**
 jsut add a progress
 */
- (void)postDataWithUrl:(NSString *)url
             andParams:(NSDictionary *)params
            andSuccess:(requestSuccessResult)successBlock
            andFailure:(requestFailureResult)failureBlock
           andProgress:(uploadProgress)upProgress;
@end
