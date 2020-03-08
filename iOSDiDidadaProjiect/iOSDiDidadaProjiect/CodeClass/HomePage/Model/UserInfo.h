//
//  UserInfo.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/26.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

///精友码（续保成功，也有可能是空）
@property (nonatomic, strong) NSString *autoMoldCode;

///商业险保单号
@property (nonatomic, strong) NSString *bizNo;

///商业险到期日期
@property (nonatomic, strong) NSString *businessExpireDate;

///车辆使用性质 报价的时候 ，仅支持 1,2,3三种情形。 如果是公车，CarUsedType=2或者3. 如果是私车，CarUsedType=1.
@property (nonatomic, strong) NSString *carUsedType;

///车架号
@property (nonatomic, strong) NSString *carVin;

///城市编码
@property (nonatomic, strong) NSString *cityCode;

///证件号码(车主本人)
@property (nonatomic, strong) NSString *credentislasNum;

///发动机号
@property (nonatomic, strong) NSString *engineNo;

///交强险到期时间
@property (nonatomic, strong) NSString *forceExpireDate;

///交强险保单号
@property (nonatomic, strong) NSString *forceNo;

///投保人证件号
@property (nonatomic, strong) NSString *holderIdCard;

///投保人联系方式（空，取不到）
@property (nonatomic, strong) NSString *holderMobile;

///证件类型
@property (nonatomic, strong) NSString *idType;

///被保险人证件号
@property (nonatomic, strong) NSString *insuredIdCard;

///被保人证件类型 //1：身份证  2:组织机构代码证  3护照  4军官证  5港澳居民来往内地通行证  6其他  7港澳通行证
@property (nonatomic, strong) NSString *insuredIdType;

///被保险人手机号
@property (nonatomic, strong) NSString *insuredMobile;

///被保险人姓名
@property (nonatomic, strong) NSString *insuredName;

///车牌号
@property (nonatomic, strong) NSString *licenseNo;

///车主姓名
@property (nonatomic, strong) NSString *licenseOwner;

///品牌型号
@property (nonatomic, strong) NSString *modleName;

///下年的商业险起保日期
@property (nonatomic, strong) NSString *nextBusinessStartDate;

@property (nonatomic, strong) NSString *businessStartDate;

///下年的交强起保日期
@property (nonatomic, strong) NSString *nextForceStartDate;

@property (nonatomic, strong) NSString *forceStartDate;

///组织机构名称
@property (nonatomic, strong) NSString *organization;

///投保人
@property (nonatomic, strong) NSString *postedName;

///购置价格
@property (nonatomic, strong) NSString *purchasePrice;

///初登日期(注册日期)
@property (nonatomic, strong) NSString *registerDate;

///行驶区域 1：境内 2：本省内 3：其他
@property (nonatomic, strong) NSString *runRegion;

///核定载客量
@property (nonatomic, strong) NSString *seatCount;

@end
