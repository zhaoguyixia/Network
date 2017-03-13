//
//  HPError.h
//  hopeTest
//
//  Created by wantexe on 17/3/8.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPError : NSObject
@property(nonatomic)NSInteger code;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *warningDesc;
@property(nonatomic)NSInteger state;
+ (id)errorWithCode:(NSInteger)code desc:(NSString *)desc;
+ (id)errorWithCode:(NSInteger)code desc:(NSString *)desc warningDesc:(NSString *)warningDesc;
@end
