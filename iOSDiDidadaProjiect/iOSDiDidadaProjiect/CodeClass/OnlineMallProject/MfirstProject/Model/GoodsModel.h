//
//  GoodsModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject



///轮播图
@property (nonatomic, copy) NSString *goodsBanner;
@property (nonatomic, copy) NSString *goodsDetail;

///展示图
@property (nonatomic, copy) NSString *goodsImg;

///描述",//描述
@property (nonatomic, copy) NSString *goodsInfo;

///简介 简介
@property (nonatomic, copy) NSString *goodsIntro;
@property (nonatomic, copy) NSString *goodsProfit;

///分类 id
@property (nonatomic, copy) NSString *goodsType;

///商品 id
@property (nonatomic, copy) NSString *id;

///商品名称
@property (nonatomic, copy) NSString *name;

///剩余数
@property (nonatomic, copy) NSString *onsale;

///包邮规则 I
@property (nonatomic, copy) NSString *postId;

///价格
@property (nonatomic, copy) NSString *price;

///销量
@property (nonatomic, copy) NSString *sale;

///
@property (nonatomic, copy) NSString *saleStatus;

///是否加入购物车
@property (nonatomic, assign) NSInteger tag;

///数量
@property (nonatomic, assign) NSInteger num;

///评价数组
@property (nonatomic, strong) NSMutableArray *evolutionList;

///参数数组
@property (nonatomic, strong) NSMutableArray *paramList;



@end
