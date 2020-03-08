//
//  UserModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/24.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

///用户id
@property (nonatomic, strong) NSString *id;

//身份证号
@property (nonatomic, strong) NSString *idCard;

//身份证反面
@property (nonatomic, strong) NSString *idCardBack;

//身份证正面
@property (nonatomic, strong) NSString *idCardIndex;

//行驶证反面
@property (nonatomic, strong) NSString *licenseBack;

//行驶证正面
@property (nonatomic, strong) NSString *licenseIndex;

//电话
@property (nonatomic, strong) NSString *mobile;

//昵称
@property (nonatomic, strong) NSString *nickName;

//头像
@property (nonatomic, strong) NSString *userHead;


@property (nonatomic, strong) NSString *totalMoney;


@property (nonatomic, strong) NSString *level;

//代理级别名称
@property (nonatomic, strong) NSString *levelName;

//代理名称
@property (nonatomic, strong) NSString *name;

//
@property (nonatomic, strong) NSString *number;



@end
