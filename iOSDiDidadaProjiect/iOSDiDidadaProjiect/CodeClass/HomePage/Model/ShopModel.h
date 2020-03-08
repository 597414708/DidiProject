//
//  ShopModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
/// 详细地址
@property (nonatomic, strong) NSString *address;

/// 反面
@property (nonatomic, strong) NSString *backImg;

/// 正面
@property (nonatomic, strong) NSString *indexImg;

/// 银行卡号
@property (nonatomic, strong) NSString *bankcard;

/// 营业执照
@property (nonatomic, strong) NSString *bussiness;

/// 市
@property (nonatomic, strong) NSString *city;

/// 区
@property (nonatomic, strong) NSString *country;

/// 店铺id
@property (nonatomic, strong) NSString *id;

/// 身份证号
@property (nonatomic, strong) NSString *idcard;

/// 经度
@property (nonatomic, strong) NSString *info1;

/// 纬度
@property (nonatomic, strong) NSString *info2;

/// 联系方式
@property (nonatomic, strong) NSString *info3;

/// 经营范围
@property (nonatomic, strong) NSString *info4;

///许可证
@property (nonatomic, strong) NSString *info5;

@property (nonatomic, strong) NSString *info6;

/// 距离
@property (nonatomic, strong) NSString *juli;

/// 店铺 logo
@property (nonatomic, strong) NSString *logo;

/// 手机号
@property (nonatomic, strong) NSString *mobile;

/// 店铺名字
@property (nonatomic, strong) NSString *name;

/// 省
@property (nonatomic, strong) NSString *province;

/// 真实姓名
@property (nonatomic, strong) NSString *realName;

/// 商家类型
@property (nonatomic, strong) NSString *shopType;

/// 营业开始时间
@property (nonatomic, strong) NSString *startTime;

/// 营业结束时间
@property (nonatomic, strong) NSString *endTime;

/// 服务内容
@property (nonatomic, strong) NSString *serviceProject;

@property (nonatomic, strong) NSString *verifyStatus;

@end
