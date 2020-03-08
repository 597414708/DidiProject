//
//  StoreHeadView.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (nonatomic, copy) void(^myBlock)();

+ (StoreHeadView *) ShareStoreHeadVie;
@end
