//
//  DPUtil.m
//  dripo
//
//  Created by 周 华平 on 14-1-14.
//  Copyright (c) 2014年 xuejili. All rights reserved.
//

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

@end
