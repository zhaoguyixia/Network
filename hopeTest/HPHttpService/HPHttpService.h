//
//  HPHttpService.h
//  hopeTest
//
//  Created by wantexe on 17/3/8.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPError.h"


/**
 request success result
 */
typedef void (^requestSuccessResult)(id result);

/**
 request failure result
 */
typedef void (^requestFailureResult)(HPError *error);

/**
 upload file progress
 */
typedef void (^uploadProgress)(float upProgress);

/**
 down load file progress
 */
typedef void (^downloadProgress)(float downProgress);

@interface HPHttpService : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *manager;


/**
 singleton create method

 @return HPHttpService Object
 */
+ (instancetype)shareManager;

/**
 get request service

 @param url url
 @param params extra key-value
 @param progess download progress
 @param success success block
 @param failure failure block
 */
- (void)getRequestWithUrl:(NSString *)url
                withParam:(NSDictionary *)params
             withProgress:(void (^)(CGFloat progress))progess
         withSuccessBlock:(void (^)(NSURLSessionDataTask *task, id model, HPError *hpError))success
         withFailureBlock:(void (^)(NSURLSessionDataTask *task, HPError *hpError))failure;

/**
 post request service

 @param url url
 @param params extra key-value
 @param progess upload progress
 @param success success block
 @param failure failure block
 */
- (void)postRequestWithUrl:(NSString *)url
                 withParam:(NSDictionary *)params
              withProgress:(void (^)(CGFloat progress))progess
          withSuccessBlock:(void (^)(NSURLSessionDataTask *task, id model, HPError *hpError))success
          withFailureBlock:(void (^)(NSURLSessionDataTask *tssk, HPError *hpError))failure;

/**
 upload file

 @param url request url
 @param param request params
 @param filePath file url
 @param progress upload progress
 @param success upload success
 @param failure upload failure
 */
- (void)uploadFileWithContentUrl:(NSString *)url
                       withParam:(NSDictionary *)param
                    withFilePath:(NSString *)filePath
                    withProgress:(void (^)(CGFloat progress))progress
                     withSuccess:(void (^)(NSURLSessionDataTask *task, id model, HPError *hpError))success
                     withFailure:(void (^)(NSURLSessionDataTask *task, HPError *hpError))failure;

/**
 download file

 @param url request url
 @param savePath save file path
 @param params request set params
 @param userId user id
 @param progress download progress
 @param failure if download failure
 */
- (void)downloadFileWithUrl:(NSString *)url
               withSavePath:(NSString *)savePath
                  withParam:(NSString *)params
                 withUserId:(NSString *)userId
               withProgress:(void (^)(CGFloat progress))progress
                withFailure:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))failure;

@end
