//
//  CommentViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/6.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CommentViewController.h"
#import "UITextView+Placeholder.h"
#import "TZTestCell.h"
#import <QBImagePickerController/QBImagePickerController.h>
#import <UIImageView+WebCache.h>
#import "SelectedClassView.h"

#import "NewStarView.h"
#import "OrderCenterGoodsModel.h"


#define collectionHeight (([UIScreen mainScreen].bounds.size.width-20) / 3.0 )
#define PersonUpLoadUserIamge(a) [NSString stringWithFormat:@"%@", a]
#define ImageTheW 417

@interface CommentViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate,MessagePhotoItemDelegate, NewStarViewDelegate> {
    NSInteger score;
}
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *selectedPhotos;//选择的照片数组
@property (strong, nonatomic) UIView *footView;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NewStarView *starV;

@end

@implementation CommentViewController


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
        _collectionView.backgroundColor = [UIColor whiteColor];
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
    self.headImage.layer.masksToBounds = YES;
    
    if (self.orderMd) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.orderMd.shopLogo] placeholderImage:placeHoder];
        
    } else {
        OrderCenterGoodsModel *goodsModel = self.model;
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:goodsModel.goodsImg] placeholderImage:placeHoder];
    }
    score = 5;
    self.contentTextView.placeholder = @"宝贝你可满意，点评一下吧.....";
    self.myTableView.backgroundColor = Color(230,230,229);
    self.starV = [[NewStarView alloc] initWithFrame:CGRectMake(0, 0, TheW - 193, 43) numberOfStars:5];
    self.starV.delegate = self;
    self.collectionView.hidden = YES;
    [self.starView addSubview:self.starV];
    [self configView];
}

- (void)starRateView:(NewStarView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent {
    score = 5 * newScorePercent;
    
}

-(void)configView
{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"商品评价";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;

    //尾部
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100+collectionHeight)];
    footView.backgroundColor = Color(230,230,229);
    self.footView = footView;
    UIButton *chooseView = [UIButton buttonWithType:UIButtonTypeSystem];
    [chooseView setTitle:@"提交评价" forState:UIControlStateNormal];
    [chooseView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chooseView.backgroundColor = APPColor;
    chooseView.layer.cornerRadius = 4;
    chooseView.layer.masksToBounds = YES;
    chooseView.titleLabel.font = [UIFont systemFontOfSize:15];
    [chooseView addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:chooseView];
    
    [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(25);
        make.right.equalTo(footView).offset(-25);
        make.size.height.offset(45);
        make.bottom.equalTo(footView).offset(0);
    }];
    
    [footView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footView).offset(0);
        make.top.equalTo(footView).offset(5);
        make.bottom.equalTo(chooseView).offset(-95);
    }];
    
    self.myTableView.tableFooterView = footView;
    [self.collectionView reloadData];
    [self.myTableView reloadData];
    
}

- (void)finishAction:(UIButton *)sender {
    OrderCenterGoodsModel *goodsModel = self.model;
    NSDictionary *dic = @{};
    if (self.model) {
        dic = @{@"content":self.contentTextView.text,
                @"star":@(score),
                @"goodsId":goodsModel.goodsId,
                @"type":@"1",
                @"indentId":goodsModel.indentId
                };
    } else {
        dic = @{@"content":self.contentTextView.text,
                @"star":@(score),
                @"shopId":self.orderMd.shopId,
                @"type":@"2",
                @"id":self.orderMd.id
                };
    }
    
    
    
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager EvolutionAddWithParameters:dic.mutableCopy success:^(id data) {
        [MBProgressHUD showMessage:@"评价成功" toView:nil];
        if (self.myBlock) {
            self.myBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 重设collection高度
-(void)resetFootViewHeight
{
    if (self.selectedPhotos.count<3){
        self.footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100+collectionHeight);
    }else if (self.selectedPhotos.count>=3 && self.selectedPhotos.count < 6){
        self.footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100+collectionHeight*2 );
    }  else if (self.selectedPhotos.count>=6){
        self.footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100+collectionHeight*3 );
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
    __weak typeof (sheetView)weakSheetView = sheetView;
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
        [weakSheetView removeFromSuperview];
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //从字典key获取image的地址
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    UIImage *newImage = [[HelpManager shareHelpManager]compressImage:image toTargetWidth:ImageTheW];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    //移除通知
    MyLog(@"-CommentViewController-释放");
    
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
