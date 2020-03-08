//
//  PramCarModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/12.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PramCarModel : NSObject

///车牌号
@property (nonatomic, strong) NSString *licenseNo;


///车架号
@property (nonatomic, strong) NSString *frameNo;


///发动机号
@property (nonatomic, strong) NSString *engineNo;


///初登日期
@property (nonatomic, strong) NSString *firstRegisterDate;

@property (nonatomic, strong) NSString *isTrans;

@property (nonatomic, strong) NSString *transDate;

///品牌型号编码
@property (nonatomic, strong) NSString *brandCode;

///响应码
@property (nonatomic, strong) NSString *responseNo;


@end
