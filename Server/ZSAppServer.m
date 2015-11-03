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
    //获取系统当前的时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    NSLog(@"%@",timeString);
    
    //请求接口
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:appID, @"appId",timeString, @"time",name, @"accountName",password, @"password",nil];
    NSLog(@"%@",dic);
    NSString * allStr= @"";
    
    //排序key
    NSArray* keyArr = [dic allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    //    NSLog(@"%@",keyArr);
    
    for (int i=0; i<=3; i++)
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
    
    
//    NSString *params=[NSString stringWithFormat:@"appId=%@&time=%@&sign=%@password=%@accountName=%@,",appID,timeString,sign,password,name];

    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:name forKey:@"accountName"];
    [params setObject:appID forKey:@"appId"];
    [params setObject:password forKey:@"password"];
    [params setObject:sign forKey:@"sign"];
    [params setObject:timeString forKey:@"time"];
    
    
    NSLog(@"LLL%@",params);
    
    [[ZSServerEngine sharedInstance] requestWithParams:params path:kLoginUser httpMethod:POST customHeaders:nil success:^(NSString *successMsg, id data) {
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
