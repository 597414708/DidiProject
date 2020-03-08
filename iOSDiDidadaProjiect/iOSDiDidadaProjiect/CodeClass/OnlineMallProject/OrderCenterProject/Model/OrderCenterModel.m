//
//  OrderCenterModel.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "OrderCenterModel.h"

@implementation OrderCenterModel

+ (NSDictionary *)objectClassInArray {
    
    
    return @{
             // 这里的key必须和数据源字典中的key相同,后面的为包含的Model的类名
             @"indentList" : @"OrderCenterGoodsModel"
             };
    
}

@end
