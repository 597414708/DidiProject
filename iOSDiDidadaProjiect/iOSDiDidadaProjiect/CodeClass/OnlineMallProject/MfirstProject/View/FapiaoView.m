//
//  FapiaoView.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2018/1/25.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "FapiaoView.h"

@implementation FapiaoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (FapiaoView *)shareFapiaoView {
    FapiaoView *view = [[[NSBundle mainBundle] loadNibNamed:@"FapiaoView" owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor clearColor];
    if (iPhoneX) {
        view.frame = CGRectMake(0, -90, TheW, TheH);

    } else {
        view.frame = CGRectMake(0, -64, TheW, TheH);

    }
    view.noFapiao.layer.borderWidth = 1;
    view.noFapiao.layer.borderColor = kCOLOR_HEX(0x999999).CGColor;
    view.noFapiao.layer.cornerRadius = 3;
    view.noFapiao.layer.masksToBounds = YES;
    
    view.fapiaoBtn.layer.cornerRadius = 3;
    view.noFapiao.layer.masksToBounds = YES;
    view.personalBt.selected = YES;

    
    view.type = @"0";
    view.firstTf.placeholder = @"请填写纳税人姓名";
    view.secondTf.placeholder = @"请输入纳税人识别编号(可不填)";
    
    return view;
}

- (IBAction)personalAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.danweiBt.selected = !self.personalBt.selected;
    [self changeBtn];
    
}

- (IBAction)danweiAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.personalBt.selected = !self.danweiBt.selected;
    [self changeBtn];
}

- (void) changeBtn {
    if (self.personalBt.selected) {
        self.type = @"0";
        self.firstTf.placeholder = @"请填写纳税人姓名";
        self.secondTf.placeholder = @"请输入纳税人识别编号(可不填)";

    } else {
        self.type = @"1";
        self.firstTf.placeholder = @"请输入单位的发票抬头";
        self.secondTf.placeholder = @"请输入纳税人识别编号(必填)";

    }
}


- (IBAction)noFapiaoAction:(UIButton *)sender {
    if (self.myBlock) {
        NSMutableArray *arry = [NSMutableArray array];
        self.type = @"-1";
        [arry addObject:self.type];
        self.myBlock(arry);
    }
    [self removeFromSuperview];
   
}

- (IBAction)finishAction:(UIButton *)sender {
    if (self.myBlock) {
        NSMutableArray *arry = [NSMutableArray array];
        
        if ([self.type isEqualToString:@"-1"]) {
            self.myBlock(arry);

        } else {
            if ([self.type isEqualToString:@"0"]) {
                if (self.firstTf.text.length == 0) {
                    [MBProgressHUD showMessage:@"请输入纳税人姓名" toView:nil];
                    return;
                }
            } else if ([self.type isEqualToString:@"1"]) {
                if (self.firstTf.text.length == 0) {
                    [MBProgressHUD showMessage:@"请输入单位发票抬头" toView:nil];
                    return;
                }
            }
            
            if ([self.type  isEqualToString:@"1"]) {
                if (self.secondTf.text.length == 0) {
                    [MBProgressHUD showMessage:@"请输入纳税人识别编号" toView:nil];
                    return;
                }
            }
            
        
            [arry addObject:self.type];
            [arry addObject:self.firstTf.text];
            [arry addObject:self.secondTf.text];
            self.myBlock(arry);
            [self removeFromSuperview];

        }
        
    }
}


- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    
    [self removeFromSuperview];
}
@end
