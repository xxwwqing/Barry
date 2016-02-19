//
//  TaoBaoViewController.m
//  XWQGift
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 谢文清. All rights reserved.
//

#import "TaoBaoViewController.h"
#import <WebKit/WebKit.h>
#import "GiFHUD.h"

@interface TaoBaoViewController ()<WKNavigationDelegate>
{

    WKWebView *_webView;
    
}

@end

@implementation TaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @"商品详情";

    [GiFHUD setGifWithImageName:@"dd.gif"];

    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createWebView];

}


- (void)createWebView {

    _webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    //垂直不显示
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    _webView.navigationDelegate = self;
    
    [self.view addSubview:_webView];
    
    
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_url]];
    
    [_webView loadRequest:request];
}

#pragma mark --- 

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

    //[_activityIndicatorView startAnimating];

    [GiFHUD showWithOverlay];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    //[_activityIndicatorView stopAnimating];
    
    // 隐藏 loading 提示框
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [GiFHUD dismiss];
    });
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
