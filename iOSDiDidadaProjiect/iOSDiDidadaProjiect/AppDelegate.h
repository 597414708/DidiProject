//
//  AppDelegate.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
/***  是否允许横屏的标记 */
@property (nonatomic,assign)BOOL allowRotation;

@property (nonatomic, copy) void(^alipayBlock)(BOOL staute);

@property (nonatomic, copy) void(^WXpayBlock)(BOOL staute);

- (void)saveContext;


@end

