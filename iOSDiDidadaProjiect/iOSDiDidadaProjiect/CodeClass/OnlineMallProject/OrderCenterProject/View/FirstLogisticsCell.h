//
//  FirstLogisticsCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/16.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostListModel;
@interface FirstLogisticsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UIImageView *tagImage;
@property (weak, nonatomic) IBOutlet UILabel *topLab;

@property (weak, nonatomic) IBOutlet UILabel *bottomLab;


- (void)typeWith:(NSInteger)type With:(PostListModel *)model;
@end
