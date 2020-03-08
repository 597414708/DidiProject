//
//  SheetAlertView.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetAlertView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (nonatomic , copy) void(^sheetblock)(NSInteger index);

+ (SheetAlertView *) sheetAlertViewWith:(NSMutableArray *)array;

@end
