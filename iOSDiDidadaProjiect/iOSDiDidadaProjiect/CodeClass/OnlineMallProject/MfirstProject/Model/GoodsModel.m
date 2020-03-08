//
//  GoodsModel.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "GoodsModel.h"
#import "CommentModel.h"
#import "ParamModel.h"

@implementation GoodsModel


+ (NSDictionary *)objectClassInArray {
    
    
    return @{
             // 这里的key必须和数据源字典中的key相同,后面的为包含的Model的类名
             @"evolutionList" : @"CommentModel",
             @"paramList" : @"ParamModel"
             
             };
    
}
@end
