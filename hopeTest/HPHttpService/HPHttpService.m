//
//  HPHttpService.m
//  hopeTest
//
//  Created by wantexe on 17/3/8.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import "HPHttpService.h"

static HPHttpService *_httpService;

@implementation HPHttpService

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpService = [[HPHttpService alloc] init];
    });
    return _httpService;
}

- (NSURL *)getBaseUrl
{
    return [NSURL URLWithString:BASE_URL];
}

- (instancetype)init
{
    if (self = [super init])
    {
        /** init AFHTTPSessionManager Object */
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[self getBaseUrl]];
        
        /** set request */
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        /** set request out time */
        _manager.requestSerializer.timeoutInterval = REQUEST_OUTTIME;
        
        /** set cache policy */
        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        /** set response */
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        
        /** hand keys from service which have no value，yes means remove this kinds of key，no means save */
        response.removesKeysWithNullValues = YES;
        _manager.responseSerializer = response;
        
        /**set request content type,application/json tells service please send json data,and application/xml tells service send XML data*/
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        /**set content type which response from service*/
        [_manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
        [self setExtraHeader];
    }
    return self;
}

/**
 set some extra params
 */
- (void)setExtraHeader
{
    /** you can set extra params here */
}
#pragma mark --request service through get
- (void)getRequestWithUrl:(NSString *)url
                withParam:(NSDictionary *)params
             withProgress:(void (^)(CGFloat progress))progess
         withSuccessBlock:(void (^)(NSURLSessionDataTask *task, id model, HPError *hpError))success
         withFailureBlock:(void (^)(NSURLSessionDataTask *task, HPError *hpError))failure
{
    [_manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progess(downloadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *response = (NSDictionary *)responseObject;
        if ([response[@"state"] intValue] == 0)
        {
            HPError *error = nil;
            NSString *warning = response[@"warning"];
            if ([warning length] > 0)
            {
                error = [HPError errorWithCode:0 desc:nil warningDesc:warning];
            }
            success(task, responseObject[@"data"], error);
        }
        else
        {
            HPError *error = [HPError errorWithCode:[response[@"state"] integerValue] desc:response[@"message"]];
            failure(task, error);
        }
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HPError *hpError = [HPError errorWithCode:error.code desc:error.description];
        failure(task, hpError);
        
    }];
}
#pragma mark --request service through post
- (void)postRequestWithUrl:(NSString *)url
                 withParam:(NSDictionary *)params
              withProgress:(void (^)(CGFloat progress))progess
          withSuccessBlock:(void (^)(NSURLSessionDataTask *task, id model, HPError *hpError))success
          withFailureBlock:(void (^)(NSURLSessionDataTask *tssk, HPError *hpError))failure
{
    [_manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *response = (NSDictionary *)responseObject;
        if ([response[@"state"] intValue] == 0)
        {
            HPError *error = nil;
            NSString *warning = response[@"warning"];
            if ([warning length] > 0)
            {
                error = [HPError errorWithCode:0 desc:nil warningDesc:warning];
            }
            success(task, responseObject[@"data"], error);
        }
        else
        {
            HPError *error = [HPError errorWithCode:[response[@"state"] integerValue] desc:response[@"message"]];
            failure(task, error);
        }
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HPError *hpError = [HPError errorWithCode:error.code desc:error.description];
        failure(task, hpError);
        
    }];
}
#pragma mark --upload file
- (void)uploadFileWithContentUrl:(NSString *)url
                       withParam:(NSDictionary *)param
                    withFilePath:(NSString *)filePath
                    withProgress:(void (^)(CGFloat progress))progress
                     withSuccess:(void (^)(NSURLSessionDataTask *task, id model, HPError *hpError))success
                     withFailure:(void (^)(NSURLSessionDataTask *task, HPError *hpError))failure
{
    _manager.requestSerializer.timeoutInterval = UPLOAD_OUTTIME;
    [_manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        if (filePath)
        {
            NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
            [formData appendPartWithFileURL:fileUrl name:@"file" error:nil];
        }
        else if ([param objectForKey:@"file"])
        {
            [formData appendPartWithFileData:[param objectForKey:@"file"] name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        /*upload progress*/
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *response = (NSDictionary *)responseObject;
        if ([response[@"state"] intValue] == 0)
        {
            HPError *error = nil;
            if ([response[@"warning"] length] > 0)
            {
                error = [HPError errorWithCode:0 desc:nil warningDesc:response[@"warning"]];
            }
            success(task, response[@"data"], error);
        }
        else
        {
            HPError *error = [HPError errorWithCode:[response[@"status"] integerValue] desc:response[@"message"]];
            failure(task, error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HPError *hpError = [HPError errorWithCode:error.code desc:error.description];
        failure(task, hpError);
        
    }];
}
#pragma mark --download file
- (void)downloadFileWithUrl:(NSString *)url
               withSavePath:(NSString *)savePath
                  withParam:(NSString *)params
                 withUserId:(NSString *)userId
               withProgress:(void (^)(CGFloat progress))progress
                withFailure:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
//    [request addValue:userId forHTTPHeaderField:@"userId"];
//    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:savePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        failure(response, filePath, error);
        
    }];
    
    [task resume];
    
}

@end
