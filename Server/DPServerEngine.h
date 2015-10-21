//
//  DPServerEngine.h
//  molijing
//
//  Created by nero on 15-3-16.
//  Copyright (c) 2015年 xuejili. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^ServerResponseBlock) (NSDictionary *result);
typedef void (^ServerResponseSuccessBlock) (NSString *successMsg, id data);
typedef void (^ServerResponseFailBlock) (NSString *errorMsg, NSString *errorCode);
typedef void (^ServerErrorRecordBlock) (void);  // 记录服务器错误block

@interface DPServerEngine : MKNetworkEngine

+ (DPServerEngine *)sharedInstance;

/** 服务器请求数据方法
 *
 * @param params 请求参数
 * @param path 请求路径
 * @param customHeaders 自定义header信息
 * @param successBlock 服务器请求成功，返回数据解析成功，用户操作成功
 * @param failBlock 服务器请求成功，返回数据解析成功，用户操作提交失败
 * @param error 服务器请求失败 包括1.网络请求失败 2.服务器请求失败(404、500等)
 */
- (MKNetworkOperation *)requestWithParams:(NSMutableDictionary *)params
                                     path:(NSString *)path
                               httpMethod:(NSString *)httpMethod
                            customHeaders:(NSDictionary *)customHeaders
                                  success:(ServerResponseSuccessBlock)successBlock
                                     fail:(ServerResponseFailBlock)failBlock
                                    error:(MKNKErrorBlock)errorBlock;

/** 上传图片
 *
 * @param imagePathDic 文件路径字典 key是为自定义内容 value为图片路径
 * @param successBlock 操作成功回调
 * @param failBlock 操作失败回调
 * @param errorBlock 失败回调
 */
- (MKNetworkOperation *)uploadImages:(NSDictionary *)imagePathDic
                              params:(NSMutableDictionary *)params
                                path:(NSString *)path
                          httpMethod:(NSString *)httpMethod
                       customHeaders:(NSDictionary *)customHeaders
             success:(ServerResponseSuccessBlock)successBlock
                fail:(ServerResponseFailBlock)failBlock
               error:(MKNKErrorBlock)errorBlock;

/** 出错提示方法
 *
 * @param error 请求返回错误
 * @param recordErrorBlock 服务器出错操作block
 */
- (void)showErrorAlertView:(NSError *)error recordServerBlock:(ServerErrorRecordBlock)recordErrorBlock;


@end
