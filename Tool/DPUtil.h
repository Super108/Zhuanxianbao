//
//  DPUtil.h
//  dripo
//
//  Created by Stenson on 14-1-14.
//  Copyright (c) 2014年 Stenson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface DPUtil : NSObject


// 检查对象是否为空
+ (BOOL)isNotNull:(id)object;


//存入登录的Token
+ (void)setLoginToken:(NSString *)token;
+ (NSString *)getLoginToken;

+(void)removeToken;

//存入过期时间
+ (void)setExpireTime:(NSString *)time;
+ (NSString *)getExpireTime;
+(void)removeExpireTime;
@end
