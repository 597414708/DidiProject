//
//  HelpManager.m
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/8/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "HelpManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "UMSocial.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "AppDelegate.h"
#import <AddressBookUI/AddressBookUI.h>
#import <CommonCrypto/CommonHMAC.h>
#import "SheetAlertView.h"
#import "UMSocialWechatHandler.h"


#define LogStr @"http://uc.dev.xmmodo.com/token"


@interface HelpManager () 


@end

@implementation HelpManager



- (InsurancePostModel *)postmodel {
    if (!_postmodel) {
        self.postmodel = [[InsurancePostModel alloc] init];
    }
    return _postmodel;
}

- (NSDateFormatter *)formatter {
    if(!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";// twitter date format
    }
    return _formatter;
}

+ (HelpManager *)shareHelpManager {
    static HelpManager *helpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helpManager = [[HelpManager alloc] init];
    });
    return helpManager;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        self.cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)provincesArray {
    if (!_provincesArray) {
        self.provincesArray = [NSMutableArray array];
    }
    return _provincesArray;
}

+ (void)payWithOrder:(NSString *)orderNum WithType:(NSString *)type WithWeb:(UIWebView *)web{
    NSDictionary *dic = @{@"orderNo":orderNum};

    if ([type isEqualToString:@"1"]) {
        //支付宝
        [NewWorkingRequestManage requestGetWith:Alipay parDic:dic finish:^(id responseObject) {
            [MBProgressHUD hideHUDForView:nil animated:YES];

            NSString *orderString = responseObject;
            NSString *appScheme = @"didiProject";
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"支付的结果:*********reslut = %@",resultDic);
                NSString *result = [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
                if ([result isEqualToString:@"9000"]) {

                    return;
                }else {
                    //支付失败 返回
                }
            }];
        } error:^(NSError *error) {
            [MBProgressHUD hideHUDForView:nil animated:YES];

        }];
    }
    
    if ([type isEqualToString:@"0"]) {
        //微信
        [NewWorkingRequestManage requestGetWith:WXpay parDic:dic finish:^(id responseObject) {
            [MBProgressHUD hideHUDForView:nil animated:YES];

            NSDictionary *json = responseObject;
            NSLog(@"%@", json);
            PayReq *request = [[PayReq alloc] init] ;
            request.partnerId = [NSString stringWithFormat:@"%@", json[@"partnerid"]];
            request.prepayId = [NSString stringWithFormat:@"%@", json[@"prepayid"]];
            request.package = [NSString stringWithFormat:@"%@", json[@"package"]];
            request.nonceStr= [NSString stringWithFormat:@"%@", json[@"noncestr"]];
            request.timeStamp = [[NSString stringWithFormat:@"%@", json[@"timestamp"]] intValue];
            request.sign = [NSString stringWithFormat:@"%@", json[@"sign"]];
            BOOL isPay =  [WXApi sendReq:request];
            if (isPay) {

            }
            
        } error:^(NSError *error) {
            [MBProgressHUD hideHUDForView:nil animated:YES];

        }];
    }
}



+ (void)fenqipayWithOrder:(NSDictionary *)dic WithType:(NSString *)type WithWeb:(UIWebView *)web{
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    if ([type isEqualToString:@"1"]) {
        //支付宝
        [NewWorkingRequestManage requestGetWith:FenqiAlipay parDic:dic finish:^(id responseObject) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
            
            NSString *orderString = responseObject;
            NSString *appScheme = @"didiProject";
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"支付的结果:*********reslut = %@",resultDic);
                NSString *result = [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
                if ([result isEqualToString:@"9000"]) {
                    
                    return;
                }else {
                    //支付失败 返回
                }
            }];
        } error:^(NSError *error) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
            
        }];
    }
    
    if ([type isEqualToString:@"0"]) {
        //微信
        [NewWorkingRequestManage requestGetWith:FenqiWXpay parDic:dic finish:^(id responseObject) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
            
            NSDictionary *json = responseObject;
            NSLog(@"%@", json);
            PayReq *request = [[PayReq alloc] init] ;
            request.partnerId = [NSString stringWithFormat:@"%@", json[@"partnerid"]];
            request.prepayId = [NSString stringWithFormat:@"%@", json[@"prepayid"]];
            request.package = [NSString stringWithFormat:@"%@", json[@"package"]];
            request.nonceStr= [NSString stringWithFormat:@"%@", json[@"noncestr"]];
            request.timeStamp = [[NSString stringWithFormat:@"%@", json[@"timestamp"]] intValue];
            request.sign = [NSString stringWithFormat:@"%@", json[@"sign"]];
            BOOL isPay =  [WXApi sendReq:request];
            if (isPay) {
                
            }
            
        } error:^(NSError *error) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
            
        }];
    }
}
//MD5加密算法
+ (NSString *)md5HexDigest:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}



+ (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)@_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location < str.length;
}


+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X|x)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"] && ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

//判断是否有中文
+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}



//车架号判断
+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber{
    NSString *bankNum=@"^(\\D{17})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}

#pragma mark -- 车牌号验证
+ (BOOL) checkCarNumber:(NSString *) CarNumber{
    NSString *CarkNum = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarkNum];
    BOOL isMatch = [pred evaluateWithObject:CarNumber];
    return isMatch;
}




+ (NSString *)getDate:(NSString *)dateStr With:(NSString *)formatStr {
    if (!dateStr) {
        return @"";
    }
    
    
    if ([[NSString stringWithFormat:@"%@", dateStr.class] isEqualToString:@"NSNull"]) {
        return @"无";
    }
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
    NSDateFormatter *DATEFormatter = [[NSDateFormatter alloc] init];
    [DATEFormatter setDateFormat:formatStr];
    NSString *getdateStr = [DATEFormatter stringFromDate:confromTimesp];
    return getdateStr;
}

+ (NSString *)getDate:(NSString *)dateStr Withfromformat:(NSString *)fromformatStr Toformatt:(NSString *)toformatStr {

    NSDateFormatter *fromFormatter = [[NSDateFormatter alloc] init];
    [fromFormatter setDateFormat:fromformatStr];
    
    NSDate *fromdete = [fromFormatter dateFromString:dateStr];
    
    NSDateFormatter *toFormatter = [[NSDateFormatter alloc] init];
    [toFormatter setDateFormat:toformatStr];
    
    NSString *getdateStr = [toFormatter stringFromDate:fromdete];
    return getdateStr;
}



//按比例缩小图片
+ (UIImage *)scaleImage:(UIImage *)img toScale:(CGFloat )scale {
    CGSize imgSize = img.size;
    CGSize scaleSize = CGSizeMake(imgSize.width*scale, imgSize.height*scale);
    
    UIGraphicsBeginImageContext(scaleSize);
    [img drawInRect:CGRectMake(0, 0, imgSize.width*scale, imgSize.height*scale)];
    
    UIImage * scaleImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImg;
}

//按尺寸缩小图片
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  上传多张图片
 *
 *  @param url     接口地址
 *  @param params  上传的参数
 *  @param file    图片数组
 *  @param name    图片传@"image"/
 *  @param success 成功block
 *  @param failure 失败block
 */

//+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
//{
//    //创建管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    //发起请求
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSInteger ID = 100;
//        //将UIImage转换为NSData
//        for (UIImage *images in file) {
//            //压缩比例
//            NSData *data = UIImageJPEGRepresentation(images, 0.01);
//            [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%ld.jpg",(long)ID] mimeType:@"image/jpeg"];
//            ID++;
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //上传进度
//        MyLog(@"%lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MyLog(@"%@", responseObject);
//        if (success) {
//            if ([responseObject isKindOfClass:[NSData class]]) {
//                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                success(result);
//            } else {
//                success(responseObject);
//            }
//        }
//        //上传成功
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //上传失败
//        if (failure) {
//            failure(error);
//        }
//    }];
//    //添加到操作队列
//}


//上传音频文件
+ (void)postAudioRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSString *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure {
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //发起请求
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfFile:file];
        [formData appendPartWithFileData:data name:name fileName:@"mp3" mimeType:@"audio/mpeg3"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        MyLog(@"%lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"%@", responseObject);
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(result);
            } else {
                success(responseObject);
            }
        }
        //上传成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        if (failure) {
            failure(error);
        }
    }];
    //添加到操作队列
}


+ (void)shareTitle:(NSString *)title Content:(NSString *)content ImgUrl:(NSString *)imgUrl TargetUrl:(NSString *)targetUrl {
    if (imgUrl.length == 0) {
        imgUrl = @"http://youchalian.com/shanguoyinyi/www/img/share-icon.png";
    }

    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeWeb url:
                                        targetUrl];
    
    [UMSocialData defaultData].extConfig.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = targetUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = targetUrl;
    ShareView *share = [ShareView shareViewQQShare:^{
        MyLog(@"QQ分享");
        
    } WeiChatShare:^{
        MyLog(@"微信分享");
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:content image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]] location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                MyLog(@"分享成功！");
            }
        }];
    } WeiBoShare:^{
        MyLog(@"微博分享");
        
    } FriendShare:^{
        MyLog(@"朋友圈分享");
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]] location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                MyLog(@"分享成功！");
            }
        }];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:share];
}


//上传图片

- (void)putImage:(UIImage *)image WithView:(UIView *)view finish:(void(^)(NSString* url))finish error:(void(^)(NSError *error))failure {
    
    [NewWorkingRequestManage requestGetWith:GetQiNiuToken parDic:nil finish:^(id responseObject) {
       UIImage *sssImage =  [self compressImage:image toTargetWidth:ImageTheW];
        NSString *token = [NSString stringWithFormat:@"%@", responseObject[@"token"]];
        NSData *data = UIImageJPEGRepresentation(sssImage, 1);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *timeStr = [NSString stringWithFormat:@"%@%d.png", [formatter stringFromDate:[NSDate date]], arc4random() % 1000] ;
        QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
            builder.zone = [QNZone zone2];
        }];
        QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
        [upManager putData:data key:timeStr token:token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      [MBProgressHUD hideHUDForView:view animated:YES];

                      if (info.statusCode == 200) {
                          [MBProgressHUD showMessage:@"上传成功" toView:nil];
                          NSString *url = [NSString stringWithFormat:@"%@%@", upLoadUserIamge, key];
                          finish(url);
                      } else {
                          [MBProgressHUD showMessage:@"上传失败" toView:nil];
                      }
                      
                      
                      
                  } option:nil];
    } error:^(NSError *error) {
        NSLog(@"%@", error);
        failure(error);
        [MBProgressHUD hideHUDForView:view animated:YES];
        NSLog(@"%@", GetQiNiuToken);
        [MBProgressHUD showMessage:@"上传失败" toView:nil];
    }];
}

//上传视频
- (void)putVideo:(NSData *)data finish:(void(^)(NSString* url))finish error:(void(^)(NSError *error))failure {
//    [NewWorkingRequestManage requestGetWith:GetQiNiuToken parDic:nil finish:^(id responseObject) {
//        NSString *token = [NSString stringWithFormat:@"%@", responseObject[@"uptoken"]];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *timeStr = [NSString stringWithFormat:@"%@.mp4", [formatter stringFromDate:[NSDate date]]] ;
//        QNUploadManager *upManager = [[QNUploadManager alloc] init];
//        [upManager putData:data key:timeStr token:token
//                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                      [self.hud hide:YES];
//                      NSString *url = [NSString stringWithFormat:@"%@%@", upLoadUserIamge, key];
//                      finish(url);
////                      [MBProgressHUD showMessage:@"上传成功" toView:nil];
//                  } option:nil];
//    } error:^(NSError *error) {
//        failure(error);
//        [self.hud hide:YES];
//        [MBProgressHUD showMessage:@"上传失败" toView:nil];
//    }];

}



+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




+ (NSString *)getDateStr {
    NSString *str = [NSString stringWithFormat:@"%.lf", [[NSDate date] timeIntervalSince1970] * 1000];
    return  str;
}


//获取当前时间戳
+ (NSString* )getCurrentTimestamp{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
    
}


//计算字符串字符长度，一个汉字算两个字符
-(NSUInteger) unicodeLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++)
    {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

+ (void)LogWithPram:(id)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    //添加manager 配置信息
    
    [manager POST:LogStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
}


+ (BOOL)getLocata {
    BOOL flag;
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        flag = NO;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"打开[定位服务]来允许[嘀嘀]确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置" , nil];
        alertView.delegate = self;
        alertView.tag = 1;
        [alertView show];
    } else {
        flag = YES;
    }
    
    return flag;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
