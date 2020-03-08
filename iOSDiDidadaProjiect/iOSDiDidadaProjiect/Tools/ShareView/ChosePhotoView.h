//
//  ChosePhotoView.h
//  IOSSumgoTeaProject
//
//  Created by 敲代码mac1号 on 16/11/15.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChosePhotoView : UIView  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *shareCollectionView;

@property (weak, nonatomic) IBOutlet UIView *alphBackView;

@property (nonatomic , strong) NSArray *shareArray;

@property (nonatomic, copy) void(^photoBlock)();
@property (nonatomic, copy) void(^cameraBlock)();


+ (ChosePhotoView *)shareChosePhotoView:(void(^)())photoBlock CameraBlock:(void(^)())cameraBlock;
- (void)removeView;
@end
