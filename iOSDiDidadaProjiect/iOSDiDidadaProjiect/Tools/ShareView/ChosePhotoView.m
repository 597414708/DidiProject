//
//  ChosePhotoView.m
//  IOSSumgoTeaProject
//
//  Created by 敲代码mac1号 on 16/11/15.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ChosePhotoView.h"
#import "ShareCollectionViewCell.h"
@implementation ChosePhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ChosePhotoView *)shareChosePhotoView:(void(^)())photoBlock CameraBlock:(void(^)())cameraBlock {
    ChosePhotoView *view = [[[NSBundle mainBundle] loadNibNamed:@"ChosePhotoView" owner:nil options:nil] firstObject];
    
    view.shareCollectionView.layer.cornerRadius = 5;
    view.shareCollectionView.layer.masksToBounds = YES;
    view.cancelBtn.layer.cornerRadius = 5;
    view.cancelBtn.layer.masksToBounds = YES;
    
    view.backgroundColor = [UIColor clearColor];
    
    view.frame = CGRectMake(0, 0, TheW, TheH);
    [view.cancelBtn setTitleColor:Color(79, 79, 79) forState:UIControlStateNormal];
    [view.cancelBtn setTitleColor:Color(73, 184, 191) forState:UIControlStateHighlighted];
    view.photoBlock = photoBlock;
    view.cameraBlock = cameraBlock;
   
    [view creatShareCollectionView];
    
    view.showView.frame = CGRectMake(0, TheH, TheW, TheW);
    [UIView animateWithDuration:0.25 animations:^{
        view.showView.frame = CGRectMake(0, TheH - 285, TheW, 285);
    }];
    return view;
}



- (void)creatShareCollectionView {
    //self.shareArray = @[@{@"title":@"微信好友", @"image":@"fx_wx"}, @{@"title":@"朋友圈", @"image":@"fx_pyq"}, @{@"title":@"编辑", @"image":@"fx_bj"}, @{@"title":@"删除", @"image":@"fx_sc"},];
    
    self.shareArray = @[@{@"title":@"拍照", @"image":@"Camera"}, @{@"title":@"本地图库", @"image":@"Image"}];
    
    [self creatLayOut];
    
    self.shareCollectionView.delegate = self;
    self.shareCollectionView.dataSource = self;
    
    [self.shareCollectionView registerNib:[UINib nibWithNibName:@"ShareCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"photo"];
}

- (void)creatLayOut {
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 60;
    //设置最小行间距
    layOut.minimumLineSpacing = 60;
    //设置item的大小
    layOut.itemSize = CGSizeMake(80,120);
    //设置分区上左下右间距
    layOut.sectionInset = UIEdgeInsetsMake(50, (TheW - 160 - 60 - 12) / 2, 50,  (TheW - 160 - 60 - 12) / 2);
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
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
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.photoHeight.constant = 72;
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
            if (self.cameraBlock) {
                [self removeView];
                self.cameraBlock();
            }
        }
            break;
        case 1:
        {
            if (self.photoBlock) {
                [self removeView];
                self.photoBlock();
            }
        }
            break;
              default:
            break;
    }
    
}

@end
