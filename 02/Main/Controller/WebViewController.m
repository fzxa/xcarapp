//
//  WebViewController.m
//  02
//
//  Created by fzxa on 16/10/13.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import "WebViewController.h"
#import "BarButtonItem.h"
#import "Common.h"

@interface WebViewController () <UIWebViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation WebViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initWebView
{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    //添加navigationItem
    self.navigationItem.leftBarButtonItem = [BarButtonItem barButtonWithImage:@"nav_fanhui" title:@"返回" target:self action:@selector(backToLatesetView)];
    
    // 为webView添加点击手势
    UITapGestureRecognizer* singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    singleTapGesture.delegate = self; // 设置代理
    [self.webView addGestureRecognizer:singleTapGesture];
    
    [self.view addSubview:self.webView];
}

-(void)backToLatesetView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)handleSingleTapGesture:(UIGestureRecognizer *)sender {
    
    UIWebView *webView = (UIWebView *)sender.view;
    CGPoint pt = [sender locationInView:webView];
    NSString *urlString = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y]];
    if (urlString.length > 0) {
        NSLog(@"\nImage_URL:%@", urlString);
    }
}

@end
