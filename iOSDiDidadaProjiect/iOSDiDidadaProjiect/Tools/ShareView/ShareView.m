//
//  ShareView.m
//  IM
//
//  Created by 敲代码mac1号 on 16/6/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 
 */

+ (ShareView *)shareViewQQShare:(void(^)())QQShareBlock WeiChatShare:(void(^)())WeiChatShareBlock WeiBoShare:(void(^)())WeiBoShareBlock FriendShare:(void(^)())FriendShareBlock {
    ShareView *view = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:nil options:nil] firstObject];
    
    view.shareCollectionView.layer.cornerRadius = 5;
    view.shareCollectionView.layer.masksToBounds = YES;
    view.cancelBtn.layer.cornerRadius = 5;
    view.cancelBtn.layer.masksToBounds = YES;
    
    view.backgroundColor = [UIColor clearColor];
    
    view.frame = CGRectMake(0, 0, TheW, TheH);
    [view.cancelBtn setTitleColor:Color(79, 79, 79) forState:UIControlStateNormal];
    [view.cancelBtn setTitleColor:Color(73, 184, 191) forState:UIControlStateHighlighted];
    view.QQBlock = QQShareBlock;
    view.WeiBoBlock = WeiBoShareBlock;
    view.FriendBlock = FriendShareBlock;
    view.WeiChatBlock = WeiChatShareBlock;
    [view creatShareCollectionView];
    
    view.showView.frame = CGRectMake(0, TheH, TheW, TheW);
    [UIView animateWithDuration:0.25 animations:^{
        view.showView.frame = CGRectMake(0, TheH - 285, TheW, 285);
    }];
    return view;
}


- (void)creatShareCollectionView {
    //self.shareArray = @[@{@"title":@"微信好友", @"image":@"fx_wx"}, @{@"title":@"朋友圈", @"image":@"fx_pyq"}, @{@"title":@"编辑", @"image":@"fx_bj"}, @{@"title":@"删除", @"image":@"fx_sc"},];
    
     self.shareArray = @[@{@"title":@"微信好友", @"image":@"weixi"}, @{@"title":@"朋友圈", @"image":@"pyq"}];
    [self creatLayOut];
    
    self.shareCollectionView.delegate = self;
    self.shareCollectionView.dataSource = self;
    
    [self.shareCollectionView registerNib:[UINib nibWithNibName:@"ShareCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"Share"];
}


- (void)creatLayOut {
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    
    if (self.shareArray.count == 4) {
        //设置最小行列间距
        layOut.minimumInteritemSpacing = (TheW - 200 - 12) / 5;
        //设置最小行间距
        layOut.minimumLineSpacing = (TheW - 200 - 12) / 5;
        //设置item的大小
        layOut.itemSize = CGSizeMake(50,80);
        //设置分区上左下右间距
        layOut.sectionInset = UIEdgeInsetsMake(60, (TheW - 200 - 12) / 5, 60,  (TheW - 200 - 12) / 5);
        layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    } else {
        
        //设置最小行列间距
        layOut.minimumInteritemSpacing = 100;
        //设置最小行间距
        layOut.minimumLineSpacing = 100;
        //设置item的大小
        layOut.itemSize = CGSizeMake(50,80);
        //设置分区上左下右间距
        layOut.sectionInset = UIEdgeInsetsMake(60, (TheW - 100 - 100 - 12) / 2, 60,  (TheW - 100 - 100 - 12) / 2);
        layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    self.shareCollectionView.collectionViewLayout = layOut;
    
}


- (IBAction)cancelAction:(UIButton *)sender {
    [self removeView];
}


- (void)removeView {
    [UIView animateWithDuration:0.25 animations:^{
        self.showView.frame = CGRectMake(0, TheH, TheW, TheH);
        self.alphBackView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [self removeView];
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shareArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Share" forIndexPath:indexPath];
    NSDictionary *dic = self.shareArray[indexPath.row];
    cell.titleLabel.text = dic[@"title"];
    cell.photoImage.image = [UIImage imageNamed:dic[@"image"]];
    return cell;
}

#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            if (self.WeiChatBlock) {
                self.WeiChatBlock();
            }
        }
            break;
        case 1:
        {
            if (self.FriendBlock) {
                self.FriendBlock();
            }
        }
            break;
        case 2:
        {
            if (self.QQBlock) {
                self.QQBlock();
            }
        }
            break;
        case 3:
        {
            if (self.WeiBoBlock) {
                self.WeiBoBlock();
            }
        }
            break;
        default:
            break;
    }
    
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ShareCollectionViewCell *cell = (ShareCollectionViewCell *)[colView cellForItemAtIndexPath:indexPath];
//    //设置(Highlight)高亮下的颜色
//    //    [cell setBackgroundColor:[UIColor grayColor]];
//    alphView = [[UIView alloc] initWithFrame:cell.photoImage.frame];
//    alphView.backgroundColor = [UIColor blackColor];
//    alphView.alpha = 0.5;
//    [cell.photoImage addSubview:alphView];
    
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    //ShareCollectionViewCell* cell = (ShareCollectionViewCell *)[colView cellForItemAtIndexPath:indexPath];;
    //设置(Nomal)正常状态下的颜色
    //[cell setBackgroundColor:Color(221, 221, 221)];
//    [alphView removeFromSuperview];
}

@end
