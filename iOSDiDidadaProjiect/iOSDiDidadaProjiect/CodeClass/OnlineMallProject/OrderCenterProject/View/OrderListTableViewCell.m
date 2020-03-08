//
//  OrderListTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/27.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import "OrderCenterGoodsModel.h"
#import "OrderCenterModel.h"
@implementation OrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(OrderCenterModel *)model {
    
    NSDictionary *dic = @{@"-1":@"已取消",
                          @"0":@"待支付",
                          @"1":@"已支付待发货",
                          @"2":@"已发货待收货",
                          @"3":@"确认收货待评价",
                          @"4":@"已评价",
                          @"5":@"退货",
                          @"51":@"退货中",
                          @"52":@"已退货",
                          @"6":@"退款申请",
                          @"62":@"已退款",
                          @"10":@"已完成"
                          };
    OrderCenterGoodsModel *goodsModel = model.indentList.firstObject;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImg] placeholderImage:placeHoder];
    
    self.titleLab.text = goodsModel.goodsName;
    
    self.contentLab.text = goodsModel.goodsIntro;
    
    self.countLab.text = [NSString stringWithFormat:@"X%ld", goodsModel.number];
    
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", model.totalMoney];
    
    self.stateLab.text = [dic objectForKey:model.indentStatus];
    
    self.orderNum.text = model.orderNo;
    


    if ([model.indentStatus isEqualToString:@"-1"] ||
        [model.indentStatus isEqualToString:@"52"] ||
        [model.indentStatus isEqualToString:@"62"] ||
        [model.indentStatus isEqualToString:@"10"]) {
        self.delateBtn.hidden = YES;
        self.commentBtn.hidden = NO;
        self.commentBtn.tag = 100 + [model.indentStatus integerValue];
        [self.commentBtn setTitle:@"删除" forState:UIControlStateNormal];
    }

    
    if ([model.indentStatus isEqualToString:@"1"]) {
        self.delateBtn.hidden = YES;
        self.commentBtn.hidden = NO;
        self.commentBtn.tag = 100 + [model.indentStatus integerValue];
        [self.commentBtn setTitle:@"退款" forState:UIControlStateNormal];
    }
    
    if ([model.indentStatus isEqualToString:@"5"] ||
        [model.indentStatus isEqualToString:@"51"] ||
        [model.indentStatus isEqualToString:@"6"]) {
        self.delateBtn.hidden = YES;
        self.commentBtn.hidden = YES;
    }
    
    
    if ([model.indentStatus isEqualToString:@"2"]) {
        self.delateBtn.hidden = YES;
        self.commentBtn.hidden = NO;
        self.commentBtn.tag = 100 + [model.indentStatus integerValue];
        [self.commentBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    }
    if ([model.indentStatus isEqualToString:@"4"]) {
        self.delateBtn.hidden = YES;
        self.commentBtn.hidden = NO;
        self.commentBtn.tag = 100 + [model.indentStatus integerValue];
        [self.commentBtn setTitle:@"退货" forState:UIControlStateNormal];
    }
    
    if ([model.indentStatus isEqualToString:@"0"]) {
        self.delateBtn.hidden = NO;
        self.commentBtn.hidden = NO;
        self.delateBtn.tag = 100 + [model.indentStatus integerValue];
        self.commentBtn.tag = 100 + [model.indentStatus integerValue];
        [self.delateBtn setTitle:@"支付" forState:UIControlStateNormal];
        [self.commentBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    
    if ([model.indentStatus isEqualToString:@"3"]) {
        self.delateBtn.hidden = NO;
        self.commentBtn.hidden = NO;
        self.delateBtn.tag = 100 + [model.indentStatus integerValue];
        self.commentBtn.tag = 100 + [model.indentStatus integerValue];
        [self.delateBtn setTitle:@"退货" forState:UIControlStateNormal];
        [self.commentBtn setTitle:@"评价" forState:UIControlStateNormal];
    }
}

//评价
- (IBAction)commentAction:(UIButton *)sender {
    if (self.commentBlock) {
        self.commentBlock(sender);
    }
    
}


//删除
- (IBAction)deleteAction:(UIButton *)sender {
    if (self.delateBlock) {
        self.delateBlock(sender);
    }
    
}


@end
