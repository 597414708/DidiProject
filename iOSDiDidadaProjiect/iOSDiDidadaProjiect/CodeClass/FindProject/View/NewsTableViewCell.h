//
//  NewsTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleListModel;
@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)showData:(ArticleListModel *)model;
@end
