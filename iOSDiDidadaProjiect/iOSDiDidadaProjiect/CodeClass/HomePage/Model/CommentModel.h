//
//  CommentModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/24.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

///内容
@property (nonatomic, strong) NSString *content;

///评价id
@property (nonatomic, strong) NSString *id;

///用户头像
@property (nonatomic, strong) NSString *userHead;

///用户id
@property (nonatomic, strong) NSString *userId;

///用户姓名
@property (nonatomic, strong) NSString *userName;



@end
