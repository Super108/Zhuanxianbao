//
//  LoginView.h
//  ZhuanXB
//
//  Created by Stenson on 15/10/23.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;
@protocol loginViewDelegate <NSObject>

-(void)loginWithName:(NSString * )name withPassword:(NSString *)password;

-(void)navToForgetVC;

-(void)navToRegisterVC;
@end

@interface LoginView : UIView


@property (nonatomic,assign) id <loginViewDelegate> delegate;

@end
