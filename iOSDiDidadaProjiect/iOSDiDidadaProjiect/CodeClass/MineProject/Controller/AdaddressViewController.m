//
//  AdaddressViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/9.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AdaddressViewController.h"
#import "AdaddressTableViewCell.h"
#import "AddressModel.h"
#import "CityWithIdPickView.h"


@interface AdaddressViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong)CityWithIdPickView *cityPickView;

@end

@implementation AdaddressViewController



-(CityWithIdPickView *)cityPickView
{
    if (_cityPickView==nil) {
        _cityPickView = [[CityWithIdPickView alloc] initWithFrame:CGRectMake(0, TheH-256, self.view.frame.size.width,  256)];
        _cityPickView.backgroundColor = [UIColor whiteColor];//设置背景颜色
        _cityPickView.toolshidden = NO; //默认是显示的，如不需要，toolsHidden设置为yes
        //每次滚动结束都会返回值
        __weak AdaddressViewController *selfBlock=self;
        _cityPickView.confirmblock = ^(NSString *proVince,NSString *city,NSString *area) {
//            selfBlock.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",proVince,city,area];
        };
        //点击确定按钮回调
        _cityPickView.doneBlock = ^(NSString *proVince, NSString *city, NSString *area, NSString *provinceId, NSString *cityId, NSString *areaId){
            
            AddressModel *model = selfBlock.dataSource[2];
           
            model.content = [NSString stringWithFormat:@"%@ %@ %@",proVince,city,area];
            NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
            [selfBlock.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
            

            [selfBlock.cityPickView removeFromSuperview];
            
        };
        //点击取消按钮回调
        _cityPickView.cancelblock = ^(){
            [selfBlock.cityPickView removeFromSuperview];
        };
        
    }
    return _cityPickView;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"地址管理";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 46;
    [self.myTableView registerNib:[UINib nibWithNibName:@"AdaddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AdaddressCell"];
}
- (IBAction)finishAction:(UIButton *)sender {
    
    AddressDataModel *model = [self getModel];
    if (model.name.length < 2) {
        [MBProgressHUD showMessage:@"请输入姓名" toView:nil];
        return;
    }
    
    if (model.mobile.length == 0) {
        [MBProgressHUD showMessage:@"请输入手机号" toView:nil];
        return;
    }
    
    if (model.city.length == 0) {
        [MBProgressHUD showMessage:@"请输入地区" toView:nil];
        return;
    }
    
    if (model.address.length == 0) {
        [MBProgressHUD showMessage:@"请输入详细地址" toView:nil];
        return;
    }
   
    NSString *urlStr = @"";

    if (self.tag == 0) {
        urlStr = Addressadd;
    } else {
        urlStr = Addressedit;
        model.id = self.model.id;
    }
    NSDictionary *DIC = [model mj_keyValues];
    
    
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


- (void)creatData {
    AddressModel *model1 = [[AddressModel alloc] init];
    model1.className = @"收件人";
    model1.tag = 1;
    model1.placeholdStr = @"请输入姓名";
    model1.content = self.tag > 0 ? self.model.name:@"";
    
    AddressModel *model2 = [[AddressModel alloc] init];
    model2.className = @"手机号码";
    model2.tag = 1;
    model2.placeholdStr = @"请输入手机号";
    model2.content = self.tag > 0 ? self.model.mobile:@"";

    AddressModel *model3 = [[AddressModel alloc] init];
    model3.className = @"所在地区";
    model3.tag = 0;
    model3.placeholdStr = @"请选择地区";
    model3.content = self.tag > 0 ? [NSString stringWithFormat:@"%@ %@ %@", self.model.province, self.model.city, self.model.country]:@"";

    AddressModel *model4 = [[AddressModel alloc] init];
    model4.className = @"详细地址";
    model4.tag = 1;
    model4.placeholdStr = @"请输入详细地址";
    model4.content = self.tag > 0 ? self.model.address:@"";
    
    AddressModel *model5 = [[AddressModel alloc] init];
    model5.className = @"邮政编码";
    model5.tag = 1;
    model5.placeholdStr = @"请输入邮政编码";
    model5.content = self.tag > 0 ? self.model.address:@"";

    [self.dataSource addObject:model1];
    [self.dataSource addObject:model2];
    [self.dataSource addObject:model3];
    [self.dataSource addObject:model4];
//    [self.dataSource addObject:model5];

}
- (AddressDataModel *)getModel {
    AddressDataModel *model = [[AddressDataModel alloc] init];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    AdaddressTableViewCell *cell1 = [self.myTableView cellForRowAtIndexPath:path];
    model.name = [NSString stringWithFormat:@"%@", cell1.contentTf.text];
    
    
    path = [NSIndexPath indexPathForRow:1 inSection:0];
    cell1 = [self.myTableView cellForRowAtIndexPath:path];
    model.mobile = [NSString stringWithFormat:@"%@", cell1.contentTf.text];
    
    path = [NSIndexPath indexPathForRow:2 inSection:0];
    cell1 = [self.myTableView cellForRowAtIndexPath:path];
    NSArray * arr = [cell1.contentTf.text componentsSeparatedByString:@" "];
    
    model.province = arr.firstObject;
    model.city = arr[1];
    model.country = arr[2];
    
    path = [NSIndexPath indexPathForRow:3 inSection:0];
    cell1 = [self.myTableView cellForRowAtIndexPath:path];
    model.address = [NSString stringWithFormat:@"%@", cell1.contentTf.text];
//
//    path = [NSIndexPath indexPathForRow:4 inSection:0];
//    cell1 = [self.myTableView cellForRowAtIndexPath:path];
//    model.regTime = [NSString stringWithFormat:@"%@", cell2.contentTf.text];

    return model;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdaddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdaddressCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AddressModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    
    if (indexPath.row == 1) {
        cell.contentTf.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        cell.contentTf.keyboardType = UIKeyboardTypeDefault;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
        [firstResponder resignFirstResponder];
        
        [self.view addSubview:self.cityPickView];

    }
}

- (void)dealloc {
    MyLog(@"-AdaddressViewController-释放");
    
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
