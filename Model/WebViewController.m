//
//  WebViewController.m
//  ELiuYan
//
//  Created by eliuyan_mac on 14-5-2.
//  Copyright (c) 2014年 chaoyong.com. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
//    NavCustom *nav=[[NavCustom alloc] init];
//    [nav setNav:_name mySelf:self];
    
    self.title = self.name;
    
    
    [super viewDidLoad];
    
    self.view.backgroundColor = ZhuanXB_color(0xe5e8ea);
    
//    UIImageView * backWhiteView;
//    
//    if (iPhone5||iPhone6||iPhone6Plus) {
//        backWhiteView = [[UIImageView alloc] initWithFrame:CGRectMake1(7.5, -2, 320 - 15 , 568 - 8  - 64 - 28)];
//    }else
//    {
//        backWhiteView = [[UIImageView alloc] initWithFrame:CGRectMake1(7.5, -2, 320 - 15 , 480 - 8  - 64 - 28)];
//        
//    }
//
//    backWhiteView.backgroundColor = [UIColor whiteColor];
//    backWhiteView.userInteractionEnabled = YES;
//    [self.view addSubview:backWhiteView];
//    
//    //UIView设置阴影
//    [[backWhiteView layer] setShadowOffset:CGSizeMake(1, 1)];
//    [[backWhiteView layer] setShadowRadius:3];
//    [[backWhiteView layer] setShadowOpacity:0.1];
//    [[backWhiteView layer] setShadowColor:[UIColor blackColor].CGColor];
//    //UIView设置边框
//    [[backWhiteView layer] setCornerRadius:3];
//    [[backWhiteView layer] setBorderColor:[UIColor whiteColor].CGColor];
//    
//    
//    UIImageView *buttomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 8 - 64, self.view.frame.size.width, 8)];
//    buttomView.backgroundColor = WaterPump_color(0x52c8d3);
//    [self.view addSubview:buttomView];
    
    // Do any additional setup after loading the view.
    UIWebView * myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    myWebView.backgroundColor=ZhuanXB_color(0xf5f5f5);
    myWebView.delegate = self;
    [self.view addSubview: myWebView];
    [myWebView loadRequest:request];
    
   
    
    _activity = [[Activity alloc] initWithActivity:self.view];
    
    
    
}
- (void )webViewDidStartLoad:(UIWebView  *)webView
{

    [_activity start];


}
- (void )webViewDidFinishLoad:(UIWebView  *)webView
{

    [_activity stop];
    

}

- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error
{
    
    
    [_activity stop];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    if (buttonIndex == 0)
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    
//    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//CG_INLINE CGRect
//CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//{
//    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//    CGRect rect;
//    //    NSLog(@"%f",myDelegate.autoSizeScaleX);
//    //    NSLog(@"%f",myDelegate.autoSizeScaleY);
//    rect.origin.x = x * myDelegate.autoSizeScaleX;
//    rect.origin.y = y * myDelegate.autoSizeScaleY;
//    rect.size.width = width * myDelegate.autoSizeScaleX;
//    rect.size.height = height * myDelegate.autoSizeScaleY;
//    return rect;
//}



@end
