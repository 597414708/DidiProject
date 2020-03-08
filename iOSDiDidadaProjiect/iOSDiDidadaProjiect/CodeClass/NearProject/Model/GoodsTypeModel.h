//
//  GoodsTypeModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsTypeModel : NSObject

//商品类别id
@property (nonatomic, strong) NSString *id;

//商铺id
@property (nonatomic, strong) NSString *shopId;

//店铺名称
@property (nonatomic, strong) NSString *shopName;

//
@property (nonatomic, strong) NSString *typeImg;

//类别名称
@property (nonatomic, strong) NSString *typeName;

//是否选中
@property (nonatomic, strong) NSString *tag;


@end
