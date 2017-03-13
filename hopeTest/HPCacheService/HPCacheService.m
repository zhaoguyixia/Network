//
//  HPCacheService.m
//  hopeTest
//
//  Created by 李明锋 on 2017/3/13.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import "HPCacheService.h"
#define TABLE_NAME @"cache.db"

@interface HPCacheService ()
{
    YTKKeyValueStore *cacheStore;
}
@end

@implementation HPCacheService

static NSString *const kDefaultTableName = @"cacheDataTable";

+ (instancetype)cacheManger
{
    static HPCacheService *_cacheService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cacheService = [[HPCacheService alloc] init];
    });
    return _cacheService;
}

- (instancetype)init
{
    if (self = [super init])
    {
        cacheStore = [[YTKKeyValueStore alloc] initDBWithName:TABLE_NAME];
    }
    return self;
}

- (void)cacheArray:(NSArray *)array withId:(NSString *)arrayId intoTable:(NSString *)tableName
{
    if ([array count] == 0)
    {
        NSLog(@"this is a empty array!");
        return;
    }
    if ([self ifEmpty:tableName])
    {
        NSLog(@"the tableName is empty, please update it!");
        return;
    }
    [cacheStore createTableWithName:tableName];
    [cacheStore putObject:array withId:arrayId intoTable:tableName originTime:nil];
}

- (NSArray *)getArrayWithId:(NSString *)arrayId fromTable:(NSString *)tableName
{
    if ([self ifEmpty:tableName] || [self ifEmpty:arrayId])
    {
        NSLog(@"table name or id is empty");
        return nil;
    }
    id obj = [cacheStore getObjectById:arrayId fromTable:tableName];
    if (![obj isKindOfClass:[NSArray class]])
    {
        NSLog(@"type of data which from table is not array");
        return nil;
    }
    return (NSArray *)obj;
}

- (void)cacheDictionay:(NSDictionary *)infoDic withId:(NSString *)dicId intoTable:(NSString *)tableName
{
    if (infoDic == nil || [infoDic count] == 0)
    {
        NSLog(@"dictionary is not legal");
        return;
    }
    if ([self ifEmpty:dicId] || [self ifEmpty:tableName])
    {
        NSLog(@"table name or id is empty");
        return;
    }
    [cacheStore createTableWithName:tableName];
    [cacheStore putObject:infoDic withId:dicId intoTable:tableName originTime:nil];
}

- (NSDictionary *)getDictionaryWithId:(NSString *)dicId fromTable:(NSString *)tableName
{
    if ([self ifEmpty:dicId] || [self ifEmpty:tableName])
    {
        NSLog(@"table name or id is empty");
        return nil;
    }
    id obj = [cacheStore getObjectById:dicId fromTable:tableName];
    if (![obj isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"type of data which from table is not dictionary");
        return nil;
    }
    return (NSDictionary *)obj;
}

- (void)cacheString:(NSString *)string withId:(NSString *)strId intoTable:(NSString *)tableName
{
    if ([self ifEmpty:string] || [self ifEmpty:strId] || [self ifEmpty:tableName])
    {
        NSLog(@"string data or id or tableName is empty");
        return;
    }
    [cacheStore createTableWithName:tableName];
    [cacheStore putString:string withId:strId intoTable:tableName];
}

- (NSString *)getString:(NSString *)strId fromTable:(NSString *)tableName
{
    if ([self ifEmpty:strId] || [self ifEmpty:tableName])
    {
        NSLog(@"tableName or id is empty");
        return @"";
    }
    id obj = [cacheStore getStringById:strId fromTable:tableName];
    if (![obj isKindOfClass:[NSString class]])
    {
        NSLog(@"type of data from table is not string");
        return @"";
    }
    return (NSString *)obj;
}

- (void)deleteTableWith:(NSString *)tableName withState:(BOOL)flag
{
    if ([self ifEmpty:tableName])
    {
        NSLog(@"table name is empty");
        return ;
    }
    [cacheStore clearTable:tableName with:flag];
    
}

- (BOOL)ifEmpty:(NSString *)string
{
    if (string == nil || [string isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

@end
