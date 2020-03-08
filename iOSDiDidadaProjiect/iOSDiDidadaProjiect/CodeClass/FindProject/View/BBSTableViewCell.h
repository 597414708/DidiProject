//
//  BBSTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleListModel;

@interface BBSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;


- (void)showData:(ArticleListModel *)model;;
@end
