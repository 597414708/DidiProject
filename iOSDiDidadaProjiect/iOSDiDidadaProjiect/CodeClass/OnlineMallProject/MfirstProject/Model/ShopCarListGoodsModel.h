//
//  ShopCarListGoodsModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/2.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarListGoodsModel : NSObject

@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsImg;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *goodsName;


@property (nonatomic, assign) BOOL select;


@end
