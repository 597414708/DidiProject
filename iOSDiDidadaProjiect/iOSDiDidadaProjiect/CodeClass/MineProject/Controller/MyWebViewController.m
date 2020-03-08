//
//  MyWebViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/22.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MyWebViewController.h"

@interface MyWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation MyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myWebView.delegate = self;
    if (self.webUrl) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    }
    
    
    
    if (self.type) {
        NSDictionary *dic = @{@"type":self.type};
        
        [APIManager GetCommonTextWithParameters:dic.mutableCopy success:^(id data) {
            NSDictionary *dic = data;
            self.webUrl = dic[@"content"];
            [self.myWebView loadHTMLString:[NSString stringWithFormat:@"%@",self.webUrl] baseURL:nil];
        } failure:^(NSError *error) {
            
        }];
     
    }
   

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
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
                   "document.getElementsByTagName('head')[0].appendChild(script);",self.view.frame.size.width-15];
    [self.myWebView stringByEvaluatingJavaScriptFromString:str];
    [self.myWebView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    MyLog(@"-MyWebViewController-释放");
    
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
