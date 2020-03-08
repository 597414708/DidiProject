//
//  MessageModel.h
//  GxHappyApp
//
//  Created by 敲代码mac1号 on 16/7/21.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//


/**
 *  Description
 *
 *  @param  type 消息的类型
 *  @param  userName   消息的发送者
 *  @param  target_url 跳转的页面
 *  @param  content    内容
 *  @param  nowDate    日期
 *  @param  userIcon   发送者的头像
 *  @param  deletable  能否删除
 *  @param  extra      拓展字典
 */
#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSString *target_url;

@property (nonatomic, copy) NSString *deletable;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *isRead;


@property (nonatomic , copy) NSString *msg_id;

@property (nonatomic , strong) NSDictionary *extra;




@end
