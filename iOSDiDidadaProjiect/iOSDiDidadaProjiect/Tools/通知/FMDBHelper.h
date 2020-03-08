//
//  FMDBHelper.h
//  IM
//
//  Created by 敲代码mac1号 on 16/6/14.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageModel;
@interface FMDBHelper : NSObject

+ (FMDBHelper *)shareFMDBHelper;

// 插入对象
- (void)insertMessageSearchWithContent:(MessageModel *)content;

// 删除全部
- (void)deleteAllMessageSearch;

// 查询全部
- (NSMutableArray *)selectAllMessageSearch;

// 条件删除
- (void)deleteMessageWith:(NSString *)nowDate;

// 条件查询
- (NSMutableArray *)searchMessageModelWith:(NSString *)nowDate;


// 条件查询 (已读未读)
- (NSMutableArray *)searchMessageModelWithRead:(NSString *)isread;

// 修改
- (void)upDataMessageWith:(NSString *)date WithUpdata:(NSString *)isRead;


+ (void)attempDealloc;
@end
