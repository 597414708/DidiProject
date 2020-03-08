//
//  ArticleListModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleListModel : NSObject

///轮播图片
@property (nonatomic, copy) NSString *banner;

///内容
@property (nonatomic, copy) NSString *content;

///创建人头像
@property (nonatomic, copy) NSString *createHead;

///创建人名称
@property (nonatomic, copy) NSString *createName;

///文章id
@property (nonatomic, copy) NSString *id;

///封面图片
@property (nonatomic, copy) NSString *indexImg;

///简介
@property (nonatomic, copy) NSString *intro;

///标题
@property (nonatomic, copy) NSString *title;

///视频链接
@property (nonatomic, copy) NSString *video;

///发布时间
@property (nonatomic, copy) NSString *createDate;

@end
