//
//  PersonalDataController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "PersonalDataController.h"
#import "PersonalDataTableViewCell.h"
#import "PersonDataModel.h"
#import "ImageSelectView.h"
#import "PersonEditViewController.h"
#import "UserModel.h"
#import "ChangePasViewController.h"

#import <UIButton+WebCache.h>

@interface PersonalDataController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UILabel *idCardLab;

@property (weak, nonatomic) IBOutlet UILabel *carIDlab;

@property (weak, nonatomic) IBOutlet UIButton *IDfirstBtn;

@property (weak, nonatomic) IBOutlet UIButton *IDsecondBtn;

@property (weak, nonatomic) IBOutlet UIButton *carfirstBtn;

@property (weak, nonatomic) IBOutlet UIButton *carsecondBtn;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong)ImageSelectView *imageSelectView;//选择图片

@property (nonatomic, assign) NSInteger imageTag;
@end

@implementation PersonalDataController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:UIStatusBarAnimationFade];
}

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

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatData];
}


- (void)creatData {
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager GetUserFreshWithParameters:nil success:^(id data) {
        NSDictionary *dic = data;
        UserModel *model = [[UserModel alloc] init];
        model = [UserModel mj_objectWithKeyValues:dic];
        [self craetDataSWith:model];
    } failure:^(NSError *error) {

    }];
}

- (void)craetDataSWith:(UserModel *)models {
    
    [userDef setObject:models.nickName forKey:NickName];
    [userDef setObject:models.userHead forKey:HeadImage];

    PersonDataModel *model = [[PersonDataModel alloc] init];
    model.className = @"ID";
    model.content = models.id;
    model.idS = 0;
    
    PersonDataModel *model2 = [[PersonDataModel alloc] init];
    model2.className = @"昵称";
    model2.content = models.nickName;
    model2.idS = 1;
    
    PersonDataModel *model3 = [[PersonDataModel alloc] init];
    model3.className = @"手机号码";
    model3.content = models.mobile;
    model3.idS = 2;
    
    PersonDataModel *model4 = [[PersonDataModel alloc] init];
    model4.className = @"修改密码";
    model4.content = @"*******";
    model4.idS = 3;
    
    [self.headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.userHead] forState:UIControlStateNormal placeholderImage:placeHoder];
    
    if (models.idCardIndex) {
        [self.IDfirstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.idCardIndex] forState:UIControlStateNormal placeholderImage:placeHoder];
    }
    
    if (models.idCardBack) {
        [self.IDsecondBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.idCardBack] forState:UIControlStateNormal placeholderImage:placeHoder];
    }
    
    if (models.licenseIndex) {
        [self.carfirstBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.licenseIndex] forState:UIControlStateNormal placeholderImage:placeHoder];
    }
    
    if (models.licenseBack) {
        [self.carsecondBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:models.licenseBack] forState:UIControlStateNormal placeholderImage:placeHoder];
    }
    
    if (models.idCard) {
        self.idCardLab.text = models.idCard;
    }
 
    [self.dataSource addObject:model];
    [self.dataSource addObject:model2];
    [self.dataSource addObject:model3];
    [self.dataSource addObject:model4];
    [self.myTableView reloadData];
}

- (void)clipsToBoundsWith:(UIView *)sender {
    sender.layer.cornerRadius = 7;
    sender.layer.masksToBounds = YES;
    sender.layer.borderColor = kCOLOR_HEX(0x999999).CGColor;
    sender.layer.borderWidth = 1;
}

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"个人资料";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    

    self.headBtn.layer.cornerRadius = 35;
    self.headBtn.layer.masksToBounds = YES;
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

- (IBAction)selectImage:(UIButton *)sender {
    self.imageTag = sender.tag - 100;
    [self showSelectPhoto];
}

- (IBAction)editID:(UIButton *)sender {
    PersonEditViewController *personEditVC = [[PersonEditViewController alloc] init];
    NSDictionary *dic = @{@"idCard":@""};

    personEditVC.mudic = dic.mutableCopy;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personEditVC animated:YES];
    
    [personEditVC setEditblock:^(NSString *str){
        self.idCardLab.text = str;
    }];
}


- (IBAction)editCarId:(UIButton *)sender {
    PersonEditViewController *personEditVC = [[PersonEditViewController alloc] init];
    NSDictionary *dic = @{@"license":@""};
    
    personEditVC.mudic = dic.mutableCopy;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personEditVC animated:YES];
    WS(weakSelf);
    [personEditVC setEditblock:^(NSString *str){
        weakSelf.carIDlab.text = str;

    }];
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //从字典key获取image的地址
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    
    [[HelpManager shareHelpManager] putImage:image WithView:self.view finish:^(NSString *url) {

        NSLog(@"%@", url);
        
        switch (self.imageTag) {
            case 0:
            {
                NSDictionary *dic = @{@"userHead":url};
                [self editUserDataWith:dic];
                [self.headBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
            case 1:
                
            {
                NSDictionary *dic = @{@"idCardIndex":url};
                [self editUserDataWith:dic];
                [self.IDfirstBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                NSDictionary *dic = @{@"idCardBack":url};
                [self editUserDataWith:dic];
                [self.IDsecondBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                NSDictionary *dic = @{@"licenseIndex":url};
                [self editUserDataWith:dic];
                [self.carfirstBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
            case 4:
            {
                NSDictionary *dic = @{@"licenseBack":url};
                [self editUserDataWith:dic];
                [self.carsecondBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
    } error:^(NSError *error) {
        
    }];
}


- (void)editUserDataWith:(NSDictionary *)dic {
    [APIManager DoUserEditWithParameters:dic.mutableCopy success:^(id data) {
        NSDictionary *modeldic = data;
        [userDef setObject:modeldic[@"userHead"] forKey:HeadImage];
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PersonDataModel *model = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
        cell.moreImage.hidden = YES;
    } else {
        cell.moreImage.hidden = NO;
    }
    [cell showData:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0 && indexPath.row != 3) {
        PersonEditViewController *personEditVC = [[PersonEditViewController alloc] init];
        
        NSDictionary *dic = @{};
        switch (indexPath.row) {
                
            case 1:
            {
                dic = @{@"nickName":@""};
            }
                break;
            case 2:
            {
                dic = @{@"mobile":@""};
            }
                break;
         
            default:
                break;
        }
        personEditVC.mudic = dic.mutableCopy;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personEditVC animated:YES];
        
        [personEditVC setEditblock:^(NSString *str){
            PersonDataModel *model = self.dataSource[indexPath.row];
            model.content = str;
            if (indexPath.row == 1) {
                [userDef setObject:str forKey:NickName];
            }
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    if (indexPath.row == 3) {
        ChangePasViewController *changeVC =[[ChangePasViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MyLog(@"-PersonalDataController-释放");
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
