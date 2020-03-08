//
//  StoreInforTableViewCell.h
//  IOSSumgoTeaProject
//
//  Created by 敲代码mac1号 on 16/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreInforTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *twoImage;
@property (weak, nonatomic) IBOutlet UIButton *oneImage;

@property (nonatomic , copy) void(^choseImageBlock)(UIButton *);

@end
