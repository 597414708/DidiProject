//
//  CarDatainforViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CarDatainforViewController.h"
#import "CardataEditOneCell.h"
#import "CardataEditTwoCell.h"
#import "CardataEditThreeCell.h"
#import "AddressModel.h"

#import "AreaView.h"

#import "SelectDateViewController.h"

#import "ImageSelectView.h"

#import "InsuredPlanViewController.h"

#import "UserInfo.h"

@interface CarDatainforViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (strong, nonatomic)SelectDateViewController *dateVC;

@property (nonatomic, strong) AddressModel *addressmodel;

@property(nonatomic, strong)ImageSelectView *imageSelectView;//选择图片
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (nonatomic, strong) NSString *index;

@end

@implementation CarDatainforViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (AddressModel *)addressmodel {
    if (!_addressmodel) {
        self.addressmodel = [[AddressModel alloc] init];
        _addressmodel.className = @"过户日期";
        _addressmodel.placeholdStr = @"请选择日期";
        _addressmodel.tag = 0;
    }
    return _addressmodel;
}


-(SelectDateViewController *)dateVC{
    if (_dateVC==nil) {
        _dateVC = [[SelectDateViewController alloc]init];
        [self addChildViewController:_dateVC];
    }
    return _dateVC;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatData:self.tag];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = TheW * 153 / 375;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

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

- (IBAction)headImageAction:(UIButton *)sender {
    [self showSelectPhoto];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //从字典key获取image的地址
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [[HelpManager shareHelpManager] putImage:image WithView:self.view finish:^(NSString *url) {
        NSLog(@"%@", url);
        self.index = url;
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    } error:^(NSError *error) {
        
    }];
    
}


- (IBAction)finishAction:(UIButton *)sender {
    
    CarInforModel *model = [self getModel];
    if (model.licenseNo.length < 2) {
        [MBProgressHUD showMessage:@"请输入车牌号" toView:nil];
        return;
    }
    
    if (model.brand.length == 0) {
        [MBProgressHUD showMessage:@"请输入品牌型号" toView:nil];
        return;
    }
    
    if (model.engineNo.length == 0) {
        [MBProgressHUD showMessage:@"请输入发动机号" toView:nil];
        return;
    }
    
    if (model.carVin.length != 17) {
        [MBProgressHUD showMessage:@"请输入正确车辆识别号" toView:nil];
        return;
    }
    
    if (model.regTime.length == 0) {
        [MBProgressHUD showMessage:@"请输入注册日期" toView:nil];
        return;
    }
    
    if (model.transfer == 1) {
        if (model.transferTime.length == 0) {
            [MBProgressHUD showMessage:@"请输入过户日期" toView:nil];
            return;
        }
    }

    NSString *urlStr = @"";
    if (self.tag == 0) {
        urlStr = DoCarAdd;
    } else if (self.tag == 1){
        urlStr = DoCarEdit;
        model.id = self.model.id;
    }
    NSDictionary *DIC = [model mj_keyValues];
    if (self.tag  > 1) {
        InsuredPlanViewController *InsuredPlanVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"InsuredPlanVC"];
        UserInfo *inforModel = [[UserInfo alloc] init];
        inforModel.licenseNo = model.licenseNo;
        inforModel.carVin = model.carVin;
        inforModel.engineNo = model.engineNo;
        inforModel.registerDate = model.regTime;
        inforModel.cityCode = HelpPramodel.postmodel.cityCode;
        inforModel.licenseOwner = @"";
        inforModel.modleName = model.brand;
        InsuredPlanVC.inforModel = inforModel;
        [self.navigationController pushViewController:InsuredPlanVC animated:YES];
    } else {
        if (model.info1.length == 0) {
            [MBProgressHUD showMessage:@"请上传驾驶证正面" toView:nil];
            return;
        }
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [NewWorkingRequestManage requestPostWith:urlStr parDic:DIC finish:^(id responseObject) {
            [MBProgressHUD showMessage:@"成功" toView:nil];
            [self.navigationController popViewControllerAnimated:YES];
            if (self.myBlock) {
                self.myBlock();
            }
        } error:^(NSError *error) {
            
        }];
    }
}

- (CarInforModel *)getModel {
    CarInforModel *model = [[CarInforModel alloc] init];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    CardataEditOneCell *cell1 = [self.myTableView cellForRowAtIndexPath:path];
    model.licenseNo = [NSString stringWithFormat:@"%@%@", cell1.contentLab.text, cell1.contentTf.text];
    
    
    path = [NSIndexPath indexPathForRow:1 inSection:0];
    CardataEditTwoCell *cell2 = [self.myTableView cellForRowAtIndexPath:path];
    model.brand = [NSString stringWithFormat:@"%@", cell2.contentTf.text];
    
    path = [NSIndexPath indexPathForRow:2 inSection:0];
    cell2 = [self.myTableView cellForRowAtIndexPath:path];
    model.engineNo = [NSString stringWithFormat:@"%@", cell2.contentTf.text];
    
    path = [NSIndexPath indexPathForRow:3 inSection:0];
    cell2 = [self.myTableView cellForRowAtIndexPath:path];
    model.carVin = [NSString stringWithFormat:@"%@", cell2.contentTf.text];
    
    path = [NSIndexPath indexPathForRow:4 inSection:0];
    cell2 = [self.myTableView cellForRowAtIndexPath:path];
    model.regTime = [NSString stringWithFormat:@"%@", cell2.contentTf.text];
    
    path = [NSIndexPath indexPathForRow:5 inSection:0];
    CardataEditThreeCell *cell3 = [self.myTableView cellForRowAtIndexPath:path];
    if (cell3.selectControl.on) {
        model.transfer = 1;
        path = [NSIndexPath indexPathForRow:6 inSection:0];
        cell2 = [self.myTableView cellForRowAtIndexPath:path];
        model.transferTime = [NSString stringWithFormat:@"%@", cell2.contentTf.text];
    } else {
        model.transfer = 0;
    }
    
    model.info1 = self.index;
    return model;
}



- (void)creatData:(NSInteger)tag {
    
    
    AddressModel *model1 = [[AddressModel alloc] init];
    model1.className = @"车牌号码";
    model1.tag = 1;
    model1.placeholdStr = @"请输入车牌号码";
    model1.content = tag > 0 ? self.model.licenseNo:@"闽";
    
    AddressModel *model2 = [[AddressModel alloc] init];
    model2.className = @"品牌型号";
    model2.tag = 1;
    model2.placeholdStr = @"请输入品牌型号";
    model2.content = tag > 0 ? self.model.brand:@"";
    
    AddressModel *model3 = [[AddressModel alloc] init];
    model3.className = @"发动机号";
    model3.tag = 1;
    model3.placeholdStr = @"请输入发动机号";
    model3.content = tag > 0 ? self.model.engineNo:@"";
    
    AddressModel *model4 = [[AddressModel alloc] init];
    model4.className = @"车辆识别号";
    model4.tag = 1;
    model4.placeholdStr = @"请输入车辆识别号";
    model4.content = tag > 0 ? self.model.carVin:@"";
    
    AddressModel *model5 = [[AddressModel alloc] init];
    model5.className = @"注册日期";
    model5.tag = 0;
    model5.placeholdStr = @"请选择日期";
    model5.content = tag > 0 ? self.model.regTime:@"";
    
    AddressModel *model6 = [[AddressModel alloc] init];
    model6.className = @"是否过户车";
    model6.tag = tag > 0 ? self.model.transfer:0;;
    
    [self.dataSource addObject:model1];
    [self.dataSource addObject:model2];
    [self.dataSource addObject:model3];
    [self.dataSource addObject:model4];
    [self.dataSource addObject:model5];
    if (self.tag > 1) {
        
    } else {
        [self.dataSource addObject:model6];
        if (model6.tag > 0) {
            AddressModel *model7 = [[AddressModel alloc] init];
            model7.className = @"过户日期";
            model7.tag = 0;
            model7.placeholdStr = @"请选择日期";
            model7.content =  self.model.transferTime;
            [self.dataSource addObject:model7];
        }
    }
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.model.info1]];
    self.index = self.model.info1;
}


- (void)creatUI {
    self.headImage.layer.masksToBounds = YES;
    if (self.tag == 0) {
        [self.finishBtn setTitle:@"确认添加" forState:UIControlStateNormal];
    } else if(self.tag == 1) {
        [self.finishBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    } else {
        [self.finishBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"查看车辆";
    if (self.tag > 1) {
        titleLab.text = @"完善信息";
    }
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 51;
    [self.myTableView registerNib:[UINib nibWithNibName:@"CardataEditOneCell" bundle:nil] forCellReuseIdentifier:@"OneCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"CardataEditTwoCell" bundle:nil] forCellReuseIdentifier:@"TwoCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"CardataEditThreeCell" bundle:nil] forCellReuseIdentifier:@"ThreeCell"];
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    
    switch (indexPath.row) {
        case 0:
        {
            CardataEditOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            AddressModel *model = self.dataSource[indexPath.row];
            [cell showData:model];
            [cell setAreaBlock:^{
                
                UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
                UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
                [firstResponder resignFirstResponder];
                
                AreaView *view = [AreaView shareAreaViewWith:model.content];
                [[UIApplication sharedApplication].keyWindow addSubview:view];
                [view setAreaBlock:^(NSString *str){
                    
                    AddressModel *model = weakSelf.dataSource[0];
                    model.content = str;
                    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [weakSelf.myTableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
                }];
            }];
            return cell;
        }
            break;
            
        case 5:
        {
            CardataEditThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThreeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            AddressModel *model = self.dataSource[indexPath.row];
            [cell showData:model];
            [cell setMyBlock:^(UISwitch *sender){
                if (sender.on) {
                    [weakSelf.dataSource addObject:weakSelf.addressmodel];
                    NSIndexPath *index = [NSIndexPath indexPathForRow:weakSelf.dataSource.count - 1 inSection:0];
                    [tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationTop];
                } else {
                    NSIndexPath *index = [NSIndexPath indexPathForRow:weakSelf.dataSource.count - 1 inSection:0];
                    [weakSelf.dataSource removeObjectAtIndex:index.row];
                    [tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationTop];
                }
            }];
            return cell;
        }
            break;
        default:
        {
            
            CardataEditTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                cell.contentTf.keyboardType = UIKeyboardTypeDefault;
                cell.contentTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
            } else {
                cell.contentTf.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
                cell.contentTf.keyboardType = UIKeyboardTypeASCIICapable;
            
            }
            AddressModel *model = self.dataSource[indexPath.row];
            [cell showData:model];
            return cell;
        }
            break;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4 || indexPath.row == 6 ) {
        
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
        [firstResponder resignFirstResponder];
        
        [self.view addSubview:self.dateVC.view];
        [self.dateVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.bottom.equalTo(self.view);
        }];
        __weak typeof(self)blockSelf = self;
        [self.dateVC setDateSelectBlock:^(NSString *str){
            AddressModel *model = blockSelf.dataSource[indexPath.row];
            model.content = str;
            [blockSelf.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MyLog(@"-CarDatainforViewController-释放");
    
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
