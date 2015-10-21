//
//  ZSAppServer.m
//  ZhuanXB
//
//  Created by Stenson on 15/10/21.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#define POST @"POST"
#define GET @"GET"

#define kRegistByPhoneWithPassword  @"/shipper/register"

#define kGetWaybillDetai            @"/shipper/waybill/viewwaybill"

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
    [params setObject:password forKey:@"mobile"];
    [params setObject:code forKey:@"validateCode"];
    
    [[ZSServerEngine sharedInstance] requestWithParams:params path:kRegistByPhoneWithPassword httpMethod:GET customHeaders:nil success:^(NSString *successMsg, id data) {
        successBlock(successMsg, data);
    } fail:^(NSString *errorMsg, NSString *errorCode) {
        failBlock(errorMsg, errorCode);
    } error:^(NSError *error) {
        errorBlock(error);
    }];

}
@end
