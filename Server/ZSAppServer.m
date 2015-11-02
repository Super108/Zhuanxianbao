//
//  ZSAppServer.m
//  ZhuanXB
//
//  Created by Stenson on 15/10/21.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#define POST @"POST"
#define GET @"GET"

#define kLoginUser                  @"/shipper/login"
#define kRegistByPhoneWithPassword  @"/shipper/register"

#define kGetWaybillDetai            @"/shipper/waybill/viewwaybill"

#define kRetrievePassword           @"/shipper/password"
#define kSendCheckCode              @"/shipper/password/sendCode"
#import "ZSAppServer.h"

@implementation ZSAppServer


+ (void)registerUsersWithUserName:(NSString *)name
                       withMobile:(NSString *)phoneNum
                     withPassword:(NSString *)password
                 withValidateCode:(NSString *)code
                          success:(ServerResponseSuccessBlock)successBlock
                             fail:(ServerResponseFailBlock)failBlock
                            error:(MKNKErrorBlock)errorBlock
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:name forKey:@"accountName"];
    [params setObject:phoneNum forKey:@"mobile"];
    [params setObject:password forKey:@"password"];
    [params setObject:code forKey:@"validateCode"];
    
    [[ZSServerEngine sharedInstance] requestWithParams:params path:kRegistByPhoneWithPassword httpMethod:POST customHeaders:nil success:^(NSString *successMsg, id data) {
        successBlock(successMsg, data);
    } fail:^(NSString *errorMsg, NSString *errorCode) {
        failBlock(errorMsg, errorCode);
    } error:^(NSError *error) {
        errorBlock(error);
    }];

}

//登录
+(void)loginUserWithUserName:(NSString *)name
                withPassword:(NSString *)password
                     success:(ServerResponseSuccessBlock)successBlock
                        fail:(ServerResponseFailBlock)failBlock
                       error:(MKNKErrorBlock)errorBlock
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:name forKey:@"accountName"];
    [params setObject:password forKey:@"password"];
    
    [[ZSServerEngine sharedInstance] requestWithParams:params path:kRegistByPhoneWithPassword httpMethod:POST customHeaders:nil success:^(NSString *successMsg, id data) {
        successBlock(successMsg, data);
    } fail:^(NSString *errorMsg, NSString *errorCode) {
        failBlock(errorMsg, errorCode);
    } error:^(NSError *error) {
        NSLog(@"》》》》》   请求出现问题");
        errorBlock(error);
    }];
}
//重置密码
+(void)findLostPasswordWithPhoneNumber : (NSString *)phoneNumber withNewPassword :(NSString *)newPWD withCheckCode:(NSString *) checkCode success:(ServerResponseSuccessBlock)successBlock
                                   fail:(ServerResponseFailBlock)failBlock
                                  error:(MKNKErrorBlock)errorBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phoneNumber forKey:@"mobile"];
    [params setObject:newPWD forKey:@"password"];
    [params setObject:checkCode forKey:@"validateCode"];
    
    [[ZSServerEngine sharedInstance] requestWithParams:params path:kRetrievePassword httpMethod:POST customHeaders:nil success:^(NSString *successMsg, id data) {
        successBlock(successMsg, data);
    } fail:^(NSString *errorMsg, NSString *errorCode) {
        failBlock(errorMsg, errorCode);
    } error:^(NSError *error) {
        NSLog(@"》》》》》   请求出现问题");
        errorBlock(error);
    }];
}
//发送验证码
+(void)sendCheckCodeWithPhoneNumber :(NSString *)phoneNumber success:(ServerResponseSuccessBlock)successBlock
                                fail:(ServerResponseFailBlock)failBlock
                               error:(MKNKErrorBlock)errorBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phoneNumber forKey:@"mobile"];
    
    
    [[ZSServerEngine sharedInstance] requestWithParams:params path:kSendCheckCode httpMethod:POST customHeaders:nil success:^(NSString *successMsg, id data) {
        successBlock(successMsg, data);
    } fail:^(NSString *errorMsg, NSString *errorCode) {
        failBlock(errorMsg, errorCode);
    } error:^(NSError *error) {
        NSLog(@"》》》》》   请求出现问题");
        errorBlock(error);
    }];
}


@end
