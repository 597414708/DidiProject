//
//  InsuranceOrderModel.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "InsuranceOrderModel.h"

@implementation InsuranceOrderModel


+ (NSDictionary *)objectClassInArray {
    
    
    return @{
             // 这里的key必须和数据源字典中的key相同,后面的为包含的Model的类名
             @"coverageList" : @"CoverageModel"
             };
}

@end
