//
//  ZSServerEngine.m
//  molijing
//
//  Created by Stenson on 15-3-16.
//  Copyright (c) 2015年 Stenson. All rights reserved.
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
        if ([responseData isKindOfClass:[NSDictionary class]]) {
                if (successBlock != nil) {
                    successBlock(@"请求成功，返回数据。", responseData);
                }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) { 
        if (error != nil) {
            errorBlock(error);
        }
    }];
    
    [self enqueueOperation:operation];
    
    return operation;
}




@end
