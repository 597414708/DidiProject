//
//  InsuredListCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsuredModel;

@interface InsuredListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *moreImage;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (nonatomic, copy) void(^myBlock)(UIButton *sener);
@property (weak, nonatomic) IBOutlet UIView *bujiView;
@property (weak, nonatomic) IBOutlet UIButton *flagBtn;

- (void)showData:(InsuredModel *)model;

@end
