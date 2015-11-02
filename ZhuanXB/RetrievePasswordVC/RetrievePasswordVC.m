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
    [ZSAppServer findLostPasswordWithPhoneNumber:phoneNumber withNewPassword:password withCheckCode:checkCode success:^(NSString *successMsg, id data) {
        
    } fail:^(NSString *errorMsg, NSString *errorCode) {
        
    } error:^(NSError *error) {
        
    }];
    
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
