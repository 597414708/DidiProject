//
//  NewsDetailViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/3.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "ArticleListModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"

@interface VideoDetailViewController () <UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITableView *myTabView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (nonatomic,strong) MPMoviePlayerController *cgPlayer;
@property (nonatomic , copy) NSString *videoStr;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@end

@implementation VideoDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.cgPlayer pause];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(begainFullScreen) name:UIWindowDidBecomeVisibleNotification object:nil];//进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];//退出全屏
    
  
    [self creatData];
    [self creatUI];
}

- (IBAction)playButtonClick:(UIButton *)sender {
    //当前点击的cell的NSIndexPath标志
    if (![self.videoStr hasPrefix:@"http:"]) {
        [MBProgressHUD showMessage:@"找不到播放资源~" toView:self.view];
        return;
    }
    if(!_cgPlayer){
        _cgPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.videoStr]];
        self.cgPlayer.view.frame = CGRectMake(0, 0, TheW, TheW * 14 / 25);
        [self.cgPlayer prepareToPlay];
        self.cgPlayer.repeatMode = MPMovieRepeatModeNone;
        self.cgPlayer.scalingMode = MPMovieScalingModeAspectFit;
    }else{
    }
    [self.headerView addSubview:_cgPlayer.view];
}

- (void)begainFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    //强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


- (void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTabView beginUpdates];

    CGRect headerFrame = self.myTabView.tableHeaderView.frame;
    headerFrame.size.height = (TheW * 14 / 25.0) +  (TheW / 5.0) + 5;
    //修改tableHeaderView的frame
    self.myTabView.tableHeaderView.frame = headerFrame;
    [self.myTabView endUpdates];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = self.model.title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.myWebView.delegate = self;
    self.myWebView.userInteractionEnabled = NO;
    self.myWebView.scrollView.bounces = NO;
    
    [self.myTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"commentCell"];
    self.myTabView.delegate = self;
    self.myTabView.dataSource = self;
    self.myTabView.tableFooterView = [UIView new];
    self.nameLab.text = self.model.createName;
    self.timelab.text = self.model.createDate;
    
    self.headImage.layer.cornerRadius = 10;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.model.createHead] placeholderImage:placeHoder];
    
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:self.model.indexImg] placeholderImage:placeHoder];
    
    self.titleLab.text = self.model.title;
}
- (void)creatData {
    NSMutableDictionary *dic = @{@"id":self.model.id}.mutableCopy;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [APIManager GetArticleDetailWithParameters:dic success:^(id data) {
        NSDictionary *dic = data;
        ArticleListModel *model = [ArticleListModel mj_objectWithKeyValues:dic];
        NSString *str = model.content;
        self.videoStr = model.video;
        [self.myWebView loadHTMLString:[NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", str] baseURL:nil];

    } failure:^(NSError *error) {
        
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //    CGFloat documentHeight= [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];;
    
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    NSString *str=[NSString stringWithFormat:@"var script = document.createElement('script');"
                   "script.type = 'text/javascript';"
                   "script.text = \"function ResizeImages() { "
                   "var myimg,oldwidth;"
                   "var maxwidth =%f;" // UIWebView中显示的图片宽度
                   "for(i=0;i <document.images.length;i++){"
                   "myimg = document.images[i];"
                   "if(myimg.width > maxwidth){"
                   "oldwidth = myimg.width;"
                   "myimg.width = maxwidth;"
                   "}"
                   "}"
                   "}\";"
                   "document.getElementsByTagName('head')[0].appendChild(script);",TheW-15];
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
    webView.frame = CGRectMake(0, 0, TheW, clientheight);
    //获取WebView最佳尺寸（点）
    CGSize frame = [webView sizeThatFits:webView.frame.size];
    //获取内容实际高度（像素）
    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    //内容实际高度（像素）* 点和像素的比
    height = height * frame.height / clientheight;
    
    //再次设置WebView高度（点）
    webView.frame = CGRectMake(0, 0, TheW, height);
    
    [self.myTabView beginUpdates];
    [self.myTabView setTableFooterView:self.myWebView];
    [self.myTabView endUpdates];
}


#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    return cell;
}


- (void)dealloc
{
    MyLog(@"-VideoDetailViewController-释放");
    
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

