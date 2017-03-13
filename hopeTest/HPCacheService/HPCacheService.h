//
//  HPCacheService.h
//  hopeTest
//
//  Created by 李明锋 on 2017/3/13.
//  Copyright © 2017年 limingfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKKeyValueStore.h"

@interface HPCacheService : NSObject

/**
 create a singleton object

 @return singleton object
 */
+ (instancetype)cacheManger;

/**
 cache array data into table

 @param array cache array
 @param arrayId id
 @param tableName tableName
 */
- (void)cacheArray:(NSArray *)array withId:(NSString *)arrayId intoTable:(NSString *)tableName;

/**
 get array data from table

 @param arrayId id
 @param tableName tableName
 @return array
 */
- (NSArray *)getArrayWithId:(NSString *)arrayId fromTable:(NSString *)tableName;

/**
 cache dictionary data into table

 @param infoDic cache dictionary
 @param dicId id
 @param tableName tableName
 */
- (void)cacheDictionay:(NSDictionary *)infoDic withId:(NSString *)dicId intoTable:(NSString *)tableName;

/**
 get dictionary data from table

 @param dicId id
 @param tableName tableName
 @return dictionary data
 */
- (NSDictionary *)getDictionaryWithId:(NSString *)dicId fromTable:(NSString *)tableName;

/**
 cache string

 @param string cache string data
 @param strId string ID
 @param tableName table name
 */
- (void)cacheString:(NSString *)string withId:(NSString *)strId intoTable:(NSString *)tableName;

/**
 get string data

 @param strId string ID
 @param tableName table name
 @return string data
 */
- (NSString *)getString:(NSString *)strId fromTable:(NSString *)tableName;

/**
 delete table through tableName

 @param tableName tableName
 @param flag if show delete result
 */
- (void)deleteTableWith:(NSString *)tableName withState:(BOOL)flag;
@end
