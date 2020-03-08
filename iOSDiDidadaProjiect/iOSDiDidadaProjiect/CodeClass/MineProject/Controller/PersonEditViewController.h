//
//  PersonEditViewController.h
//  IOSSumgoTeaProject
//
//  Created by 翁武勇 on 16/11/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonEditViewController : UIViewController

@property(nonatomic,strong)void(^Editblock)(NSString *string);
@property(nonatomic,assign)BOOL isTel;
@property(nonatomic,assign)NSInteger numLimit;//字数限制
@property(nonatomic,assign)BOOL isAllowEmpty;//是否可以为空

@property (nonatomic,strong)NSString *strContent;

@property (nonatomic,strong)NSString *strPlaceHolder;
@property (nonatomic,strong)UITextField *tfEdit;


@property (nonatomic,strong)NSMutableDictionary *mudic;

@property (nonatomic, assign) NSInteger type;

@end
