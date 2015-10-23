//
//  LoginView.m
//  ZhuanXB
//
//  Created by Stenson on 15/10/23.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#define kInputViewMarginLeft    11
#define kInputViewMarginTop     22
#define kInputViewWidth         _viewFrame.size.width - 22
#define kInputViewHeight        90

#define kLoginBtnMarginLeft    11
#define kLoginBtnMarginTop     134
#define kLoginBtnWidth         _viewFrame.size.width - 22
#define kLoginBtnHeight        40

#define kForgetPwdBtnMarginLeft    11
#define kForgetPwdBtnMarginTop     185
#define kForgetPwdBtnWidth         70
#define kForgetPwdBtnHeight        40

#import "LoginView.h"

@interface LoginView ()
{
    CGRect _viewFrame;
    
    UITextField * _nameField;
    UITextField * _pwdField;
}

@end

@implementation LoginView

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
    UIView * inputView = [[UIView alloc]initWithFrame:CGRectMake(kInputViewMarginLeft, kInputViewMarginTop, kInputViewWidth, kInputViewHeight)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self addSubview:inputView];
    inputView.layer.borderWidth = 1;
    inputView.layer.borderColor = [RGBA(182,182,182,1) CGColor];
    
    CALayer * lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, kInputViewHeight/2 - .5f, kInputViewWidth, 1);
    lineLayer.backgroundColor = inputView.layer.borderColor;
    [inputView.layer addSublayer:lineLayer];
    
    UILabel * userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, kInputViewHeight/2)];
    userNameLab.backgroundColor = [UIColor clearColor];
    userNameLab.textAlignment = NSTextAlignmentRight;
    userNameLab.text =  @"账户：";
    [inputView addSubview:userNameLab];

    UILabel * userPwdLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kInputViewHeight/2, 65, kInputViewHeight/2)];
    userPwdLab.backgroundColor = [UIColor clearColor];
    userPwdLab.textAlignment = NSTextAlignmentRight;
    userPwdLab.text =  @"密码：";
    [inputView addSubview:userPwdLab];
    
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(65, 0, kInputViewWidth - 65, kInputViewHeight/2)];
    _nameField.placeholder = @"手机号/用户名";
    [inputView addSubview:_nameField];
    
    _pwdField = [[UITextField alloc]initWithFrame:CGRectMake(65, kInputViewHeight / 2, kInputViewWidth - 65, kInputViewHeight/2)];
    _pwdField.secureTextEntry = YES;
    _pwdField.placeholder = @"4 - 30位数字或字母";
    [inputView addSubview:_pwdField];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(kLoginBtnMarginLeft, kLoginBtnMarginTop, kLoginBtnWidth, kLoginBtnHeight);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"线路查询按钮.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(navToUserCenter) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(kForgetPwdBtnMarginLeft, kForgetPwdBtnMarginTop, kForgetPwdBtnWidth, kForgetPwdBtnHeight);
    [forgetPwdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:RGBA(182, 182, 182, 1) forState:UIControlStateNormal];
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetPwdBtn addTarget:self action:@selector(navToForgetVC) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetPwdBtn];
    
}

-(void)navToUserCenter{
    
    if (_nameField.text.length == 0 | _pwdField.text.length == 0) {
        [self setHub:@"用户名或密码不能为空"];
        return;
    }else if(_pwdField.text.length < 4){
        [self setHub:@"请输入正确的密码"];
        return;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(loginWithName:withPassword:)]) {
        [self.delegate loginWithName:_nameField.text withPassword:_pwdField.text];
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
