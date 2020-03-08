//
//  SheetAlertView.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SheetAlertView.h"
#import "SheetTableViewCell.h"
@interface SheetAlertView ()

@property (nonatomic , strong) NSMutableArray *dataSouce;

@end

@implementation SheetAlertView

- (NSMutableArray *)dataSouce {
    if (!_dataSouce) {
        self.dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    
    [self removeFromSuperview];
}

+ (SheetAlertView *) sheetAlertViewWith:(NSMutableArray *)array {
    SheetAlertView *view = [[[NSBundle mainBundle] loadNibNamed:@"SheetAlertView" owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, TheW, TheH);
    view.myTableView.delegate = view;
    view.myTableView.dataSource = view;
    view.myTableView.rowHeight = 60;
    view.height.constant = 60 * array.count;
    [view.myTableView registerNib:[UINib nibWithNibName:@"SheetTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    view.dataSouce = array;
    view.myTableView.bounces = NO;
    return view;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell showData:self.dataSouce[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sheetblock) {
        self.sheetblock(indexPath.row);
    }
    
    
}


@end
