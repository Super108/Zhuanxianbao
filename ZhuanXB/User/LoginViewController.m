//
//  LoginViewController.m
//  ZhuanXB
//
//  Created by Stenson on 15/10/23.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import "LoginViewController.h"
#import "ZSAppServer.h"
#import "RetrievePasswordVC.h"
#import "SendProductVC.h"
#import "PersonalCenterVC.h"
#import "ZXBRegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户登录";
    
    [self initRightNavBarItem];
    
    [self initView];
}

-(void)initRightNavBarItem
{
    //添加右边的添加按钮
    UIButton *navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [navRightButton setBackgroundImage:[UIImage imageNamed:@"home640.png"] forState:UIControlStateNormal];
    [navRightButton addTarget:self action:@selector(navToHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView: navRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0f){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -7.5;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, rightItem];
    }
    else{
        self.navigationItem.rightBarButtonItem = rightItem;
    }

}
-(void)navToHome
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoveToMain" object:nil];
}

-(void)initView
{
    LoginView * loginView = [[LoginView alloc]initWithFrame:self.view.frame];
    loginView.delegate = self;
    [self.view addSubview:loginView];
}

-(void)loginWithName:(NSString *)name withPassword:(NSString *)password
{
    NSLog(@">>>   %@   %@",name,password);
    
//    [ZSAppServer loginUserWithUserName:name
//                          withPassword:password
//                               success:^(NSString *successMsg, id data) {
//                                   NSLog(@">>>   %@",data);
//                                  
//                                   
//                                   if([[data objectForKey:@"code"] integerValue] == 1){
//                                       NSLog(@"密码正确进入个人中心页面");
//                                       if([DPUtil isNotNull:[data objectForKey:@"value"]]){
//                                           NSDictionary * userDic = [data objectForKey:@"value"];
//                                           [DPUtil setLoginToken:[userDic objectForKey:@"token"]];
//                                           [DPUtil setExpireTime:[userDic objectForKey:@"expireTime"]];
//                                       }
//                                   }else if ([[data objectForKey:@"code"] integerValue] == -1){
//                                       [self setHub:@"用户或者密码不正确"];
//                                   }else{
//                                       [self setHub:@"服务器出错了"];
//                                   }
//                               } fail:^(NSString *errorMsg, NSString *errorCode) {
//                                   [self setHub:@"登录失败，请稍后重试"];
//                               } error:^(NSError *error) {
//                                   [self setHub:@"登录失败，请稍后重试"];
//                               }];
    
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"%@",timeString);
    
       
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",name, @"accountName",password, @"password",timeString, @"time",nil];
    NSLog(@"%@",dic);
    NSString * allStr= @"";
    
    //排序key
    NSArray* keyArr = [dic allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    //            NSLog(@"%@",keyArr);
    
    for (int i=0; i<=3; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%@",[keyArr objectAtIndex:i]];
        NSLog(@"%@",str);
        allStr = [NSString stringWithFormat:@"%@%@=%@",allStr,[keyArr objectAtIndex:i],[dic objectForKey:[keyArr objectAtIndex:i]]];
    }
    NSLog(@"%@",allStr);
    
    NSString *resultStr = [NSString stringWithFormat:@"%@%@",allStr,secretKey];
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)resultStr,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    
    NSLog(@"%@",encodedString);
    NSString *sign = [encodedString MD5];
    
    
    
    
    NSString *param=[NSString stringWithFormat:@"appId=%@&password=%@&accountName=%@&time=%@&sign=%@",appID,password,name,timeString,sign];
    NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/login?%@",ZhuanXB_address,param]];//不需要传递参数
    
    NSLog(@"%@",URL);
    
    
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod=@"POST";//设置请求方法
    
    //第三步，连接服务器
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    NSLog(@"%@",connection);
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (received==nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
//        [self createNoView];
        [alert show];
    }else
    {
        NSError *error1=nil;
        id result1 =[NSJSONSerialization JSONObjectWithData:received options:kNilOptions error:&error1];
        NSLog(@"%@",result1);
        if (result1==nil) {
            
            
            return;
        }else
        {
             if ([[result1 objectForKey:@"code"]isEqualToString:@"1"]) {//正确
                 
                 
                 if(self.loginType==LoginTypePersonalCenterVC){
                     PersonalCenterVC *personVC=[[PersonalCenterVC alloc] init];
                     [self.navigationController pushViewController:personVC animated:YES];
                 }
                 else if(self.loginType==LoginTypeSendProductVC)
                 {
                     SendProductVC * sendProVC = [[SendProductVC alloc] init];
                     [self.navigationController pushViewController:sendProVC animated:YES];
                 }
                 NSLog(@"密码正确进入个人中心页面");
                 if([DPUtil isNotNull:[result1 objectForKey:@"value"]]){
                     NSDictionary * userDic = [result1 objectForKey:@"value"];
                     [DPUtil setLoginToken:[userDic objectForKey:@"token"]];
                     [DPUtil setExpireTime:[userDic objectForKey:@"expireTime"]];
                 }
                 
             }else if ([[result1 objectForKey:@"code"]isEqualToString:@"-1"])
             {
                 
                 [self setHub:@"用户或者密码不正确"];
                 
             }else
             {
                 
                 [self setHub:@"登录失败，请稍后重试"];
                 
                 
             }
        }
       
    }


    
}
-(void)createNoView
{
    _noInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _noInfoView.backgroundColor = ZhuanXB_color(0xe3e6ea);
    [self.view addSubview:_noInfoView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_noInfoView.frame.size.width/2-236/4, 60, 236/2, 220/2)];
    imageView.image = [UIImage imageNamed:@"运单列表_无数据.png"];
    [_noInfoView addSubview:imageView];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height+imageView.frame.origin.y+10, 320, 30)];
    aLabel.text = @"暂时没有找到相关数据";
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.font = [UIFont systemFontOfSize:18.0];
    aLabel.textColor = ZhuanXB_color(0x78848d);
    [_noInfoView addSubview:aLabel];
    
}

-(void)setHub:(NSString *)string
{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1];
    MBProgressHUD *indicator = [[MBProgressHUD alloc] initWithWindow:window];
    indicator.labelText = string;
    indicator.mode = MBProgressHUDModeText;
    [window addSubview:indicator];
    [indicator showAnimated:YES whileExecutingBlock:^{
        sleep(1.2);
    } completionBlock:^{
        [indicator removeFromSuperview];
    }];
    
}

-(void)navToForgetVC
{
    NSLog(@"进入忘记密码页面");
   RetrievePasswordVC *retrievePasswordVC= [[RetrievePasswordVC alloc] init];
    [self.navigationController pushViewController:retrievePasswordVC animated:YES];
}
-(void)navToRegisterVC{
     NSLog(@"进入注册页面");
    ZXBRegisterViewController *registerVC=[[ZXBRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
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
