//
//  HPError.m
//  hopeTest
//
//  Created by wantexe on 17/3/8.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import "HPError.h"

@implementation HPError

+ (id)errorWithCode:(NSInteger)code desc:(NSString *)desc
{
    return [self errorWithCode:code desc:desc warningDesc:nil];
}

+ (id)errorWithCode:(NSInteger)code desc:(NSString *)desc warningDesc:(NSString *)warningDesc
{
    HPError *error = [[HPError alloc] init];
    error.code = code;
    error.desc = desc;
    error.warningDesc = warningDesc;
    return error;
}

@end
