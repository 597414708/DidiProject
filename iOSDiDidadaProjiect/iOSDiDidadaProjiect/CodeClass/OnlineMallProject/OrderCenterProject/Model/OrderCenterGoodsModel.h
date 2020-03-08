//
//  OrderCenterGoodsModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/8.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderCenterGoodsModel : NSObject

@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsImg;
@property (nonatomic, strong) NSString *goodsIntro;
@property (nonatomic, strong) NSString *goodsMoney;
@property (nonatomic, strong) NSString *goodsName;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *indentId;

@end
