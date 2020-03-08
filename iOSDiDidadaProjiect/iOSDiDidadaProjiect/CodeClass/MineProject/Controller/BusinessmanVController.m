//
//  BusinessmanVController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "BusinessmanVController.h"
#import "ImageSelectView.h"
#import <UIButton+WebCache.h>

#import "PersonDataModel.h"
#import "ShopModel.h"
#import "PersonalDataTableViewCell.h"
#import "PersonEditViewController.h"

@interface BusinessmanVController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSString *shopName;
    NSString *serviceProject;
    NSString *info3;
    NSString *indexImg;
    NSString *backImg;
    NSString *bussiness;
    NSString *realName;
    NSString *idcard;
    NSString *fanwei;
    NSString *xuke;
    NSString *address;
    NSString *bankcard;

}


@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIButton *IDfirstBtn;

@property (weak, nonatomic) IBOutlet UIButton *IDsecondBtn;

@property (weak, nonatomic) IBOutlet UIButton *carfirstBtn;

@property (weak, nonatomic) IBOutlet UIButton *carsecondBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property(nonatomic, strong)ImageSelectView *imageSelectView;//选择图片

@property (nonatomic, assign) NSInteger imageTag;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BusinessmanVController


-(ImageSelectView *)imageSelectView
{
    if (_imageSelectView==nil) {
        _imageSelectView = [[ImageSelectView alloc]init];
        __weak typeof(self)blockSelf = self;
        _imageSelectView.doneBlock = ^(BOOL isCamere){
            UIImagePickerController *vc = [[UIImagePickerController alloc]init];
            vc.delegate = blockSelf;
            vc.allowsEditing = YES;
            if (isCamere) {
                vc.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            [blockSelf presentViewController:vc animated:YES completion:nil];
        };
    }
    return _imageSelectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.finishBtn.userInteractionEnabled = NO;
    [self creatUI];
    [self creatData];
    [self craetDataSWith:nil];
}

- (void)creatData {
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager UserShopWithParameters:nil success:^(id data) {
        NSDictionary *dic = data;
        ShopModel *model = [[ShopModel alloc] init];
        model = [ShopModel mj_objectWithKeyValues:dic];
        [self craetDataSWith:model];
    } failure:^(NSError *error) {
        
    }];
}

- (void)craetDataSWith:(ShopModel *)models {
    
    if ([models.verifyStatus isEqualToString:@"1"]) {
        [self.finishBtn setTitle:@"审核成功" forState:UIControlStateNormal];
        self.finishBtn.userInteractionEnabled = NO;
    } else if ([models.verifyStatus isEqualToString:@"0"]) {
        [self.finishBtn setTitle:@"正在审核" forState:UIControlStateNormal];
        self.finishBtn.userInteractionEnabled = NO;
    } else {
        self.finishBtn.userInteractionEnabled = YES;
    }
    
    PersonDataModel *model = [[PersonDataModel alloc] init];
    model.className = @"店铺名称";
    model.content = models.name.length > 0 ? models.name : @"请输入店铺名称";
    model.idS = 0;
    shopName = models.name;
    
    PersonDataModel *model2 = [[PersonDataModel alloc] init];
    model2.className = @"服务项目";
    model2.content = models.serviceProject.length > 0 ? models.serviceProject : @"请输入服务项目";
    model2.idS = 1;
    serviceProject = models.serviceProject;
    
    PersonDataModel *model6 = [[PersonDataModel alloc] init];
    model6.className = @"经营范围";
    model6.content = models.info4.length > 0 ? models.info4 : @"请输入经营范围";
    model6.idS = 5;
    fanwei = models.info4;
    
    PersonDataModel *model3 = [[PersonDataModel alloc] init];
    model3.className = @"联系方式";
    model3.content = models.info3.length > 0 ? models.info3 : @"请输入联系方式";
    model3.idS = 2;
    info3 = models.info3;
    
    PersonDataModel *model7 = [[PersonDataModel alloc] init];
    model7.className = @"许可证号";
    model7.content = models.info5.length > 0 ? models.info5 : @"请输入许可证号";
    model7.idS = 6;
    xuke = models.info5;
    
    PersonDataModel *model4 = [[PersonDataModel alloc] init];
    model4.className = @"法定代表人";
    model4.content = models.realName > 0 ? models.realName : @"请输入法定代表人";
    model4.idS = 3;
    realName = models.realName;
 
    PersonDataModel *model5 = [[PersonDataModel alloc] init];
    model5.className = @"身份证号";
    model5.content = models.idcard > 0 ? models.idcard : @"请输入身份证号";
    model5.idS = 4;
    idcard = models.idcard;
    
    PersonDataModel *model8 = [[PersonDataModel alloc] init];
    model8.className = @"经营地址";
    model8.content = models.address > 0 ? models.address : @"请输入经营地址";
    model8.idS = 7;
    address = models.address;
    
    PersonDataModel *model9 = [[PersonDataModel alloc] init];
    model9.className = @"银行卡号";
    model9.content = models.bankcard > 0 ? models.bankcard : @"请输入银行卡号";
    model9.idS = 8;
    bankcard = models.bankcard;
    
    if (models.indexImg) {
        [self.IDfirstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.indexImg] forState:UIControlStateNormal placeholderImage:placeHoder];
        indexImg = models.indexImg;
    }
    
    if (models.backImg) {
        [self.IDsecondBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.backImg] forState:UIControlStateNormal placeholderImage:placeHoder];
        backImg = models.backImg;
    }
    
    if (models.bussiness) {
        [self.carfirstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.bussiness] forState:UIControlStateNormal placeholderImage:placeHoder];
        bussiness = models.bussiness;
    }
    
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:model];
    [self.dataSource addObject:model2];
    [self.dataSource addObject:model6];
    [self.dataSource addObject:model3];
    [self.dataSource addObject:model7];
    [self.dataSource addObject:model4];
    [self.dataSource addObject:model5];
    [self.dataSource addObject:model8];
    [self.dataSource addObject:model9];
    [self.myTableView reloadData];
}


- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"成为商家";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    [self clipsToBoundsWith:self.IDfirstBtn];
    [self clipsToBoundsWith:self.IDsecondBtn];
    [self clipsToBoundsWith:self.carfirstBtn];
    [self clipsToBoundsWith:self.carsecondBtn];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 60;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"PersonalDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersonalDataCell"];
}

- (void)clipsToBoundsWith:(UIView *)sender {
    sender.layer.cornerRadius = 7;
    sender.layer.masksToBounds = YES;
    sender.layer.borderColor = kCOLOR_HEX(0x999999).CGColor;
    sender.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finishAction:(UIButton *)sender {

    if (shopName.length == 0) {
        [MBProgressHUD showMessage:@"请输入店铺名称" toView:nil];
        return;
    }
    
    if (serviceProject.length == 0) {
        [MBProgressHUD showMessage:@"请输入服务项目" toView:nil];
        return;
    }
    
    if (fanwei.length == 0) {
        [MBProgressHUD showMessage:@"请输入经营范围" toView:nil];
        return;
    }
    
    if (info3.length == 0) {
        [MBProgressHUD showMessage:@"请输入联系方式" toView:nil];
        return;
    }
    
    if (xuke.length == 0) {
        [MBProgressHUD showMessage:@"请输入许可证号" toView:nil];
        return;
    }
    
    if (realName.length == 0) {
        [MBProgressHUD showMessage:@"请输入法定代表" toView:nil];
        return;
    }
    
    if (idcard.length == 0) {
        [MBProgressHUD showMessage:@"请输入身份证号" toView:nil];
        return;
    }
    
    if (address.length == 0) {
        [MBProgressHUD showMessage:@"请输入经营地址" toView:nil];
        return;
    }
    
    if (bankcard.length == 0) {
        [MBProgressHUD showMessage:@"请输入银行卡号" toView:nil];
        return;
    }
    
    if (indexImg.length == 0) {
        [MBProgressHUD showMessage:@"请上传身份证正面" toView:nil];
        return;
    }
    
    if (backImg.length == 0) {
        [MBProgressHUD showMessage:@"请上传身份证背面" toView:nil];
        return;
    }
    
    if (bussiness.length == 0) {
        [MBProgressHUD showMessage:@"请上传营业执照" toView:nil];
        return;
    }
    
    NSDictionary *dic = @{@"info3":info3,
                          @"name":shopName,
                          @"serviceProject":serviceProject,
                          @"indexImg":indexImg,
                          @"backImg":backImg,
                          @"bussiness":bussiness,
                          @"realName":realName,
                          @"idcard":idcard,
                          @"info5":xuke,
                          @"info4":fanwei,
                          @"bankcard":bankcard,
                          @"address":address
                          }.mutableCopy;
    
    [APIManager ShoptoShopWithParameters:dic.mutableCopy success:^(id data) {
        [MBProgressHUD showMessage:@"提交成功" toView:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)selectImage:(UIButton *)sender {
    self.imageTag = sender.tag - 100;
    [self showSelectPhoto];
}

-(void)showSelectPhoto
{
    UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
    [keyWindow addSubview:self.imageSelectView];
    [self.imageSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(keyWindow);
        make.width.height.equalTo(keyWindow);
    }];
    [self.imageSelectView layoutIfNeeded];
    
    //动画效果
    [self.imageSelectView.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageSelectView).offset(0);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.imageSelectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.imageSelectView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PersonDataModel *model = self.dataSource[indexPath.row];
    cell.moreImage.hidden = NO;
    [cell showData:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        PersonDataModel *model = self.dataSource[indexPath.row];
        PersonEditViewController *personEditVC = [[PersonEditViewController alloc] init];
        personEditVC.type = model.idS;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personEditVC animated:YES];
        
        [personEditVC setEditblock:^(NSString *str){
            PersonDataModel *model = self.dataSource[indexPath.row];
            model.content = str;
            if (indexPath.row == 0) {
                shopName = str;
            }
            if (indexPath.row == 1) {
                serviceProject = str;
            }
            
            if (indexPath.row == 2) {
                fanwei = str;
            }
            if (indexPath.row == 3) {
                info3 = str;
            }
            if (indexPath.row == 4) {
                xuke = str;
            }
            
            if (indexPath.row == 5) {
                realName = str;
            }
            
            if (indexPath.row == 6) {
                idcard = str;
            }
            
            if (indexPath.row == 7) {
                address = str;
            }
            
            if (indexPath.row == 8) {
                bankcard = str;
            }
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //从字典key获取image的地址
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    [[HelpManager shareHelpManager] putImage:image WithView:self.view finish:^(NSString *url) {
        
        NSLog(@"%@", url);
        
        switch (self.imageTag) {
          
            case 1:
                
            {
                indexImg = url;
                [self.IDfirstBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                backImg = url;
                [self.IDsecondBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                bussiness = url;
                [self.carfirstBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
           
            default:
                break;
        }
    } error:^(NSError *error) {
        
    }];
}

- (void)dealloc {
    MyLog(@"-BusinessmanVController-释放");
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
