//
//  InquireViewController.m
//  ZhuanXB
//
//  Created by shanchen on 15/6/11.
//  Copyright (c) 2015年 kang_dong. All rights reserved.
//

#import "InquireViewController.h"
#import "TrackingViewController.h"
#import "ScanViewController.h"

@interface InquireViewController ()

{
    UITextField *_textField ;
}


@end

@implementation InquireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"运单查询";
    self.view.backgroundColor = ZhuanXB_color(0xe6ebf0);
  
    //添加右边的添加按钮
    UIButton *navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    [navRightButton setBackgroundImage:[UIImage imageNamed:@"home640.png"] forState:UIControlStateNormal];
    [navRightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    //单号iamge
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(11, 43/2, self.view.frame.size.width-22, 87/2)];
    backImage.backgroundColor = [UIColor whiteColor];
    backImage.userInteractionEnabled = YES;
    [self.view addSubview:backImage];
    //单号textfield
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30,0, 250, 87/2)];
    _textField.placeholder = @"请输入单号";
    _textField.textColor = ZhuanXB_color(0x454545);
    _textField.backgroundColor = [UIColor clearColor];
    [backImage addSubview:_textField];
    
    //查询按钮
    UIButton *inquireBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inquireBtn.frame = CGRectMake(11, _textField.frame.origin.y+_textField.frame.size.height+45, self.view.frame.size.width-22, 82/2);
    [inquireBtn setBackgroundImage:[UIImage imageNamed:@"线路查询按钮.png"] forState:UIControlStateNormal];
    [inquireBtn addTarget:self action:@selector(inquireBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inquireBtn];
    
    //扫描按钮
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanBtn.frame = CGRectMake(11, inquireBtn.frame.origin.y+inquireBtn.frame.size.height+45, self.view.frame.size.width-22, 82/2);
    [scanBtn setBackgroundImage:[UIImage imageNamed:@"扫描查单.png"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(goScanVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
}

-(void)rightBtnClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoveToMain" object:nil];
}

-(void)inquireBtnClick
{
    
    //键盘下落
    
    [[UIApplication sharedApplication].keyWindow endEditing: YES];
    
    if ([_textField.text isEqualToString:@""]) {
        
        [self setHub:@"请您先输入单号"];
        
    }else
    {
        TrackingViewController *trackingVC = [[TrackingViewController alloc] init];
        
        trackingVC.snString = _textField.text;
        [self.navigationController pushViewController:trackingVC animated:NO];
    }
    
   
}

-(void)goScanVC
{
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
