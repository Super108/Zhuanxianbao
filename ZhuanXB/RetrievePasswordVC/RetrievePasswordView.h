//
//  RetrievePasswordView.h
//  ZhuanXB
//
//  Created by mac on 15/11/1.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RetrievePasswordView;
@protocol RetrievePasswordViewDelegate <NSObject>

-(void)retrieveWithPhoneNumber:(NSString * )phoneNumber AndCheckCode : (NSString *)checkCode withPassword:(NSString *)password;

-(void)navToForgetVC;
@end

@interface RetrievePasswordView : UIView

@property (nonatomic,assign) id <RetrievePasswordViewDelegate> delegate;

@end