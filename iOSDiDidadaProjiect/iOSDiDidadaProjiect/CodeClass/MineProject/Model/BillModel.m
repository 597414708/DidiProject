//
//  BillModel.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "BillModel.h"

@implementation BillModel

+ (NSDictionary *)objectClassInArray {
    
    
    return @{
             // 这里的key必须和数据源字典中的key相同,后面的为包含的Model的类名
             @"list" : @"BillListModel"
             };
    
}

@end
