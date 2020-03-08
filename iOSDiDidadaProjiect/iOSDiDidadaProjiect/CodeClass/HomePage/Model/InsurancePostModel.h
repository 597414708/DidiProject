//
//  InsurancePostModel.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/30.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsurancePostModel : NSObject

///车牌号
@property (nonatomic, strong) NSString *licenseNo;

///车主姓名
@property (nonatomic, strong) NSString *carOwnersName;

///车主证件号
@property (nonatomic, strong) NSString *idCard;

///车主手机号(选)
@property (nonatomic, strong) NSString *carOwnerMobile;


///车主证件类型 1身份证
@property (nonatomic, strong) NSString *ownerIdCardType;

///需要报价的 保险资源的枚举值之和
@property (nonatomic, strong) NSString *quoteGroup;

///需要核保的
@property (nonatomic, strong) NSString *submitGroup;

///被保险人姓名
@property (nonatomic, strong) NSString *insuredName;

///被保险人证件号
@property (nonatomic, strong) NSString *insuredIdCard;

///被保险人证件类型 1身份证
@property (nonatomic, strong) NSString *insuredIdType;

///被保险人手机号;
@property (nonatomic, strong) NSString *insuredMobile;

///投保人姓名
@property (nonatomic, strong) NSString *holderName;

///投保人证件号
@property (nonatomic, strong) NSString *holderIdCard;

///投保人证件类型
@property (nonatomic, strong) NSString *holderIdType;

///投保人手机号
@property (nonatomic, strong) NSString *holderMobile;

///城市编码
@property (nonatomic, strong) NSString *cityCode;

///发动机号
@property (nonatomic, strong) NSString *engineNo;

///车架号
@property (nonatomic, strong) NSString *carVin;

///注册日期
@property (nonatomic, strong) NSString *registerDate;

///品牌型号
@property (nonatomic, strong) NSString *moldName;

///0:单商业 ，1：商业+交强车船，2：单交强+车船
@property (nonatomic, strong) NSString *forceTax;

///玻璃单独破碎险，0-不投保，1国产，2进口
@property (nonatomic, assign) NSInteger boLi;

///不计免赔险(车损) ，0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianCheSun;

///不计免赔险(盗抢) ，0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianDaoQiang;

///不计免赔险(三者) ，0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianSanZhe;

///不计免乘客0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianChengKe;

///不计免司机0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianSiJi;

///不计免划痕0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianHuaHen;

///不计免涉水0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianSheShui;

///不计免自燃0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianZiRan;

///不计免精神损失0-不投保，1投保
@property (nonatomic, assign) NSInteger buJiMianJingShenSunShi;

///涉水行驶损失险，0-不投保，1投保
@property (nonatomic, assign) NSInteger sheShui;

///车身划痕损失险，0-不投保，>0投保(具体金额)
@property (nonatomic, assign) NSInteger huaHen;

///车上人员责任险(司机) ，0-不投保，>0投保(具体金额）
@property (nonatomic, assign) NSInteger siJi;

///车上人员责任险(乘客) ，0-不投保，>0投保(具体金额)
@property (nonatomic, assign) NSInteger chengKe;

///机动车损失保险，0-不投保，1-投保
@property (nonatomic, assign) NSInteger cheSun;

///全车盗抢保险，0-不投保，1-投保
@property (nonatomic, assign) NSInteger daoQiang;

///第三者责任保险，0-不投保，>0投保(具体金额)
@property (nonatomic, assign) NSInteger sanZhe;

///自燃损失险，0-不投保，1投保
@property (nonatomic, assign) NSInteger ziRan;

///过户时间
@property (nonatomic, strong) NSString *transferDate;

///机动车损失保险无法找到第三方特约险（0:不投，1：投保）(前提必须上车损险)
@property (nonatomic, assign) NSInteger hcSanFangTeYue;

///指定修理厂险（0:不投，>0：保额）国产0.1-0.3 进口0.15-0.6
@property (nonatomic, assign) NSInteger hcXiuLiChang;

///指定专修厂类型 -1没有 国产0 进口1
@property (nonatomic, assign) NSInteger hcXiuLiChangType;

///报价并发冲突检查标识：0（默认） 1：检测。
@property (nonatomic, assign) NSInteger quoteParalelConflict;

///Agent调用平台标识
@property (nonatomic, strong) NSString *agent;

///除了SecCode参数之外的所有参数拼接后再加密钥的字符串后的MD5值（32位小写）（壁虎提供）
@property (nonatomic, strong) NSString *secCode;

///商业险起保日期
@property (nonatomic, strong) NSString *bizTimeStamp;

//核定载客量
@property (nonatomic, strong) NSString *seatCount;

//购置价格
@property (nonatomic, strong) NSString *purchasePrice;

//精友编码
@property (nonatomic, strong) NSString *autoMoldCode;

//排气量
@property (nonatomic, strong) NSString *exhaustScale;

///交强险起保时间
@property (nonatomic, strong) NSString *forceTimeStamp;

@property (nonatomic, strong) NSString *renewalCarType;

@end
