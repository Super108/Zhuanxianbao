//
//  DPServerEngine.m
//  molijing
//
//  Created by nero on 15-3-16.
//  Copyright (c) 2015年 xuejili. All rights reserved.
//

#import "DPServerEngine.h"
#import "DPAppdelegate.h"

#define kServerErrorNotLogin                @"E020601" // 用户未登陆
#define kServerErrorLoginTimeOut            @"E020602" // 登陆超时
#define kServerErrorReqTimeOut              @"E020603" // 请求超时
#define kServerErrorIllegalReq              @"E020604" // 非法请求

static DPServerEngine *serverEngine = nil;

@interface DPServerEngine()
{
    BOOL _needReloginErrShowed;
    BOOL _kickedOutErrShowed;
}

@end

@implementation DPServerEngine

+ (DPServerEngine *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        serverEngine = [[DPServerEngine alloc] initSingle];
    });
    return serverEngine;
}

- (id)initSingle
{
    self = [super initWithHostName:MOLIJING_SERVER customHeaderFields:nil];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    return [DPServerEngine sharedInstance];
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
    // 封装客户端版本信息和用户验证信息
    if ([httpMethod isEqualToString:POST]) {
        if ([DPUtil isNotNull:params]) {
            [params setObject:[DPUtil getSystemInfo] forKey:@"systemInfo"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"sign"] forKey:@"sign"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"userId"] forKey:@"userId"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"timestamp"] forKey:@"timestamp"];
        } else {
            params = [[NSMutableDictionary alloc] init];
            [params setObject:[DPUtil getSystemInfo] forKey:@"systemInfo"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"sign"] forKey:@"sign"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"userId"] forKey:@"userId"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"timestamp"] forKey:@"timestamp"];
        }
    }
    MKNetworkOperation *operation = [self operationWithPath:path params:params httpMethod:httpMethod ssl:NO];
    if ([httpMethod isEqualToString:POST]) {
        [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    }
    
    [operation addHeaders:customHeaders];
    
    NSLog(@"url is : %@", operation.url);
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        id responseData = completedOperation.responseJSON;
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
                NSString *failMsg = nil;
                NSString *errorCode = nil;
                if ([DPUtil isNotNull:[responseData objectForKey:@"errorMsg"]]) {
                    failMsg = [responseData objectForKey:@"errorMsg"];
                }
                if ([DPUtil isNotNull:[responseData objectForKey:@"errorCode"]]) {
                    errorCode = [responseData objectForKey:@"errorCode"];
                }
                NSLog(@"Server error occured with errorCode : %@, failMsg : %@", errorCode, failMsg);
                if ([errorCode isEqualToString:kServerErrorLoginTimeOut] || [errorCode isEqualToString:kServerErrorNotLogin] || [errorCode isEqualToString:kServerErrorReqTimeOut]) {
                    [self showNeedReloginError];
                } else if([errorCode isEqualToString:kServerErrorIllegalReq]){
                    [self showKickedOutError];
                }
                else{
                    if (failBlock != nil) {
                        failBlock(failMsg, errorCode);
                    }
                }
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




- (MKNetworkOperation *)uploadImages:(NSDictionary *)imagePathDic
                              params:(NSMutableDictionary *)params
                                path:(NSString *)path
                          httpMethod:(NSString *)httpMethod
                       customHeaders:(NSDictionary *)customHeaders
                             success:(ServerResponseSuccessBlock)successBlock
                                fail:(ServerResponseFailBlock)failBlock
                               error:(MKNKErrorBlock)errorBlock
{
    // 封装客户端版本信息
    if ([httpMethod isEqualToString:POST]) {
        if ([DPUtil isNotNull:params]) {
            [params setObject:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:[DPUtil getSystemInfo] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding] forKey:@"systemInfo"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"sign"] forKey:@"sign"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"userId"] forKey:@"userId"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"timestamp"] forKey:@"timestamp"];
        } else {
            params = [[NSMutableDictionary alloc] init];
            [params setObject:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:[DPUtil getSystemInfo] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding] forKey:@"systemInfo"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"sign"] forKey:@"sign"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"userId"] forKey:@"userId"];
            [params setObject:[[DPUtil serverRequestSign:path] objectForKey:@"timestamp"] forKey:@"timestamp"];
        }
    }
    
    MKNetworkOperation *operation = [self operationWithPath:path params:params httpMethod:httpMethod ssl:NO];
    if ([httpMethod isEqualToString:POST]) {
        [operation setPostDataEncoding:MKNKPostDataEncodingTypeJSON];
    }

    NSArray *imgPathKeys = [imagePathDic allKeys];
    for (NSString *key in imgPathKeys) {
        NSString *imagePath = [imagePathDic objectForKey:key];
        [operation addFile:imagePath forKey:key];
    }
    
    [operation addHeaders:customHeaders];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        id responseData = completedOperation.responseJSON;
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
                NSString *failMsg = nil;
                NSString *errorCode = nil;
                if ([DPUtil isNotNull:[responseData objectForKey:@"errorMsg"]]) {
                    failMsg = [responseData objectForKey:@"errorMsg"];
                }
                if ([DPUtil isNotNull:[responseData objectForKey:@"errorCode"]]) {
                    errorCode = [responseData objectForKey:@"errorCode"];
                }
                NSLog(@"Server error occured with errorCode : %@, failMsg : %@", errorCode, failMsg);
                if (failBlock != nil) {
                    failBlock(failMsg, errorCode);
                }
                if ([errorCode isEqualToString:kServerErrorLoginTimeOut] || [errorCode isEqualToString:kServerErrorNotLogin] || [errorCode isEqualToString:kServerErrorReqTimeOut]) {
                    [self showNeedReloginError];
                } else if([errorCode isEqualToString:kServerErrorIllegalReq]){
                    [self showKickedOutError];
                }
                else{
                    if (failBlock != nil) {
                        failBlock(failMsg, errorCode);
                    }
                }

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

- (void)showErrorAlertView:(NSError *)error recordServerBlock:(ServerErrorRecordBlock)recordErrorBlock
{
    if (error != nil) {
        NSInteger code = [error code];
        NSString *errorCode = [NSString stringWithFormat:@"%li", (long)code];
        if ([errorCode hasPrefix:@"4"] || [errorCode hasPrefix:@"5"]) { // 服务器错误
            // 记录错误
            if (recordErrorBlock != nil) {
                recordErrorBlock();
            }
            [self showServerErrorAlertView];
        } else {
            [self showNetErrorAlertView];
        }
    }
}


#pragma mark - private method
- (void)showServerErrorAlertView
{
    // 弹出AlertView
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"小镜生病了，正在挂点滴，马上回来~"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    
}

- (void)showNetErrorAlertView
{
    // 弹出AlertView提示网络不畅
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"咦？网络肿么木有了？"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showKickedOutError
{
    if (!_kickedOutErrShowed) {
        _kickedOutErrShowed = YES;
        // 弹出AlertView
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"哎呀~由于您的账号在另一台手机登陆，您被迫退出当前账号。如果不是您本人的操作，那么您的密码可能已经泄露，建议您修改密码。\n\n\n如有疑问，请联系：\nQQ：1990004321\nTel：400-6060-599"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}


- (void)showNeedReloginError
{
    if (!_needReloginErrShowed) {
        _needReloginErrShowed = YES;
        // 弹出AlertView
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前登陆已失效，请重新登陆"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 显示登陆页面
    [[DPAppDelegate sharedInstance] showLoginView];
    _kickedOutErrShowed = NO;
    _needReloginErrShowed = NO;
}

@end
