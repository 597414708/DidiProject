//
//  InforListTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InforListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *classNameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;

- (void)showData;
@end
