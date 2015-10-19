//
//  FMDBTools.m
//  OrderDish20
//
//  Created by 孙鹏 on 14-8-21.
//  Copyright (c) 2014年 ___sp___. All rights reserved.
//

#import "FMDBTools.h"

#import "FMDatabase.h"

@implementation FMDBTools

static FMDatabase *_db ;

#pragma mark - 创建数据库



+ (void)createDB
{
    //获得database.sqlite在束的路径
    NSString *shuPath = [[NSBundle mainBundle] pathForResource:@"zxb_area" ofType:@"db"];

    NSString *homePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/zxb_area.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ( ![fileManager fileExistsAtPath:homePath] )
    {
        NSError * error =nil;
        [fileManager copyItemAtPath:shuPath toPath:homePath error:&error];
    }
    
    _db = [[FMDatabase alloc] initWithPath:homePath];
    [_db open];
    
    NSLog( @"数据库 open " );
    
    [_db setShouldCacheStatements:YES];
    
}
+(NSMutableArray * )getProvinceFromChina
{
    NSString *sq = @"select * from zxb_area where area_level = 1";
    
    FMResultSet * set = [_db executeQuery:sq];
    NSMutableArray * arr = [NSMutableArray array];
    
    while ([set next])
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        NSString * name = [set stringForColumn:@"name"];
        NSString * pid  = [set stringForColumn:@"barrio_code"];
        NSString * parent_id = [set stringForColumn:@"parent_id"];
        NSString * ids = [set stringForColumn:@"id"];
        
        [dic setObject:name forKey:@"name"];
        [dic setObject:pid forKey:@"barrio_code"];
        [dic setObject:parent_id forKey:@"parent_id"];
        [dic setObject:ids forKey:@"id"];
        
        [arr addObject:dic];
    }
    [set close];
    
    return arr;
}

#pragma mark - 市

+(NSMutableArray * )getCityFromChina:(NSString * )pidNum
{
    NSString *sq = @"select * from zxb_area where parent_id = ?";
    
    FMResultSet * set = [_db executeQuery:sq,pidNum];
    NSMutableArray * arr = [NSMutableArray array];

    while ([set next])
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        NSString * name = [set stringForColumn:@"name"];
        NSString * pid  = [set stringForColumn:@"barrio_code"];
        NSString * parent_id = [set stringForColumn:@"parent_id"];
         NSString * ids = [set stringForColumn:@"id"];
        
        [dic setObject:name forKey:@"name"];
        [dic setObject:pid forKey:@"barrio_code"];
        [dic setObject:parent_id forKey:@"parent_id"];
        [dic setObject:ids forKey:@"id"];

        [arr addObject:dic];
    }
    [set close];
    
    return arr;
}
+(NSMutableArray *)getallNameFromChina:(NSString * )code
{
    NSString *sq = @"select * from zxb_area where barrio_code = ?";
    
    FMResultSet * set = [_db executeQuery:sq,code];
    NSMutableArray * arr = [NSMutableArray array];
    
    while ([set next])
    {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        
        NSString * name = [set stringForColumn:@"name"];
        NSString * parent_name  = [set stringForColumn:@"parent_name"];
        NSString * province = [set stringForColumn:@"province"];
        
        [dic setObject:name forKey:@"name"];
        [dic setObject:parent_name forKey:@"parent_name"];
        [dic setObject:province forKey:@"province"];
        
        [arr addObject:dic];
    }
    [set close];
    
    return arr;

}





@end
