//
//  HelpManager.h
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/8/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "CarTypeModel.h"
#import "InsurancePostModel.h"

@interface HelpManager : NSObject <UIImagePickerControllerDelegate>
@property (nonatomic , assign) BOOL isNetWork;

@property (nonatomic , strong) id controller;
@property (nonatomic , copy) NSString *tag;

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , assign) BOOL isBinding;
@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) NSMutableArray *cityArray;

@property (nonatomic, strong) NSMutableArray *provincesArray;


@property (nonatomic, strong) CLPlacemark *starPlacemark;

@property (nonatomic, strong) CarTypeModel *carModel;

@property (nonatomic, strong) InsurancePostModel *postmodel;

@property (nonatomic, strong) NSString *carDetailType;

+ (HelpManager *)shareHelpManager;

+ (NSString *)md5HexDigest:(NSString *)url;

+ (NSString *)getDate:(NSString *)dateStr With:(NSString *)formatStr;

#warning
//判断是否开启通讯录
//+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block;


//判断是否有特殊字符
+ (BOOL)isHaveIllegalChar:(NSString *)str;

//判断是否有中文
+ (BOOL)IsChinese:(NSString *)str;

//按比例缩小图片
+ (UIImage *)scaleImage:(UIImage *)img toScale:(CGFloat )scale;

//按尺寸缩小图片
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;



//上传音频
+ (void)postAudioRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSString *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

//支付
+ (void)payWithOrder:(NSString *)orderNum WithType:(NSString *)type WithWeb:(UIWebView *)web;
+ (void)fenqipayWithOrder:(NSDictionary *)dic WithType:(NSString *)type WithWeb:(UIWebView *)web;

//分享
+ (void)shareTitle:(NSString *)title Content:(NSString *)content ImgUrl:(NSString *)imgUrl TargetUrl:(NSString *)targetUrl;


//判断是否是身份证号
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;


//验证车架号
+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber;

//验证车牌号
+ (BOOL) checkCarNumber:(NSString *) CarNumber;


+ (NSString *)getDateStr;

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color;


//上传图片
- (void)putImage:(UIImage *)image WithView:(UIView *)view finish:(void(^)(NSString* url))finish error:(void(^)(NSError *error))failure;

//上传视频

- (void)putVideo:(NSData *)data finish:(void(^)(NSString* url))finish error:(void(^)(NSError *error))failure;


//登录
+ (void)LogWithPram :(id)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure;

//获取当前时间
+ (NSString* )getCurrentTimestamp;


//判断是否开启定位
+ (BOOL)getLocata;

+ (NSString *)getDate:(NSString *)dateStr Withfromformat:(NSString *)fromformatStr Toformatt:(NSString *)toformatStr;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
