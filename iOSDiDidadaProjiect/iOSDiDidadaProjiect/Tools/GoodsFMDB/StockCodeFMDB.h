//
//  StockCodeFMDB.h
//  IOSStockProject
//
//  Created by 程磊 on 2017/8/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsFMDBmodel;
@interface StockCodeFMDB : NSObject

+ (StockCodeFMDB *)shareStockCodeFMDB;

// 插入对象
- (void)insertMessageSearchWithContent:(GoodsFMDBmodel *)content;

// 删除全部
- (void)deleteAllMessageSearch;

// 查询全部
- (NSMutableArray *)selectAllMessageSearch;

// 条件删除
- (void)deleteMessageWith:(NSString *)code;


- (void)deleteGoodWith:(NSString *)goodsid;


// 条件查询
- (NSMutableArray *)searchMessageModelWith:(NSString *)code;

// 修改
- (void)upDataMessageWith:(NSString *)code WithUpdata:(NSString *)count With:(NSString *)attribute;

@end
