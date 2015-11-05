//
//  ValuationToolsVC.m
//  ZhuanXB
//
//  Created by mac on 15/11/5.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import "ValuationToolsVC.h"
@interface ValuationToolsVC ()<UIWebViewDelegate>

@end

@implementation ValuationToolsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *cookieHost = [NSURL URLWithString:@"http://122.225.192.50:9100/ZXBMobileEx/web/evaluate"];
    //    [DPUtil setExpireTime:@"2015-11-03 22:51:38 +0000"];
    //    [DPUtil setExpireTime:@"2015-11-06 10:12:23"];
    //    [DPUtil setLoginToken:@"YTYwYWQ1NWU0MWQ3N2U1OGI0ZTEzMmMzZGVhZDdhMzgwNTM1MzcyNGVkMzBjMWRkYWY5NDMzMWYyODU4MWViMGI3NjAzN2I1YmI3NWE0OWE"];
    
    // 设定 cookie
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             [cookieHost host], NSHTTPCookieDomain,
                             [cookieHost path], NSHTTPCookiePath,
                             @"zxb-token",  NSHTTPCookieName,//默认的cookieName ： zxb-token
                             [DPUtil getLoginToken], NSHTTPCookieValue,//返回的token值
                             [DPUtil getExpireTime],NSHTTPCookieExpires,//返回的过期时间
                             nil]];
    
    // 设定 cookie 到 storage 中
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:cookieHost];
    
    UIWebView * valuationToolsWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    valuationToolsWebView.delegate = self;
    [self.view addSubview:valuationToolsWebView];
    [valuationToolsWebView loadRequest:requestObj];
    
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies= [sharedHTTPCookieStorage cookiesForURL:cookieHost];
    NSEnumerator *enumerator = [cookies objectEnumerator];
    while (cookie = [enumerator nextObject]) {
        NSLog(@"COOKIE{name: %@, value: %@  %@}", [cookie name], [cookie value],cookie.expiresDate);
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString * tit = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title  = tit;
}


@end
