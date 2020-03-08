//
//  BaojiaModel.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/1.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaModel.h"

@implementation BaojiaModel


+ (NSDictionary *)objectClassInArray {
    
    
    return @{
             // 这里的key必须和数据源字典中的key相同,后面的为包含的Model的类名
             @"priceList" : @"PriceListModel"
             };
}


@end
