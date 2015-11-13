//
//  RegisterView.h
//  ZhuanXB
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZXBRegisterView;
@protocol ZXBRegisterViewDelegate <NSObject>

-(void)registerWithPhoneNumber:(NSString * )phoneNumber AndCheckCode : (NSString *)checkCode withPassword:(NSString *)password AndAcount :  (NSString *)acount;

-(void)navToForgetVC;
@end

@interface ZXBRegisterView : UIView

@property (nonatomic,assign) id <ZXBRegisterViewDelegate> delegate;
@property (nonatomic,assign) NSTimer *registertimerCheck;
@end