//
//  FMDBHelper.m
//  IM
//
//  Created by 敲代码mac1号 on 16/6/14.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FMDBHelper.h"
#import "FMDB.h"
#import "MessageModel.h"

@interface FMDBHelper ()

// 声明一个数据库属性
// 因为执行增删改查都是使用数据库对象调用方法
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation FMDBHelper

static FMDBHelper *fMDBHelper;
static dispatch_once_t   onceToken;

+ (FMDBHelper *)shareFMDBHelper {
    dispatch_once(&onceToken, ^{
        fMDBHelper = [[FMDBHelper alloc] init];
        //创表
        [fMDBHelper creatMessageSearchTable];
    });
    return fMDBHelper;
}


// 数据库的懒加载
- (FMDatabase *)db {
    if (_db == nil) {
        self.db = [FMDatabase databaseWithPath:[self sqlitePath]];
    }
    return _db;
}


// 封装获取sqlite文件的路径
- (NSString *)sqlitePath {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    //[userDef objectForKey:USERSTORENA]
    NSString *filePath = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"M%@.sqlite", [userDef objectForKey:USERID]]];

    NSLog(@"%@", filePath);
    return filePath;
}

// 创建表的方法
// 插入数据, 修改数据, 删除数据 都使用executeUpdata
// 查询数据 用executeQuery

//[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil]
- (void)creatMessageSearchTable {
    // 1.打开数据库
    [self.db open];
    
    // 执行创建表的方法
    
    NSString *str = [NSString stringWithFormat:@"create table if not exists M%@(type text, content text, date text, title text, icon text, deletable text, target_url text, isRead text, msg_id text primary key, extra blob)", [userDef objectForKey:USERID]];
    BOOL result = [self.db executeUpdate:str];
    if (result) {
        NSLog(@"创表成功 或者 表以存在");
    }
    // .关闭数据库
    [self.db close];
}


// 插入对象
// 插入数据或者更改的时候, 数据的值, 使用对象类型, int->NSNumber
- (void)insertMessageSearchWithContent:(MessageModel *)content {
    [self.db open];
    NSLog(@"%@", content.extra);
    //执行插入
    
    NSString *str = [NSString stringWithFormat:@"insert into M%@(type, content, date, title, icon, deletable, target_url, isRead, msg_id, extra) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [userDef objectForKey:USERID]];
    NSLog(@"%@", str);
    BOOL result = [self.db executeUpdate:str, content.type, content.content, content.date, content.title, content.icon, content.deletable, content.target_url, content.isRead, content.msg_id, [NSJSONSerialization dataWithJSONObject:content.extra options:NSJSONWritingPrettyPrinted error:nil]];
    if (result) {
        NSLog(@"数据插入成功");
    } else {
        
    }
    [self.db close];
}


// 条件查询
- (NSMutableArray *)searchMessageModelWith:(NSString *)type {
    [self.db open];
    NSMutableArray *dataArray = [NSMutableArray array];
    // 执行查询
    // FMResultSet:结果集合, 地面都是满足你设置sql语句条件的数据, 可能为一条, 可能为多条
    
    NSString *str = [NSString stringWithFormat:@"select * from M%@ where type = ?", [userDef objectForKey:USERID]];
    FMResultSet *set = [self.db executeQuery:str,type];
    while ([set next]) {
        MessageModel *model = [[MessageModel alloc] init];
        NSString *type = [set objectForColumnName:@"type"];
        NSString *content = [set objectForColumnName:@"content"];
        NSString *nowDate = [set objectForColumnName:@"date"];
        NSString *userName = [set objectForColumnName:@"title"];
        NSString *deletable = [set objectForColumnName:@"deletable"];
        NSString *userIcon = [set objectForColumnName:@"icon"];
        NSString *target_url = [set objectForColumnName:@"target_url"];
        NSString *isRead = [set objectForColumnName:@"isRead"];
        NSString *msg_id = [set objectForColumnName:@"msg_id"];
        NSData *data = [set objectForColumnName:@"extra"];
        model.type = type;
        model.content = content;
        model.date = nowDate;
        model.title = userName;
        model.deletable = deletable;
        model.icon = userIcon;
        model.target_url = target_url;
        model.isRead = isRead;
        model.msg_id = msg_id;
        model.extra = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:NSJSONReadingMutableLeaves
                       error:nil];
        NSLog(@"%@", content);
        [dataArray addObject:model];
    }
    
    for (MessageModel *model in dataArray) {
        NSLog(@"%@", model.content);
        
    }
    
    [self.db close];
    return dataArray;
}


// 条件查询(已读未读)
- (NSMutableArray *)searchMessageModelWithRead:(NSString *)isread {
    [self.db open];
    NSMutableArray *dataArray = [NSMutableArray array];
    // 执行查询
    // FMResultSet:结果集合, 地面都是满足你设置sql语句条件的数据, 可能为一条, 可能为多条
    
    NSString *str = [NSString stringWithFormat:@"select * from M%@ where isRead = ?", [userDef objectForKey:USERID]];

    FMResultSet *set = [self.db executeQuery:str,isread];
    while ([set next]) {
        MessageModel *model = [[MessageModel alloc] init];
        NSString *type = [set objectForColumnName:@"type"];
        NSString *content = [set objectForColumnName:@"content"];
        NSString *nowDate = [set objectForColumnName:@"date"];
        NSString *userName = [set objectForColumnName:@"title"];
        NSString *deletable = [set objectForColumnName:@"deletable"];
        NSString *userIcon = [set objectForColumnName:@"icon"];
        NSString *target_url = [set objectForColumnName:@"target_url"];
        NSString *isRead = [set objectForColumnName:@"isRead"];
        NSString *msg_id = [set objectForColumnName:@"msg_id"];
        NSData *data = [set objectForColumnName:@"extra"];
        model.type = type;
        model.content = content;
        model.date = nowDate;
        model.title = userName;
        model.deletable = deletable;
        model.icon = userIcon;
        model.target_url =  target_url;
        model.isRead = isRead;
        model.msg_id = msg_id;
        model.extra = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:NSJSONReadingMutableLeaves
                       error:nil];
        NSLog(@"%@", content);

        [dataArray addObject:model];
    }
    
    [self.db close];
    return dataArray;
}



// 查询全部
- (NSMutableArray *)selectAllMessageSearch {
    [self.db open];
    NSMutableArray *dataArray = [NSMutableArray array];
    
    NSString *str = [NSString stringWithFormat:@"select * from M%@", [userDef objectForKey:USERID]];
    
    FMResultSet *set = [self.db executeQuery:str];
    while ([set next]) {
        MessageModel *model = [[MessageModel alloc] init];
        model.type = [set objectForColumnName:@"type"];
        model.content = [set objectForColumnName:@"content"];
        model.date = [set objectForColumnName:@"date"];
        model.title = [set objectForColumnName:@"title"];
        model.deletable = [set objectForColumnName:@"deletable"];
        model.icon = [set objectForColumnName:@"icon"];
        model.target_url = [set objectForColumnName:@"target_url"];
        model.isRead = [set objectForColumnName:@"isRead"];
        model.msg_id = [set objectForColumnName:@"msg_id"];
        NSData *data = [set objectForColumnName:@"extra"];
        model.extra = [NSJSONSerialization
                       JSONObjectWithData:data
                       options:NSJSONReadingMutableLeaves
                       error:nil];
        [dataArray addObject:model];
    }
    return dataArray;
}

// 删除全部
- (void)deleteAllMessageSearch {
    [self.db open];
    NSString *str = [NSString stringWithFormat:@"delete from M%@", [userDef objectForKey:USERID]];
  
    BOOL result = [self.db executeUpdate:str];
    if (result) {
        NSLog(@"删除成功");
    }
    [self.db close];
}


// 条件删除
- (void)deleteMessageWith:(NSString *)msg_id {
    [self.db open];
    
    NSString *str = [NSString stringWithFormat:@"delete from M%@ where msg_id = ?", [userDef objectForKey:USERID]];

    BOOL result = [self.db executeUpdate:str, msg_id];
    if (result) {
        NSLog(@"删除成功");
    }
    [self.db close];
}


// 修改
- (void)upDataMessageWith:(NSString *)msg_id WithUpdata:(NSString *)isRead {
    [self.db open];
    
    NSString *str = [NSString stringWithFormat:@"update M%@ set isRead = ? where msg_id = ?", [userDef objectForKey:USERID]];

    BOOL result = [self.db executeUpdate:str, isRead, msg_id];
    if (result) {
        NSLog(@"修改成功");
    }
    [self.db close];
}


+ (void)attempDealloc {
    onceToken = 0;
    // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    fMDBHelper = nil;
}


@end
