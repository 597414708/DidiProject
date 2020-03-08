//
//  PostModel.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "PostModel.h"

@implementation PostModel
+ (NSDictionary *)objectClassInArray {
    
    
    return @{
             // 这里的key必须和数据源字典中的key相同,后面的为包含的Model的类名
             @"data" : @"PostListModel"
             };
}
    
@end
