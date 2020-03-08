//
//  OrderModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/24.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
///店铺id
@property (nonatomic, strong) NSString *shopId;

///店铺名称
@property (nonatomic, strong) NSString *shopName;

///店铺 Logo
@property (nonatomic, strong) NSString *shopLogo;

///服务内容
@property (nonatomic, strong) NSString *shopProject;

///开始时间
@property (nonatomic, strong) NSString *startTime;

///结束时间
@property (nonatomic, strong) NSString *endTime;

///预约内容
@property (nonatomic, strong) NSString *content;

///用户 Id
@property (nonatomic, strong) NSString *userId;

///用户名
@property (nonatomic, strong) NSString *userName;

///状态 0 预约中     1 已完成       -1 已取消
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString *id;


@end
