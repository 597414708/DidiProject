//
//  SheetTableViewCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *linelabel;

- (void)showData:(NSDictionary *)dic;

@end
