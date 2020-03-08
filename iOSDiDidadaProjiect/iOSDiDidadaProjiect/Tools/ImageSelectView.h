//
//  ImageSelectView.h
//  IOSSumgoTeaProject
//
//  Created by 翁武勇 on 16/11/23.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^imageSelectOver)(BOOL isCamera);

@interface ImageSelectView : UIView
@property (strong,nonatomic) UIView *mainView;
@property (copy,nonatomic) imageSelectOver doneBlock;

@end
