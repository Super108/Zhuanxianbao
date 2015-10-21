//
//  ZSServerEngine.m
//  molijing
//
//  Created by nero on 15-3-16.
//  Copyright (c) 2015年 xuejili. All rights reserved.
//

#import "ZSServerEngine.h"
#import "AppDelegate.h"
#import "DefineModel.h"
#import "DPUtil.h"
#define kServerErrorNotLogin                @"E020601" // 用户未登陆
#define kServerErrorLoginTimeOut            @"E020602" // 登陆超时
#define kServerErrorReqTimeOut              @"E020603" // 请求超时
#define kServerErrorIllegalReq              @"E020604" // 非法请求

static ZSServerEngine *serverEngine = nil;

@interface ZSServerEngine()
{
    BOOL _needReloginErrShowed;
    BOOL _kickedOutErrShowed;
}

@end

@implementation ZSServerEngine

+ (ZSServerEngine *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        serverEngine = [[ZSServerEngine alloc] initSingle];
    });
    return serverEngine;
}

- (id)initSingle
{
    self = [super initWithHostName:ServerAddress customHeaderFields:nil];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    return [ZSServerEngine sharedInstance];
}

#pragma mark - Molijing server request method
- (MKNetworkOperation *)requestWithParams:(NSMutableDictionary *)params
                                     path:(NSString *)path
                               httpMethod:(NSString *)httpMethod
                            customHeaders:(NSDictionary *)customHeaders
                                  success:(ServerResponseSuccessBlock)successBlock
                                     fail:(ServerResponseFailBlock)failBlock
                                    error:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *operation = [self operationWithPath:path params:params httpMethod:httpMethod ssl:NO];
    if ([httpMethod isEqualToString:@"POST"]) {
        [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    }
    
    [operation addHeaders:customHeaders];
    
    NSLog(@"url is : %@", operation.url);
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        id responseData = completedOperation.responseJSON;
        NSLog(@">>   %@",completedOperation.responseJSON);
        if ([responseData isKindOfClass:[NSDictionary class]] && [DPUtil isNotNull:[responseData objectForKey:@"success"]]) {
            BOOL isSuccess = [[responseData objectForKey:@"success"] boolValue];
            if (isSuccess) { // 用户操作成功
                id data = nil;
                NSString *successMsg = nil;
                if ([DPUtil isNotNull:[responseData objectForKey:@"data"]]) {
                    data = [responseData objectForKey:@"data"];
                }
                
                if ([DPUtil isNotNull:[responseData objectForKey:@"successMsg"]]) {
                    successMsg = [responseData objectForKey:@"successMsg"];
                }
                if (successBlock != nil) {
                    successBlock(successMsg, data);
                }
            } else { // 用户操作失败
                
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) { // 网络错误处理 200以外情况在这里处理
        if (error != nil) {
            errorBlock(error);
        }
    }];
    
    [self enqueueOperation:operation];
    
    return operation;
}




@end
