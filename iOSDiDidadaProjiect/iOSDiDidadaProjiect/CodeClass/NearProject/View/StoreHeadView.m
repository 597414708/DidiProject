//
//  StoreHeadView.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "StoreHeadView.h"

@implementation StoreHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (StoreHeadView *) ShareStoreHeadVie {
    StoreHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"StoreHeadView" owner:nil options:nil] firstObject];
    view.shopImage.layer.cornerRadius = 4;
    view.shopImage.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    if (iPhoneX) {
        view.frame = CGRectMake(0, 0, TheW, 173);
    } else {
        view.frame = CGRectMake(0, 0, TheW, 149);
    }
    return view;
}

//预约
- (IBAction)yuyueAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock();
    }
}


@end
