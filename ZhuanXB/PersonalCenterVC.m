//
//  PersonalCenterVC.m
//  ZhuanXB
//
//  Created by mac on 15/11/3.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import "PersonalCenterVC.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface PersonalCenterVC ()<UIWebViewDelegate>
{
    
}

@end

@implementation PersonalCenterVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *cookieHost = [NSURL URLWithString:@"http://122.225.192.50:9100/ZXBMobileEx/web/member"];
        
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
    
    UIWebView * personalWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    personalWebView.delegate = self;
    
    
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"AB" ofType:@"html"];
//    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    [personalWebView loadHTMLString: htmlString baseURL:[NSURL URLWithString:htmlPath]];
    
    
    [self.view addSubview:personalWebView];
    [personalWebView loadRequest:requestObj];
  
 
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
    
    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];NSHTTPCookie *cookie;
    for (id c in nCookies)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]]){
            cookie=(NSHTTPCookie *)c;
            NSLog(@"%@: %@", cookie.name, cookie.value);}
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    
//    NSLog(@"KKKK%@",urlComps);
    
    if([urlComps count] && [[urlComps objectAtIndex:0] isEqualToString:@"objc"])
    {
        NSArray *arrFucnameAndParameter = [(NSString*)[urlComps objectAtIndex:1] componentsSeparatedByString:@":/"];
        NSString *funcStr = [arrFucnameAndParameter objectAtIndex:0];
        if (1 == [arrFucnameAndParameter count])
        {
            // 没有参数
            if([funcStr isEqualToString:@"exit"])
            {
                /*调用本地函数*/
                [self exit];
            }
        }

        return NO;
    };
    return YES;
}

- (void)printLog:(NSString *)str
{
    NSLog(@"%@", str);
}

- (void)exit
{
    NSLog(@"js调用本地不带参数的方法成功！");
    //删除cookie 返回到主页
    
    [DPUtil removeToken];
    [DPUtil removeExpireTime];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
