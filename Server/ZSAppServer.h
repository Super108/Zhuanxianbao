//
//  ZSAppServer.h
//  ZhuanXB
//
//  Created by Stenson on 15/10/21.
//  Copyright © 2015年 kang_dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSServerEngine.h"

@interface ZSAppServer : NSObject
//注册
+ (void)registerUsersWithUserName:(NSString *)name
                       withMobile:(NSString *)phoneNum
                     withPassword:(NSString *)password
                 withValidateCode:(NSString *)code
                success:(ServerResponseSuccessBlock)successBlock
                    fail:(ServerResponseFailBlock)failBlock
                   error:(MKNKErrorBlock)errorBlock;
//登录
+(void)loginUserWithUserName:(NSString *)name
                withPassword:(NSString *)password
                     success:(ServerResponseSuccessBlock)successBlock
                        fail:(ServerResponseFailBlock)failBlock
                       error:(MKNKErrorBlock)errorBlock;


@end
