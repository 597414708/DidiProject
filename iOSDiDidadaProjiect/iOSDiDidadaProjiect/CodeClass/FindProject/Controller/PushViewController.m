//
//  PushViewController.m
//  IOSHorienMallProject
//
//  Created by 敲代码mac1号 on 2016/12/27.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//  发布

#import "PushViewController.h"

#import "UITextView+Placeholder.h"
#import "TZTestCell.h"
#import <QBImagePickerController/QBImagePickerController.h>

#import "SelectedClassView.h"

#import <UIImageView+WebCache.h>

#define YellowColor Color(252, 185, 0)

#define ImageTheW 417

#define collectionHeight (([UIScreen mainScreen].bounds.size.width-20) / 3.0 )
#define PersonUpLoadUserIamge(a) [NSString stringWithFormat:@"%@", a]


@interface PushViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate,MessagePhotoItemDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (strong, nonatomic) UIView *footView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *selectedPhotos;//选择的照片数组
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation PushViewController



-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置对齐方式
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //cell间距
        layout.minimumInteritemSpacing = 15.0f;
        //cell行距
        layout.minimumLineSpacing = 15.0f;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 0, 4);
        _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    }
    return _collectionView;
}




-(NSMutableArray *)selectedPhotos
{
    if (_selectedPhotos == nil) {
        _selectedPhotos = [[NSMutableArray alloc]init];
    }
    return _selectedPhotos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.contentTextView.placeholder = @"给这则帖子写几句有趣的文字.....";
    self.contentTextView.layer.cornerRadius = 5;
    self.contentTextView.layer.masksToBounds = YES;
    self.contentTextView.layer.borderWidth = 1;
    self.contentTextView.layer.borderColor = kCOLOR_HEX(0xeeeeee).CGColor;
    [self configView];
    
}


-(void)configView
{
    //.导航右边按钮
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds=CGRectMake(0, 0, 40, 30);
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightButton setTitleColor:APPColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    //尾部
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10+collectionHeight)];
    footView.backgroundColor = [UIColor whiteColor];
    
    self.footView = footView;
    
    
    [footView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView).offset(0);
        make.top.equalTo(footView).offset(5);
        make.bottom.equalTo(footView).offset(-10);
    }];
    
    self.myTableView.tableFooterView = footView;
    [self.collectionView reloadData];
    [self.myTableView reloadData];
    
}

- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClick {
    if (self.titleLabel.text.length == 0 || self.contentTextView.text.length == 0 || self.selectedPhotos.count == 0) {
        if (self.selectedPhotos.count == 0) {
            
        }
        [MBProgressHUD showMessage:@"发布内容不能为空" toView:self.view];
        
    }else{
        NSString *title = self.titleLabel.text;
        NSString *content = self.contentTextView.text;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __block NSInteger uploadNumOfImages = self.selectedPhotos.count;
        NSMutableArray *imageUrlArr = [[NSMutableArray alloc]init];
        for (id photo in self.selectedPhotos) {
            if ([photo isKindOfClass:[UIImage class]]) {
                UIImage *image = photo;
                [[HelpManager shareHelpManager]  putImage:image WithView:self.view finish:^(NSString *url) {

                    [imageUrlArr addObject:url];
                    uploadNumOfImages--;
                    
                } error:^(NSError *error) {
                    uploadNumOfImages--;
                }];
                
            }else{//url
                [imageUrlArr addObject:photo];
                uploadNumOfImages--;
            }
        }
        
        while(uploadNumOfImages > 0) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        if (imageUrlArr.count!=self.selectedPhotos.count) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:@"上传图片失败" toView:self.view];
            return;
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
        
        
        NSDictionary *dic = @{@"content":content, @"title":title, @"type":@"1", @"banner":[imageUrlArr componentsJoinedByString:@","], @"indexImg":imageUrlArr.firstObject};
        
        [APIManager ArticleAddWithParameters:dic.mutableCopy success:^(id data) {
            if (self.myBlock) {
                self.myBlock();
            }
            
            [MBProgressHUD showMessage:@"发布成功" toView:nil];

            [self.navigationController popViewControllerAnimated:YES];
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }
}


#pragma mark 重设collection高度
-(void)resetFootViewHeight
{
    if (self.selectedPhotos.count<3){
        self.footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 10+collectionHeight);
    }else if (self.selectedPhotos.count>=3 && self.selectedPhotos.count < 6){
        self.footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 10+collectionHeight*2 );
    }  else if (self.selectedPhotos.count>=6){
        self.footView.frame = CGRectMake(0, 0, self.view.frame.size.width,10+collectionHeight*3 );
    }
    self.myTableView.tableFooterView = self.footView;
}


#pragma mark - MessagePhotoItemDelegate
-(void)messagePhotoItemView:(TZTestCell *)messagePhotoItemView didSelectDeleteButtonAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.selectedPhotos removeObjectAtIndex:indexPath.row];
    [self resetFootViewHeight];
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

#pragma mark UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectedPhotos.count==9) {
        return 9;
    }
    return self.selectedPhotos.count+1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    NSMutableArray *selectedPhotos = [self.selectedPhotos mutableCopy];
    cell.delegate = self;
    if (indexPath.row == selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"content_icon_add"];
        cell.indexPath = nil;
    } else if ([selectedPhotos[indexPath.row] isKindOfClass:[UIImage class]]) {
        cell.imageView.image = selectedPhotos[indexPath.row];
        cell.indexPath = [indexPath copy];
    }else {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:PersonUpLoadUserIamge(selectedPhotos[indexPath.row])] placeholderImage:[UIImage imageNamed:@"ZC_mrtx_d"]];
        cell.indexPath = [indexPath copy];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((int)(([UIScreen mainScreen].bounds.size.width-20) / 3.0 - 15), (int)(([UIScreen mainScreen].bounds.size.width-20) / 3.0 - 15));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *selectedPhotos = [self.selectedPhotos mutableCopy];
    if (indexPath.row == selectedPhotos.count) {
        [self showSelectPhoto];
    }
}



#pragma mark - 选择照片
-(void)showSelectPhoto
{
    NSMutableArray *newArray = @[@{@"content":@"相册",@"color":Color(69, 69, 69)}, @{@"content":@"拍照", @"color":Color(69, 69, 69)}, @{@"content":@"取消", @"color":Color(69, 69, 69)}].mutableCopy;
    SheetAlertView *sheetView = [SheetAlertView sheetAlertViewWith:newArray];
    
    __weak typeof(self)blockSelf = self;
    
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.delegate = blockSelf;
    vc.allowsEditing = YES;
    __weak typeof(sheetView)blocksheetView = sheetView;
    [sheetView setSheetblock:^(NSInteger inter) {
        switch (inter) {
            case 0:
            {
                QBImagePickerController *imagePickerController = [QBImagePickerController new];
                imagePickerController.delegate = blockSelf;
                imagePickerController.allowsMultipleSelection = YES;
                imagePickerController.maximumNumberOfSelection = 9 - self.selectedPhotos.count;
                [blockSelf presentViewController:imagePickerController animated:YES completion:nil];
            }
                break;
            case 1:
            {
                
                vc.sourceType = UIImagePickerControllerSourceTypeCamera;
                [blockSelf presentViewController:vc animated:YES completion:nil];
                
                NSLog(@"拍照");
            }
                break;
            case 2:
            {
                NSLog(@"点击取消");
            }
                break;
            default:
                break;
        }
        [blocksheetView removeFromSuperview];
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //从字典key获取image的地址
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    UIImage *newImage = [[HelpManager shareHelpManager] compressImage:image toTargetWidth:ImageTheW];
    //从字典key获取image的地址
    [self.selectedPhotos addObject:newImage];
    [self resetFootViewHeight];
    [self.collectionView reloadData];
}


#pragma mark - 照片多选
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    BOOL isFirset;
    __block NSInteger uploadNumOfImages = assets.count;
    for (PHAsset *asset in assets) {
        isFirset = YES;
        PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        [imageManager requestImageForAsset:asset
                                targetSize:PHImageManagerMaximumSize
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info)
         {
             
             UIImage *newImage = [[HelpManager shareHelpManager] compressImage:result toTargetWidth:ImageTheW];
             
             BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
             if (downloadFinined) {
                 [self.selectedPhotos addObjectsFromArray:@[newImage]];
                 uploadNumOfImages--;
             }
             
         }];
    }
    while(uploadNumOfImages > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    [self resetFootViewHeight];
    [_collectionView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
    MyLog(@"-PushViewController-释放");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
