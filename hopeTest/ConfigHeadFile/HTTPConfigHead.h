//
//  HTTPConfigHead.h
//  hopeTest
//
//  Created by wantexe on 17/3/9.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#ifndef HTTPConfigHead_h
#define HTTPConfigHead_h

/*服务器地址*/
#define BASE_URL @"http://api.wantexe.com/v1/"

/*请求超时时间*/
#define REQUEST_OUTTIME 3

/*上传文件超时时间*/
#define UPLOAD_OUTTIME 30;

/*用沙盒路径拼接出完整路径*/
#define ABSOLUTE_PATH(FILE_NAME) [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), FILE_NAME]

#endif /* HTTPConfigHead_h */
