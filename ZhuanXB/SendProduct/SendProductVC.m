//
//  SendProductVC.m
//  ZhuanXB
//
//  Created by Stenson on 15/11/2.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import "SendProductVC.h"

@interface SendProductVC ()

@end

@implementation SendProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden=YES;
    
    NSURL *cookieHost = [NSURL URLWithString:@"http://122.225.192.50:9100/ZXBMobileEx/web/trade/goods"];
    
#warning todo  自己设置的过期时间 会变成当天0点。
    
//    [DPUtil setExpireTime:@"2015-11-03 22:51:38 +0000"];
    [DPUtil setExpireTime:@"2015-11-06 10:12:23"];
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
    
    UIWebView * sendProductWebView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:sendProductWebView];
    [sendProductWebView loadRequest:requestObj];
    
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSArray *cookies= [sharedHTTPCookieStorage cookiesForURL:cookieHost];
    NSLog(@">>>>   %@",cookies);
    NSEnumerator *enumerator = [cookies objectEnumerator];
    NSHTTPCookie *cookie1;
    while (cookie = [enumerator nextObject]) {
        NSLog(@"COOKIE{name: %@, value: %@  %@}", [cookie name], [cookie value],cookie.expiresDate);
    }
    
    
    
    
    
    

    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 20, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"640返回"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backToHomeView) forControlEvents:UIControlEventTouchUpInside];

}

-(void)backToHomeView
{
    [self.navigationController popViewControllerAnimated:YES];
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
