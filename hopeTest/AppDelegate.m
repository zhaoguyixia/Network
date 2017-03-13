//
//  AppDelegate.m
//  hopeTest
//
//  Created by wantexe on 17/3/8.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@", ABSOLUTE_PATH(@"cache.db"));
    
    NSArray *array = @[@"123",@"345",@"456"];
    NSString *tableName = @"array_table";
    [[HPCacheService cacheManger] cacheArray:array withId:@"arrayId1" intoTable:tableName];
    
    NSArray *getArray = [[HPCacheService cacheManger] getArrayWithId:@"arrayId1" fromTable:tableName];
    NSLog(@"%@", getArray);
    
    NSString *dicTable = @"dic_table";
    NSDictionary *cacheDic = @{@"username":@"lmf", @"password":@"123456"};
    [[HPCacheService cacheManger] cacheDictionay:cacheDic withId:@"dicId1" intoTable:dicTable];
    
    NSDictionary *infoDic = [[HPCacheService cacheManger] getDictionaryWithId:@"dicId1" fromTable:dicTable];
    NSLog(@"%@", infoDic);
    
    return YES;
    NSString *url = @"";
    [[HPHttpService shareManager] uploadFileWithContentUrl:url withParam:nil withFilePath:ABSOLUTE_PATH(@"photo.zip") withProgress:^(CGFloat progress) {
        NSLog(@"%g", progress);
    } withSuccess:^(NSURLSessionDataTask *task, id model, HPError *hpError) {
        NSLog(@"%@", model);
    } withFailure:^(NSURLSessionDataTask *task, HPError *hpError) {
        NSLog(@"%@", hpError);
    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
