//
//  ZYInputAlertFieldView.m
//  share
//
//  Created by 郑遥 on 16/6/23.
//  Copyright © 2016年 郑遥. All rights reserved.
//

#import "ZYInputAlertFieldView.h"
#import "UITextView+Placeholder.h"
#define TopWindow [UIApplication sharedApplication].keyWindow

@interface ZYInputAlertFieldView ()

/** 确认按钮回调 */
@property (nonatomic, copy) confirmCallback confirmBlock;
/** 蒙版 */
@property (nonatomic, weak) UIView *becloudView;

@end

@implementation ZYInputAlertFieldView

+ (instancetype)alertView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setBtnDisabled];
    [self setCornerRadius:self];
    [self setCornerRadius:self.inputTextView];
    [self setCornerRadius:self.confirmBtn];
    
    // 添加点击手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyboard)];
    [self addGestureRecognizer:tapGR];
    
 
}


#pragma mark - 设置无效状态
- (void)setBtnDisabled
{
    self.confirmBtn.backgroundColor = APPColor;
}

#pragma mark - 设置控件圆角
- (void)setCornerRadius:(UIView *)view
{
    if (self.radius) {
        view.layer.cornerRadius = self.radius;
    } else {
        view.layer.cornerRadius = 5.0;
    }
    
    view.layer.masksToBounds = YES;
}


- (void)show
{
    // 蒙版
    UIView *becloudView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    becloudView.backgroundColor = [UIColor blackColor];
    becloudView.layer.opacity = 0.3;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAlertView:)];
    [becloudView addGestureRecognizer:tapGR];
    // 是否显示蒙版
    if (_hideBecloud) {
        becloudView.hidden = YES;
    } else {
        becloudView.hidden = NO;
    }
    [TopWindow addSubview:becloudView];
    self.becloudView = becloudView;
    
    // 输入框
    float height = (becloudView.frame.size.width * 0.8 * 0.7) < 200 ? 200 : (becloudView.frame.size.width * 0.8 * 0.7);
    self.frame = CGRectMake(0, 0, becloudView.frame.size.width * 0.8, height);
    self.center = CGPointMake(becloudView.center.x, becloudView.frame.size.height * 0.4);
    [TopWindow addSubview:self];
    
}

- (void)exitKeyboard
{
    [self endEditing:YES];
}

#pragma mark - 移除ZYInputAlertView
- (void)dismiss
{
    [self removeFromSuperview];
    [self.becloudView removeFromSuperview];
}

#pragma mark - 点击关闭按钮
- (IBAction)closeAlertView:(UIButton *)sender {
    [self dismiss];
}

#pragma mark - 接收传过来的block
- (void)confirmBtnClickBlock:(confirmCallback)block
{
    self.confirmBlock = block;
}

#pragma mark - 点击确认按钮
- (IBAction)confirmBtnClick:(UIButton *)sender {
    [self dismiss];
    if (self.confirmBlock) {
        self.confirmBlock(self.inputTextView.text, self.secondField.text);
    }
}

- (void)dealloc
{
     // 移除监听者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
