//
//  MessageModel.m
//  GxHappyApp
//
//  Created by 敲代码mac1号 on 16/7/21.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.content = [NSString stringWithFormat:@"%@",keyedValues[@"content"]];
    self.date = [NSString stringWithFormat:@"%@",keyedValues[@"date"]];
    self.deletable = [NSString stringWithFormat:@"%@",keyedValues[@"deletable"]];
    self.icon = [NSString stringWithFormat:@"%@",keyedValues[@"icon"]];
    self.target_url = [NSString stringWithFormat:@"%@",keyedValues[@"target_url"]];
    self.title = [NSString stringWithFormat:@"%@",keyedValues[@"title"]];
    self.type = [NSString stringWithFormat:@"%@",keyedValues[@"type"]];
    
    self.msg_id = [NSString stringWithFormat:@"%@", keyedValues[@"msg_id"]];
    if ([self.msg_id isEqualToString:@"<null>"]) {
        self.msg_id = @"1231231231";
    }
    self.isRead = @"0";
    NSString *str = [NSString stringWithFormat:@"%@", keyedValues[@"extra"]];
  
    if ([str isEqualToString:@"<null>"]) {
        self.extra = @{@"123":@"2313"};
    } else {
        self.extra = keyedValues[@"extra"];
    }
    
    
}





@end
