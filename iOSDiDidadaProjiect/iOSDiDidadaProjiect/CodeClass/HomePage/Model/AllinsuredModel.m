//
//  AllinsuredModel.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AllinsuredModel.h"

@implementation AllinsuredModel



- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
