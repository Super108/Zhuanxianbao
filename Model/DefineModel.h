//
//  DefineModel.h
//  SkyEye
//
//  Created by shanchen on 14-7-4.
//  Copyright (c) 2014年 kang_dong. All rights reserved.
//

#import "DPUtil.h"


#ifndef SkyEye_DefineModel_h
#define SkyEye_DefineModel_h

// 设备
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


#define ClientVersion @"5"
//系统
#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define kScreenHeight       [[UIScreen mainScreen] bounds].size.height


//版本号
#define Version @"V 1.3"
//注册通知
#define NOTICECENTER    [NSNotificationCenter defaultCenter]

//需要转换的颜色
#define ZhuanXB_color(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(R,G,B,A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

#pragma mark - COLOR

#define MAIN_BackgroundColor  ZhuanXB_color(0xe6ebf0)
#define MAIN_COLOR_BORDERCOLOR  RGBA(182, 182, 182, 1)  //边框颜色

#define USERNAME @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@_"
#define PASSWORD @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define   ServiceProtrol @"http://www.babywith.cn/aiJia/xy.html"

//正式服务器
//#define WaterPump_address @"http://112.124.24.209:8089/aiJiaWebService/api"

#define appID @"Mobile_Ios_1001"
#define secretKey @"OcxY4pWM5bAxKtU5mxOUAKhO"


//内网服务器地址
//#define ZhuanXB_address @"http://192.168.1.20:9100/ZXBMobileEx"


//外网服务器地址
#define ZhuanXB_address @"http://122.225.192.50:9100/ZXBMobileEx"

//正式服务器地址
//#define ZhuanXB_address @"http://huozhuapp.56123.com"
//#define ZhuanXB_address @"http://112.124.123.203:9100/ZXBMobileEx"

#define ServerAddress   @"122.225.192.50:9100/ZXBMobileEx"

//演示服务器  外网
//#define WaterPump_address @"http://218.244.145.132:8089/aiJiaWebService/api"



//本机
//#define WaterPump_address @"http://huozhuapp.56123.com"



#endif
