//
//  CarInforModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/27.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInforModel : NSObject

///车辆id
@property (nonatomic, strong) NSString *id;

///用户id
@property (nonatomic, strong) NSString *userId;

///车牌号
@property (nonatomic, strong) NSString *licenseNo;

///品牌型号
@property (nonatomic, strong) NSString *brand;

///车架号
@property (nonatomic, strong) NSString *carVin;

///发动机号
@property (nonatomic, strong) NSString *engineNo;


///注册时间
@property (nonatomic, strong) NSString *regTime;

///是否过户车
@property (nonatomic, assign) NSInteger transfer;

///过户时间
@property (nonatomic, strong) NSString *transferTime;

///驾驶证正面
@property (nonatomic, strong) NSString *info1;

@end
