//
//  AddressDataModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/28.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressDataModel : NSObject

///详细地址
@property (nonatomic, copy) NSString *address;

///市
@property (nonatomic, copy) NSString *city;

///区
@property (nonatomic, copy) NSString *country;

///地址id
@property (nonatomic, copy) NSString *id;

///附加信息
@property (nonatomic, copy) NSString *info1;

///默认地址1   0
@property (nonatomic, assign) NSInteger isdef;

///电话
@property (nonatomic, copy) NSString *mobile;

///姓名
@property (nonatomic, copy) NSString *name;

///省
@property (nonatomic, copy) NSString *province;

///用户id
@property (nonatomic, copy) NSString *userId;


@end
