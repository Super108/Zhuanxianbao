//
//  FMDBTools.h
//  OrderDish20
//
//  Created by 孙鹏 on 14-8-21.
//  Copyright (c) 2014年 ___sp___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBTools : NSObject
{
}

@property (nonatomic,retain) NSMutableArray * haveDifferent;

//创建数据库
+ (void)createDB;

//获取城市
+(NSMutableArray * )getProvinceFromChina;
+(NSMutableArray * )getCityFromChina:(NSString * )pidNum;
+(NSMutableArray *)getallNameFromChina:(NSString * )code;

@end
