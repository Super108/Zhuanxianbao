//
//  RetrievePasswordVC.m
//  ZhuanXB
//
//  Created by mac on 15/10/25.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import "RetrievePasswordVC.h"
#import "ZSAppServer.h"
@interface RetrievePasswordVC ()

@end

@implementation RetrievePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"重置密码";
    
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
    RetrievePasswordView * retrievePasswordView = [[RetrievePasswordView alloc]initWithFrame:self.view.frame];
    retrievePasswordView.delegate = self;
    [self.view addSubview:retrievePasswordView];
}

-(void)retrieveWithPhoneNumber:(NSString * )phoneNumber AndCheckCode : (NSString *)checkCode withPassword:(NSString *)password
{
    NSLog(@">>>   %@   %@",phoneNumber,password);
    
//    [ZSAppServer loginUserWithUserName:name
//                          withPassword:password
//                               success:^(NSString *successMsg, id data) {
//                                   NSLog(@">>>>  %@",data);
//                               } fail:^(NSString *errorMsg, NSString *errorCode) {
//                                   [self setHub:@"登录失败，请稍后重试"];
//                               } error:^(NSError *error) {
//                                   [self setHub:@"登录失败，请稍后重试"];
//                               }];
//    [ZSAppServer findLostPasswordWithPhoneNumber:phoneNumber withNewPassword:password withCheckCode:checkCode success:^(NSString *successMsg, id data) {
//        
//    } fail:^(NSString *errorMsg, NSString *errorCode) {
//        
//    } error:^(NSError *error) {
//        
//    }];
    
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"%@",timeString);
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",phoneNumber, @"mobile",password, @"password",checkCode, @"validateCode",timeString, @"time",nil];
    NSLog(@"%@",dic);
    NSString * allStr= @"";
    
    //排序key
    NSArray* keyArr = [dic allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    //            NSLog(@"%@",keyArr);
    
    for (int i=0; i<=4; i++)
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
    
    
    
    
    NSString *param=[NSString stringWithFormat:@"appId=%@&mobile=%@&password=%@&validateCode=%@&time=%@&sign=%@",appID,phoneNumber,password,checkCode,timeString,sign];
    NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/password?%@",ZhuanXB_address,param]];//不需要传递参数
    
    NSLog(@"%@",URL);
    
    
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    request.HTTPMethod=@"POST";//设置请求方法
    
    //第三步，连接服务器
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    NSLog(@"%@",connection);
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (received==nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络断了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
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
                
                [self setHub:@"重置密码成功"];
                
                
            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"-1"])
            {
                
                [self setHub:@"手机号码不存在"];
                
            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"-2"])
            {
                
                [self setHub:@"验证码不正确"];
                
            }else
            {
                
                [self setHub:@"发送验证码失败"];
                
                
            }
        }
        
    }

    
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
    NSLog(@"返回登录页面");
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
