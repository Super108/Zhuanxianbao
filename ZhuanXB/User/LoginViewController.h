//
//  LoginViewController.h
//  ZhuanXB
//
//  Created by Stenson on 15/10/23.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    LoginTypeSendProductVC = 0,   // 我要发货
    LoginTypePersonalCenterVC = 1 //个人中心
    
} LoginType;

#import "LoginView.h"
@interface LoginViewController : UIViewController<loginViewDelegate>

{
     UIView *_noInfoView;
}
@property (nonatomic, assign) LoginType loginType; // 类型
@end
