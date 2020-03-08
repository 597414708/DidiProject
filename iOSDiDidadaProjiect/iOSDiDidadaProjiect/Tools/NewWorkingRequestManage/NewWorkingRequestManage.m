//
//  NewWorkingRequestManage.m
//  Created by 敲代码mac1号 on 16/7/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "NewWorkingRequestManage.h"


@implementation NewWorkingRequestManage

+ (NewWorkingRequestManage *)newWork {
    static  NewWorkingRequestManage *newWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        newWork = [[NewWorkingRequestManage alloc] init];
    });
    return newWork;
}


//GET请求
+ (void)requestGetWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];    //添加manager 配置信息
    [manager.requestSerializer setValue:[userDef objectForKey:@"Cookie"] forHTTPHeaderField:@"Token"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    [manager GET:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:nil animated:YES];

        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
        NSDictionary *dic = responseObject;
        NSString *code = [NSString stringWithFormat:@"%@", dic[@"code"]];
        NSDictionary *data = dic[@"data"];
        if ([code isEqualToString:@"1"]) {
            if ([[NSString stringWithFormat:@"%@", data.class] isEqualToString:@"NSNull"]) {
                return ;
            }
            finish(data);
        } else {
            NSString *message = [NSString stringWithFormat:@"%@", dic[@"message"]];
            if ([message isEqualToString:@"登录过期,请重新登录"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
            }
            [MBProgressHUD showMessage:message toView:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
        [MBProgressHUD hideHUDForView:nil animated:YES];
        if (error) {
            failure(error);
//            [MBProgressHUD showMessage:@"网络错误" toView:nil];
        }
    }];
}


///Login请求
+ (void)requestLoginPostWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    //添加manager 配置信息
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        finish(responseObject);
        
    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
//            [MBProgressHUD showMessage:@"系统错误" toView:nil];
            MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
            
            failure(error);
        }
    }];
}


///
+ (void)requestSSPostWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    [manager.requestSerializer setValue:[userDef objectForKey:@"Cookie"] forHTTPHeaderField:@"Token"];
    
    //添加manager 配置信息
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);

        NSDictionary *dic = responseObject;
        finish(responseObject);
        NSString *message = [NSString stringWithFormat:@"%@", dic[@"message"]];
        if ([message isEqualToString:@"登录过期,请重新登录"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
        }
        
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if (error) {
//                  [MBProgressHUD showMessage:@"系统错误" toView:nil];
                  MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
                  
                  failure(error);
              }
          }];
}


+ (void)requestPostWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    [manager.requestSerializer setValue:[userDef objectForKey:@"Cookie"] forHTTPHeaderField:@"Token"];


    //添加manager 配置信息
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:nil animated:YES];

        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
        NSDictionary *dic = responseObject;
        NSString *code = [NSString stringWithFormat:@"%@", dic[@"code"]];
        NSDictionary *data = dic[@"data"];
        if ([code isEqualToString:@"1"]) {
            if ([[NSString stringWithFormat:@"%@", data.class] isEqualToString:@"NSNull"]) {
                return ;
            }
            finish(data);
        } else {
            NSString *message = [NSString stringWithFormat:@"%@", dic[@"message"]];

            if ([message isEqualToString:@"登录过期,请重新登录"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
            }
            [MBProgressHUD showMessage:message toView:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:nil animated:YES];

        if (error) {
//            [MBProgressHUD showMessage:@"系统错误" toView:nil];
            MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
            failure(error);
        }
    }];
    
}



//PUT
+ (void)requestPUTWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //添加manager 配置信息
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager PUT:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
        NSDictionary *dic = responseObject;
        NSString *code = [NSString stringWithFormat:@"%@", dic[@"code"]];
        NSDictionary *data = dic[@"data"];
        if ([code isEqualToString:@"1"]) {
            finish(data);
        } else {
            finish(data);
            NSString *message = [NSString stringWithFormat:@"%@", dic[@"message"]];
            
            if ([message isEqualToString:@"登录过期,请重新登录"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
            }
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@", dic[@"message"]] toView:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
//
//            [MBProgressHUD showMessage:@"网络错误" toView:nil];

            failure(error);
        }
    }];
}


+ (void)requestDELETEWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //添加manager 配置信息
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager DELETE:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
        NSDictionary *dic = responseObject;
        NSString *code = [NSString stringWithFormat:@"%@", dic[@"code"]];
        NSDictionary *data = dic[@"data"];
        if ([code isEqualToString:@"1"]) {
            finish(data);
        } else {
            finish(data);

            [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@", dic[@"message"]] toView:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            MyLog(@"链接：%@\n请求参数%@",urlStr,dic);
//            [MBProgressHUD showMessage:@"网络错误" toView:nil];
            failure(error);
        }
    }];
}





@end
