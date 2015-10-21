//
//  DPUtil.h
//  dripo
//
//  Created by 周 华平 on 14-1-14.
//  Copyright (c) 2014年 xuejili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "DPEnumConstant.h"

@interface DPUtil : NSObject

+(NSString*)getSkinTypeStringFromEnum:(SKIN_STYLE)skinType;

+ (NSString *)getSkinCareGoalDesc:(NSString *)goalStr;

+ (NSString *)getWaterWithLevel:(WATERLEVEL)waterLevel;
+ (NSString *)getWaterWithRate:(int)waterRate;

+ (NSString *)getOilWithLevel:(OILLEVEL)oilLevel;
+ (NSString *)getOilWithRate:(int)oilRate;

//肌肤检测部位
+ (NSString *)getBodyPart:(TEST_BODY_PART)value;
//肌肤检测状态
+ (NSString *)getStage:(TEST_STAGE)value;
//获取性别标签
+ (NSString *)getGender:(GENDER)gender;
//获取用户默认头像
+ (UIImage *)getDefaultAvator;

+ (UIImage *)getBusinessPlatformLogo:(BUSINESS_PLATFORM)value;

+ (NSString *)getCareOptionString:(CARE_OPTION)value;

+ (NSString *)getCareOptionIconString:(CARE_OPTION)value;

+ (NSString *)getTestItemString: (TEST_ITEM)value;

+ (NSString *)getRemarkItemString:(REMARK_ITEM)value;

+ (NSString *)getMemoGroupString: (MEMO_GROUP)value;

+ (NSString *)getMemoItemString: (NSInteger)value;

+ (NSString *)getMemoItemIconString: (NSInteger)value gender:(GENDER)gender;

+ (int)getMemoItemNumInGroup: (NSInteger)value;

+ (NSString *)getQuestionTypeString: (NSInteger)value;

+ (void)getLocal;

// 计算文字高度
+ (double)heightForString:(NSString *)str font:(UIFont *)font andWidth:(float)width;

+ (double)widthForString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

// 获得设备系统版本
+ (NSDictionary *)getSystemInfo;

// 根据颜色生成图片
+ (UIImage *)imageFromColor:(UIColor *)color;

//  时间格式化
+ (NSString *)formatDate:(NSDate *)date;

// 获取自定义字体
+ (UIFont *)customFontWithPath:(NSString *)path size:(CGFloat)size;

// 天气字体
+ (UIFont *)weatherIconFontWithSize:(CGFloat)size;

// 根据天气代码获取天气图标文字
+ (NSString *)weatherTextWithWeatherCode:(NSInteger)weatherCode;
//根据风力 获取风力图标
+ (NSString *)weatherWindWithWindLevel:(NSInteger)windLevel;
// 根据风力等级获取风力描述
+ (NSString *)windDescTextWithWindLevel:(NSInteger)windLevel;

// 检查对象是否为空
+ (BOOL)isNotNull:(id)object;

// 检查字符串是否为空
+ (BOOL)isStrNotEmpty:(NSString *)str;

/** 根据紫外新等级描述词获取紫外线等级
 *
 * @param uvDesc UV值的语言描述
 * 
 * @return 返回值为1~5的整形，对应UV从弱到强
 */
+ (NSInteger)uvLevelWithUVDesc:(NSString *)uvDesc;

// 获取部位中文解释
+ (NSString *)facePartNameWithCode:(FACE_PART)facePart;
// 获取不同分类的化妆品
+ (NSString *)CosmeticsStatusWithCode:(COSMETICS_LIST)cosmetic;
//

// 获取部位小图标
+ (NSString *)facePartIconStrWithCode:(FACE_PART)facePart andGender:(GENDER)gender;

+ (NSString *)urlEncode:(NSString *)url;

+ (UIImage *)addLogoOnImage:(UIImage *)image;

/** 服务器请求签名信息
 * 签名规则 md5(queryPath + userId + sid + timestamp)
 *
 */
+ (NSDictionary *)serverRequestSign:(NSString *)queryPath;

// 获取结果子项中文描述
+ (NSString *)resultItemNameWithCode:(TEST_RESULT_ITEM)item;
// 获取结果子项小图标
+ (NSString *)resultItemIconStrWithCode:(TEST_RESULT_ITEM)item;

// 将1转换为a,2转换为b,3 to c, and on on...
+ (NSString *)formateNumberOptionToEnglishOption:(NSInteger)numberOption;
// 将a转换为1,b转换为2,c to 3, and so on...
+ (NSInteger)formateEnglishOptionToNumberOption:(NSString *)englishOption;

// 积分来源描述
+ (NSString *)getIntegralChangeDescStrFromEnum:(INTEGRAL_CHANGE_WAY)changeWay;

@end
