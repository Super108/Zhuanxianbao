//
//  DPUtil.m
//  dripo
//
//  Created by Stenson on 14-1-14.
//  Copyright (c) 2014年 Stenson. All rights reserved.
//

#define kLoginToken  @"keyLoginToken"
#define kExpireTime  @"keyExpireTime"

#import "DPUtil.h"
#import "NSString+MKNetworkKitAdditions.h"


@implementation DPUtil

+ (BOOL)isNotNull:(id)object
{
    if ([object isEqual:[NSNull null]]) {
        return NO;
    } else if ([object isKindOfClass:[NSNull class]]) {
        return NO;
    } else if (object == nil) {
        return NO;
    }
    return YES;
}


+ (void)setLoginToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kLoginToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getLoginToken{
   return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginToken];
}

//存入过期时间
+ (void)setExpireTime:(NSString *)time
{
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:kExpireTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getExpireTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kExpireTime];
}

@end
