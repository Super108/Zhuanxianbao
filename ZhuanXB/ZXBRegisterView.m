//
//  RegisterView.m
//  ZhuanXB
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import "ZXBRegisterView.h"

@interface ZXBRegisterView ()
#define  kSpace 70

#define kInputViewMarginLeft    11
#define kInputViewMarginTop     22
#define kInputViewWidth         _viewFrame.size.width - 22
#define kInputViewHeight        90

#define kgetCheckCodeBtnMarginLeft (kInputViewWidth-10)*2/5
#define kgetCheckCodeBtnMarginTop       kInputViewHeight/2+5
#define kgetCheckCodeBtnWidth         (kInputViewWidth-10)*3/5-10
#define kgetCheckCodeBtnHeight        35

#define kForgetPwdBtnMarginLeft    11
#define kForgetPwdBtnMarginTop     185+70
#define kForgetPwdBtnWidth         _viewFrame.size.width-22
#define kForgetPwdBtnHeight        45



{
    CGRect _viewFrame;
    UITextField * _acountField;
    UITextField * _nameField;
    UITextField * _pwdField;
    UITextField *_confirmPWDField;
    UITextField *_checkCodeField;
    UIButton *getRegisterCheckBtn;
    
}

@end

@implementation ZXBRegisterView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewFrame = frame;
        self.backgroundColor = MAIN_BackgroundColor;
        [self initView];
    }
    return self;
}

-(void)initView
{
    
     UIView * acountView = [[UIView alloc]initWithFrame:CGRectMake(kInputViewMarginLeft, kInputViewMarginTop, kInputViewWidth, kInputViewHeight)];
    acountView.backgroundColor = [UIColor whiteColor];
    acountView.layer.borderWidth = 1;
    acountView.layer.borderColor = [RGBA(182,182,182,1) CGColor];

    [self addSubview:acountView];

    UILabel * acountLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSpace+10, kInputViewHeight/2)];
    acountLab.backgroundColor = [UIColor clearColor];
    acountLab.textAlignment = NSTextAlignmentRight;
    acountLab.text =  @"用户名：";
    [acountView addSubview:acountLab];
    
    _acountField = [[UITextField alloc]initWithFrame:CGRectMake(kSpace, 0, kInputViewWidth - kSpace, kInputViewHeight/2)];
    //    _nameField.backgroundColor=[UIColor yellowColor];
//    _acountField.placeholder = @"请输入11位手机号";
    [acountView addSubview:_acountField];
    
    
    UIView * inputView = [[UIView alloc]initWithFrame:CGRectMake(kInputViewMarginLeft, acountView.frame.origin.y+acountView.frame.size.height-45, kInputViewWidth, kInputViewHeight+45)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self addSubview:inputView];
    inputView.layer.borderWidth = 1;
    inputView.layer.borderColor = [RGBA(182,182,182,1) CGColor];
    
    CALayer * lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, kInputViewHeight/2 - .5f, kInputViewWidth, 1);
    lineLayer.backgroundColor = inputView.layer.borderColor;
    [inputView.layer addSublayer:lineLayer];
    
    UIView * passwordView = [[UIView alloc]initWithFrame:CGRectMake(kInputViewMarginLeft, inputView.frame.origin.y+inputView.frame.size.height-45, kInputViewWidth, kInputViewHeight)];
    passwordView.backgroundColor = [UIColor whiteColor];
    [self addSubview:passwordView];
    passwordView.layer.borderWidth = 1;
    passwordView.layer.borderColor = [RGBA(182,182,182,1) CGColor];
    
    CALayer * lineLayer2 = [CALayer layer];
    lineLayer2.frame = CGRectMake(0, kInputViewHeight/2 - .5f, kInputViewWidth, 1);
    lineLayer2.backgroundColor = passwordView.layer.borderColor;
    [passwordView.layer addSublayer:lineLayer2];
    
    UILabel * userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSpace+10, kInputViewHeight/2)];
    userNameLab.backgroundColor = [UIColor clearColor];
    userNameLab.textAlignment = NSTextAlignmentRight;
    userNameLab.text =  @"手机号：";
    [inputView addSubview:userNameLab];
    
    UILabel * userPwdLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSpace+25, kInputViewHeight/2)];
    userPwdLab.backgroundColor = [UIColor clearColor];
    userPwdLab.textAlignment = NSTextAlignmentRight;
    userPwdLab.text =  @"新 密 码：";
    [passwordView addSubview:userPwdLab];
    
    UILabel * confirmUserPwdLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kInputViewHeight / 2 , kSpace+30, kInputViewHeight/2)];
    //    confirmUserPwdLab.backgroundColor = [UIColor blueColor];
    confirmUserPwdLab.textAlignment = NSTextAlignmentRight;
    confirmUserPwdLab.text =  @"确认密码：";
    [passwordView addSubview:confirmUserPwdLab];
    
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(kSpace, 0, kInputViewWidth - kSpace, kInputViewHeight/2)];
    //    _nameField.backgroundColor=[UIColor yellowColor];
    _nameField.placeholder = @"请输入11位手机号";
    [inputView addSubview:_nameField];
    
    _checkCodeField = [[UITextField alloc]initWithFrame:CGRectMake(10,  kInputViewHeight/2, (inputView.frame.size.width-10)*2/5, kInputViewHeight/2)];
    _checkCodeField.placeholder = @"请输入验证码";
    [inputView addSubview:_checkCodeField];
    
    
    
    
    
    _pwdField = [[UITextField alloc]initWithFrame:CGRectMake(kSpace+25, 0 , kInputViewWidth - kSpace-25, kInputViewHeight/2)];
    //    _pwdField.backgroundColor=[UIColor redColor];
    _pwdField.secureTextEntry = YES;
    //    _pwdField.placeholder = @"4 - 30位数字或字母";
    [passwordView addSubview:_pwdField];
    _confirmPWDField = [[UITextField alloc]initWithFrame:CGRectMake(kSpace+30, kInputViewHeight / 2, kInputViewWidth - kSpace-30, kInputViewHeight/2)];
    //    _confirmPWDField.backgroundColor=[UIColor greenColor];
    _confirmPWDField.secureTextEntry = YES;
    //    _confirmPWDField.placeholder = @"4 - 30位数字或字母";
    [passwordView addSubview:_confirmPWDField];
    
    //获取验证码
    getRegisterCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getRegisterCheckBtn.frame = CGRectMake(kgetCheckCodeBtnMarginLeft+10, kgetCheckCodeBtnMarginTop, kgetCheckCodeBtnWidth, kgetCheckCodeBtnHeight);
    getRegisterCheckBtn.layer.cornerRadius=2;
    getRegisterCheckBtn.clipsToBounds=YES;
    getRegisterCheckBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    getRegisterCheckBtn.layer.borderWidth=0.2;
    getRegisterCheckBtn.backgroundColor=RGBA(70,174,214,1);
    //    [getCheckCodeBtn setBackgroundImage:[UIImage imageNamed:@"线路查询按钮.png"] forState:UIControlStateNormal];
    [getRegisterCheckBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getRegisterCheckBtn addTarget:self action:@selector(sendMessageToMobile:) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:getRegisterCheckBtn];
    //重置密码
    UIButton *submitComfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitComfirmBtn.frame = CGRectMake(kForgetPwdBtnMarginLeft, kForgetPwdBtnMarginTop+10, kForgetPwdBtnWidth, kForgetPwdBtnHeight);
    submitComfirmBtn.backgroundColor=RGBA(70,174,214,1);
    submitComfirmBtn.layer.cornerRadius=2;
    submitComfirmBtn.clipsToBounds=YES;
    [submitComfirmBtn setTitle:@"注册按钮" forState:UIControlStateNormal];
    [submitComfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    submitComfirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitComfirmBtn addTarget:self action:@selector(submitRegister) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:submitComfirmBtn];
    
}

-(void)sendMessageToMobile:(UIButton *)sender{
    
    NSLog(@"发送短信验证码");
    //    [ZSAppServer sendCheckCodeWithPhoneNumber:_nameField.text success:^(NSString *successMsg, id data) {
    //        NSLog(@"%@",data);
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
    
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",_nameField.text, @"mobile",timeString, @"time",nil];
    NSLog(@"%@",dic);
    NSString * allStr= @"";
    
    //排序key
    NSArray* keyArr = [dic allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    //            NSLog(@"%@",keyArr);
    
    for (int i=0; i<=2; i++)
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
    
    
    
    
    NSString *param=[NSString stringWithFormat:@"appId=%@&mobile=%@&time=%@&sign=%@",appID,_nameField.text,timeString,sign];
    NSURL *URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@/shipper/register/sendCode?%@",ZhuanXB_address,param]];//不需要传递参数
    
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
                
                [self setHub:@"成功发送验证码"];
                sender.selected=YES;
                sender.userInteractionEnabled=NO;
                sender.backgroundColor=[UIColor grayColor];
                sender.tag=60;
                if (sender.selected==YES) {
                    [getRegisterCheckBtn setTitle:[NSString stringWithFormat:@"(%ld)秒后重发",(long)getRegisterCheckBtn.tag] forState:UIControlStateSelected];
                    _registertimerCheck=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(myRegistertimeDown) userInfo:nil repeats:YES];
                }
                
                
            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"-1"])
            {
                
                [self setHub:@"手机号码不存在"];
                
            }else if ([[result1 objectForKey:@"code"]isEqualToString:@"-2"])
            {
                
                [self setHub:@"超过当日发送限制"];
                
            }else
            {
                
                [self setHub:@"发送验证码失败"];
                
                
            }
        }
        
    }
    

}
-(void)myRegistertimeDown{
    NSLog(@"%ld",(long)getRegisterCheckBtn.tag);
    NSString *getString;
    if(getRegisterCheckBtn.tag>0){
        getRegisterCheckBtn.tag--;
        getString=[NSString stringWithFormat:@"(%ld)秒后重发",(long)getRegisterCheckBtn.tag];
    }
    if (getRegisterCheckBtn.tag<=0) {
        getString=@"获取验证码";
    }
    [getRegisterCheckBtn setTitle:getString forState:UIControlStateNormal];
    [getRegisterCheckBtn setTitle:getString forState:UIControlStateSelected];
    if (getRegisterCheckBtn.tag<=0) {
        getRegisterCheckBtn.userInteractionEnabled=YES;
        getRegisterCheckBtn.selected=NO;
        getRegisterCheckBtn.backgroundColor=RGBA(70,174,214,1);
        [_registertimerCheck invalidate];
        _registertimerCheck=nil;
    }
}
-(void)submitRegister{
    
    if (_nameField.text.length == 0 || _pwdField.text.length == 0) {
        [self setHub:@"用户名或密码不能为空"];
        return;
    }else if(_pwdField.text.length < 4){
        [self setHub:@"请输入正确的密码"];
        return;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(registerWithPhoneNumber:AndCheckCode:withPassword:AndAcount:)]) {
        [self.delegate registerWithPhoneNumber:_nameField.text AndCheckCode:_checkCodeField.text withPassword:_confirmPWDField.text AndAcount:_acountField.text];
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
  
    if ([self.delegate respondsToSelector:@selector(navToForgetVC)]) {


        [self.delegate navToForgetVC];
    }
}
-(void)touchesBegan:(UITouch  *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end