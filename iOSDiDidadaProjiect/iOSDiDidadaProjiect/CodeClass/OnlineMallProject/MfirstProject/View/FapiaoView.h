//
//  FapiaoView.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2018/1/25.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FapiaoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *noFapiao;

@property (weak, nonatomic) IBOutlet UIButton *fapiaoBtn;

@property (weak, nonatomic) IBOutlet UITextField *firstTf;
@property (weak, nonatomic) IBOutlet UITextField *secondTf;

@property (weak, nonatomic) IBOutlet UIButton *personalBt;

@property (weak, nonatomic) IBOutlet UIButton *danweiBt;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, copy) void(^myBlock)(NSMutableArray *sender);
+ (FapiaoView *)shareFapiaoView;
@end
