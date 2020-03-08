//
//  StockCodeFMDB.m
//  IOSStockProject
//
//  Created by 程磊 on 2017/8/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "StockCodeFMDB.h"
#import "FMDB.h"
#import "GoodsFMDBmodel.h"

@interface StockCodeFMDB ()

// 声明一个数据库属性
// 因为执行增删改查都是使用数据库对象调用方法
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation StockCodeFMDB

static StockCodeFMDB *fMDBHelper;
static dispatch_once_t   onceToken;

+ (StockCodeFMDB *)shareStockCodeFMDB {
    dispatch_once(&onceToken, ^{
        fMDBHelper = [[StockCodeFMDB alloc] init];
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
    NSString *filePath = [doc stringByAppendingPathComponent:@"GoodsFMDBmodel.sqlite"];
    NSLog(@"%@", filePath);
    return filePath;
}

// 创建表的方法
// 插入数据, 修改数据, 删除数据 都使用executeUpdata
// 查询数据 用executeQuery

- (void)creatMessageSearchTable {
    // 1.打开数据库
    [self.db open];
    
    // 执行创建表的方法
    
    BOOL result = [self.db executeUpdate:@"create table if not exists GoodsFMDBmodel(shopid text, goodsid text primary key)"];

    if (result) {
        NSLog(@"创表成功 或者 表以存在");
    }
    // .关闭数据库
    [self.db close];
}


///shopid goodsid;
// 插入对象
// 插入数据或者更改的时候, 数据的值, 使用对象类型, int->NSNumber
- (void)insertMessageSearchWithContent:(GoodsFMDBmodel *)content {
    [self.db open];
    BOOL result = [self.db executeUpdate:@"insert into GoodsFMDBmodel(shopid, goodsid) values(?,?)", content.shopid, content.goodsid];
    
    if (result) {
        NSLog(@"数据插入成功");
        [MBProgressHUD hideHUDForView:nil animated:YES];

    } else {
        [MBProgressHUD hideHUDForView:nil animated:YES];

    }
    [self.db close];
}


// 条件查询
- (NSMutableArray *)searchMessageModelWith:(NSString *)code {
    [self.db open];
    NSMutableArray *dataArray = [NSMutableArray array];
    // 执行查询
    // FMResultSet:结果集合, 地面都是满足你设置sql语句条件的数据, 可能为一条, 可能为多条
    
    FMResultSet *set = [self.db executeQuery:@"select * from GoodsFMDBmodel where goodsid = ?",code];
    while ([set next]) {
        GoodsFMDBmodel *model = [[GoodsFMDBmodel alloc] init];
        NSString *goodsid = [set objectForColumn:@"goodsid"];
        NSString *shopid = [set objectForColumn:@"shopid"];
        model.shopid = shopid;
        model.goodsid = goodsid;
        [dataArray addObject:model];
    }
    
    [self.db close];
    return dataArray;
}




// 查询全部
- (NSMutableArray *)selectAllMessageSearch {
    [self.db open];
    NSMutableArray *dataArray = [NSMutableArray array];
    
    NSString *str = [NSString stringWithFormat:@"select * from %@", @"GoodsFMDBmodel"];
    
    FMResultSet *set = [self.db executeQuery:str];
    while ([set next]) {
        GoodsFMDBmodel *model = [[GoodsFMDBmodel alloc] init];
        model.shopid = [set objectForColumn:@"shopid"];
        model.goodsid = [set objectForColumn:@"goodsid"];
    
        [dataArray addObject:model];
    }
    [self.db close];
    return dataArray;
}

// 删除全部
- (void)deleteAllMessageSearch {
    [self.db open];
    NSString *str = [NSString stringWithFormat:@"delete from %@", @"GoodsFMDBmodel"];
    
    BOOL result = [self.db executeUpdate:str];
    if (result) {
        NSLog(@"删除成功");
    }
    [self.db close];
}


// 条件删除
- (void)deleteMessageWith:(NSString *)code {
    [self.db open];
    
    NSString *str = [NSString stringWithFormat:@"delete from %@ where shopid = ?", @"GoodsFMDBmodel"];
    
    BOOL result = [self.db executeUpdate:str, code];
    if (result) {
        NSLog(@"删除成功");
    }
    [self.db close];
}


- (void)deleteGoodWith:(NSString *)goodsid {
    [self.db open];
    
    NSString *str = [NSString stringWithFormat:@"delete from %@ where goodsid = ?", @"GoodsFMDBmodel"];
    
    BOOL result = [self.db executeUpdate:str, goodsid];
    if (result) {
        NSLog(@"删除成功");
        [MBProgressHUD hideHUDForView:nil animated:YES];

    } else {
        [MBProgressHUD hideHUDForView:nil animated:YES];

    }
    [self.db close];
}
    


// 修改  通过goodsid(code)  修改attribute(这个属性的值) 为count
- (void)upDataMessageWith:(NSString *)code WithUpdata:(NSString *)count With:(NSString *)attribute{
    [self.db open];
    
    NSString *str = [NSString stringWithFormat:@"update GoodsFMDBmodel set %@ = ? where goodsid = ?", attribute];
    
    BOOL result = [self.db executeUpdate:str, count, code];
    if (result) {
        NSLog(@"修改成功");
    }
    [self.db close];
}



@end
