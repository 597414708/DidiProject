//
//  StoreSingleImageCell.h
//  IOSSumgoTeaProject
//
//  Created by 敲代码mac1号 on 16/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreSingleImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;

@property (nonatomic , copy) void(^choseBlock)(UIButton *);

@end
