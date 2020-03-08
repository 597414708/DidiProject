//
//  BottomView.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/15.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (nonatomic, copy) void(^myBlock)();

+ (BottomView *) ShareBottomView;

@end
