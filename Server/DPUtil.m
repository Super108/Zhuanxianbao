//
//  DPUtil.m
//  dripo
//
//  Created by 周 华平 on 14-1-14.
//  Copyright (c) 2014年 xuejili. All rights reserved.
//

#import "DPUtil.h"
#import "DPSettingData.h"
#import "NSString+MKNetworkKitAdditions.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DPUtil

+(NSString *)getSkinTypeStringFromEnum:(SKIN_STYLE)skinType
{
    if (skinType == SKIN_NEUTRAL_AND_DRY) {
        return @"中性偏干肌肤";
    } else if (skinType == SKIN_DRY_AND_SEN) {
        return @"干性敏感肌肤";
    } else if (skinType == SKIN_OIL_AND_DRY) {
        return @"油性偏干肌肤";
    } else if (skinType == SKIN_OIL_AND_SEN) {
        return @"油性敏感肌肤";
    } else if (skinType == SKIN_MSIC_AND_DRY) {
        return @"混合偏干肌肤";
    } else if (skinType == SKIN_MSIC_AND_OIL) {
        return @"混合偏油肌肤";
    } else if (skinType == SKIN_MSIC_AND_SEN) {
        return @"混合敏感肌肤";
    } else if (skinType == SKIN_SEN_AND_DRY) {
        return @"敏感偏干肌肤";
    } else if (skinType == SKIN_SEN_AND_OIL) {
        return @"敏感偏油肌肤";
    } else {
        return @"";
    }
}

+ (NSString *)getSkinCareGoalDesc:(NSString *)goalStr;
{
    NSArray *targetArray = @[@"美白",@"抗皱",@"控油",@"保湿",@"祛斑"];
    NSArray  *targetIndexArray = [goalStr componentsSeparatedByString:@","];
    
    NSMutableArray *targetNameArray = [[NSMutableArray alloc] init];
    for (id value in targetIndexArray) {
        if (value != nil && [value isEqualToString:@""] == NO) {
            int index = [value intValue];
            [targetNameArray addObject:targetArray[index]];
        }
    }
    
    if (targetNameArray.count > 0) {
        return [targetNameArray componentsJoinedByString:@" "];
    } else {
        return @"";
    }
    
}

//水份等级获取水份标签
+ (NSString *)getWaterWithLevel:(WATERLEVEL)waterLevel
{
    NSString *waterTip;
    
    if(waterLevel == WATER_CONTENT_LOW){
        waterTip = @"水份偏低";
    }
    else if(waterLevel == WATER_CONTENT_MEDIUM){
        waterTip = @"水份适中";
    }
    else{
        waterTip = @"水份理想";
    }
    
    return waterTip;
}

//百分比获取水份标签
+ (NSString *)getWaterWithRate:(int)waterRate
{
    NSString *waterTip;
    
    if(waterRate < 30){
        waterTip = @"水份偏低";
    }
    else if(waterRate >= 30 && waterRate <= 40){
        waterTip = @"水份适中";
    }
    else{
        waterTip = @"水份理想";
    }
    
    return waterTip;
}

//油份等级获取油份标签
+ (NSString *)getOilWithLevel:(OILLEVEL)oilLevel
{
    NSString *oilTip;
    
    if(oilLevel == OIL_CONTENT_LOW){
        oilTip = @"油份偏低";
    }
    else if(oilLevel == OIL_CONTENT_MEDIUM){
        oilTip = @"油份适中";
    }
    else{
        oilTip = @"油份偏高";
    }
    
    return oilTip;
}

//油份百分比获取油份标签
+ (NSString *)getOilWithRate:(int)oilRate
{
    NSString *oilTip;
    
    if(oilRate < 30){
        oilTip = @"油份偏低";
    }
    else if(oilRate >= 30 && oilRate <= 45){
        oilTip = @"油份适中";
    }
    else{
        oilTip = @"油份理想";
    }
    
    return oilTip;
}

//获取检测部位
+ (NSString *)getBodyPart:(TEST_BODY_PART)value
{
    switch (value) {
        case TEST_BODY_HAND:
            return  @"手背";
            break;
        case TEST_BODY_NECK:
            return  @"脖子";
            break;
        case TEST_BODY_FORHEAD:
            return  @"额头";
            break;
        case TEST_BODY_U:
            return  @"U区";
            break;
        case TEST_BODY_T:
            return  @"T区";
            break;
        case TEST_BODY_FACE:
            return @"脸部";
            break;
        default:
            return  @"";
            break;
    }
    
}

//获取检测时段
+ (NSString *)getStage:(TEST_STAGE)value
{
    switch (value) {
        case TEST_STATE_BEFORE:
            return @"护理前";
            break;
        case TEST_STATE_AFTER:
            return @"护理后";
            break;
        case TEST_STATE_DEILY:
            return @"日常";
            break;
        default:
            return @"";
            break;
    }
}

//获取性别标签
+ (NSString *)getGender:(GENDER)gender
{
    if (gender == GENDER_MALE) {
        return @"男";
    }
    else if (gender == GENDER_FEMALE) {
        return @"女";
    }
    else {
        return @"保密";
    }
}

//获取用户默认头像
+ (UIImage *)getDefaultAvator
{
    UIImage *img = nil;
    GENDER gender = [DPSettingData gender];
    if (gender == GENDER_MALE)
        img = [UIImage imageNamed:@"icon_avatar_gentleman"];
    else if(gender == GENDER_FEMALE)
        img = [UIImage imageNamed:@"icon_avatar_lady"];
    else
        img = [UIImage imageNamed:@"icon_avatar_lady"];
    
    return img;
}

+ (void)getLocal
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages0 = [defaults objectForKey:@"AppleLanguages"];
//    NSString *currentLanguage = [languages objectAtIndex:0];
    for (id l in languages0) {
        NSLog(@"%@",l);
    }
    
    
    NSArray *languages1 = [[NSBundle mainBundle] preferredLocalizations];
    for (id l in languages1) {
        NSLog(@"%@",l);
    }
}

+ (UIImage *)getBusinessPlatformLogo:(BUSINESS_PLATFORM)value
{
    UIImage *img = nil;
    switch (value) {
        case BUSINESS_PLATFORM_JD:
            img = [UIImage imageNamed:@"icon_merchant_jd"];
            break;
        case BUSINESS_PLATFORM_TMALL:
            img = [UIImage imageNamed:@"icon_merchant_tmall"];
            break;
        case BUSINESS_PLATFORM_TAOBAO:
            img = [UIImage imageNamed:@"icon_merchant_taobao"];
            break;
        default:
            break;
    }
    return img;
}

+ (NSString *)getCareOptionString:(CARE_OPTION)value
{
    NSString *option = nil;
    switch (value) {
        case CARE_OPTION_MASK:
            option = @"面膜";
            break;
        case CARE_OPTION_TONER:
            option = @"爽肤水";
            break;
        case CARE_OPTION_ESSENCE:
            option = @"精华素";
            break;
        case CARE_OPTION_NUTRIMENT:
            option = @"营养品";
            break;
        case CARE_OPTION_SUNSCREEN:
            option = @"防晒";
            break;
        case CARE_OPTION_MASSAGE:
            option = @"按摩";
            break;
        case CARE_OPTION_SPA:
            option = @"SPA";
            break;
        case CARE_OPTION_HOSPITAL:
            option = @"医院";
            break;
        case CARE_OPTION_COSMETOLOGY:
            option = @"医美";
            break;
        default:
            option = @"全部";
            break;
    }
    return option;
}

#warning 依赖老图片
//+ (NSString *)getCareOptionIconString:(CARE_OPTION)value
//{
//    NSString *icon = nil;
//    switch (value) {
//            
//        case CARE_OPTION_MASK:
//            icon = @"icon_mask";
//            break;
//        case CARE_OPTION_TONER:
//            icon = @"icon-care-toner";
//            break;
//        case CARE_OPTION_ESSENCE:
//            icon = @"icon-care-essence";
//            break;
//        case CARE_OPTION_NUTRIMENT:
//            icon = @"icon-care-nutrition";
//            break;
//        case CARE_OPTION_SUNSCREEN:
//            icon = @"icon-care-uv";
//            break;
//        case CARE_OPTION_MASSAGE:
//            icon = @"icon-relax-spa-body";
//            break;
//        case CARE_OPTION_SPA:
//            icon = @"icon-cleanse";
//            break;
//        case CARE_OPTION_HOSPITAL:
//            icon = @"icon-special-hospital";
//            break;
//        case CARE_OPTION_COSMETOLOGY:
//            icon = @"icon-special-surgery";
//            break;
//        default:
//            icon = @"";
//            break;
//    }
//    return icon;
//
//}

+ (NSString *)getTestItemString: (TEST_ITEM)value
{
    NSString *testItem = nil;
    switch (value) {
        case CARE_OPTION_MASK:
            testItem = @"水分";
            break;
        case CARE_OPTION_TONER:
            testItem = @"油份";
            break;
        case CARE_OPTION_ESSENCE:
            testItem = @"弹性";
            break;
        case CARE_OPTION_NUTRIMENT:
            testItem = @"胶原蛋白";
            break;
        case CARE_OPTION_SUNSCREEN:
            testItem = @"色泽";
            break;
        default:
            testItem = @"";
            break;
    }
    return testItem;
}

+ (NSString *)getRemarkItemString: (REMARK_ITEM)value
{
    NSString *markItem = nil;
    switch (value) {
        case REMARK_ITEM_WANTED:
            markItem = @"我想要的";
            break;
        case REMARK_ITEM_USED:
            markItem = @"已使用的";
            break;
        case REMARK_ITEM_ALL:
            markItem = @"我想要和已使用";
            break;
        default:
            markItem = @"我想要和已使用";
            break;
    }
    return markItem;
}

+ (NSString *)getMemoGroupString: (MEMO_GROUP)value;
{
    NSString *memoGroup = nil;
    switch (value) {
        case MEMO_GROUP_BODYPART:
            memoGroup = @"部位";
            break;
        case MEMO_GROUP_MOOD:
            memoGroup = @"心情";
            break;
        case MEMO_GROUP_SKINCARE:
            memoGroup = @"护理";
            break;
        case MEMO_GROUP_MEDICALSKINCARE:
            memoGroup = @"特别护理";
            break;
        case MEMO_GROUP_WORKOUT:
            memoGroup = @"运动";
            break;
        case MEMO_GROUP_EXTERNALFACTORS:
            memoGroup = @"外在因素";
            break;
        case MEMO_GROUP_OTHERFACTORS:
            memoGroup = @"其他因素";
            break;
        default:
            memoGroup = @"";
            break;
    }
    return memoGroup;
}

+ (NSString *)getMemoItemString: (NSInteger)value
{
    NSString *memoItem = nil;
    switch (value) {
        case MEMO_BODYPART_FACE:
            memoItem = @"脸部";
            break;
//TODO: need to support more body parts later
//        case MEMO_BODYPART_CANTHUS:
//            memoItem = @"眼角";
//            break;
//        case MEMO_BODYPART_BODY:
//            memoItem = @"身体";
//            break;
//        case MEMO_BODYPART_HAND:
//            memoItem = @"手部";
//            break;
//        case MEMO_BODYPART_FOOT:
//            memoItem = @"足部";
//            break;
        case MEMO_MOOD_PERFECT:
            memoItem = @"非常好";
            break;
        case MEMO_MOOD_VERYGOOD:
            memoItem = @"很好";
            break;
        case MEMO_MOOD_GOOD:
            memoItem = @"好";
            break;
        case MEMO_MOOD_BAD:
            memoItem = @"不太好";
            break;
        case MEMO_MOOD_TERRIBLE:
            memoItem = @"糟透了";
            break;
        case MEMO_SKINCARE_MASK:
            memoItem = @"面膜";
            break;
        case MEMO_SKINCARE_STEAM:
            memoItem = @"蒸汽";
            break;
        case MEMO_SKINCARE_FACIAL:
            memoItem = @"脸部按摩";
            break;
        case MEMO_SKINCARE_CLEANSE:
            memoItem = @"洁面乳";
            break;
        case MEMO_SKINCARE_CREAM:
            memoItem = @"面霜";
            break;
        case MEMO_SKINCARE_ESSENCE:
            memoItem = @"精华素";
            break;
        case MEMO_SKINCARE_TONER:
            memoItem = @"爽肤水";
            break;
        case MEMO_SKINCARE_NUTRIMENT:
            memoItem = @"营养品";
            break;
        case MEMO_SKINCARE_SUNSCREEN:
            memoItem = @"防晒";
            break;
        case MEMO_MEDICALSKINCARE_BEAUTYSALON:
            memoItem = @"美容院";
            break;
        case MEMO_MEDICALSKINCARE_HOSPITAL:
            memoItem = @"医院";
            break;
        case MEMO_WORKOUT_WALKING:
            memoItem = @"走路";
            break;
        case MEMO_WORKOUT_JOGGING:
            memoItem = @"跑步";
            break;
        case MEMO_WORKOUT_YOGA:
            memoItem = @"瑜伽";
            break;
        case MEMO_WORKOUT_OTHERS:
            memoItem = @"其他";
            break;
        case MEMO_EXTERNALFACTORS_UV:
            memoItem = @"紫外线";
            break;
        case MEMO_EXTERNALFACTORS_SLEEPDEPRIVATION:
            memoItem = @"睡眠不足";
            break;
        case MEMO_EXTERNALFACTORS_POORDIET:
            memoItem = @"饮食不合理";
            break;
        case MEMO_EXTERNALFACTORS_UNWASHED:
            memoItem = @"没洗脸";
            break;
        case MEMO_EXTERNALFACTORS_MENSTRUALPERIOD:
            memoItem = @"生理期";
            break;
        case MEMO_OTHERFACTORS_BODYSPA:
            memoItem = @"身体SPA";
            break;
        case MEMO_OTHERFACTORS_FACESPA:
            memoItem = @"脸部SPA";
            break;
        default:
            memoItem = @"";
            break;
    }
    return memoItem;
}

#warning 依赖老图片
+ (NSString *)getMemoItemIconString:(NSInteger)value gender:(GENDER)gender
{
    NSString *itemIcon = nil;
    switch (value) {
        case MEMO_BODYPART_FACE:
            itemIcon = @"icon-part-face";
            break;
//TODO: need to support more body parts later
//        case MEMO_BODYPART_CANTHUS:
//            itemIcon = @"眼角";
//            break;
//        case MEMO_BODYPART_BODY:
//            itemIcon = @"身体";
//            break;
//        case MEMO_BODYPART_HAND:
//            itemIcon = @"手部";
//            break;
//        case MEMO_BODYPART_FOOT:
//            itemIcon = @"足部";
//            break;
        case MEMO_MOOD_PERFECT:
            if (GENDER_MALE == gender) {
                itemIcon = @"icon-mood-boy-5.png";
            } else {
                itemIcon = @"icon-mood-girl-5.png";
            }
            break;
        case MEMO_MOOD_VERYGOOD:
            if (GENDER_MALE == gender) {
                itemIcon = @"icon-mood-boy-4.png";
            } else {
                itemIcon = @"icon-mood-girl-4.png";
            }
            break;
        case MEMO_MOOD_GOOD:
            if (GENDER_MALE == gender) {
                itemIcon = @"icon-mood-boy-3.png";
            } else {
                itemIcon = @"icon-mood-girl-3.png";
            }
            break;
        case MEMO_MOOD_BAD:
            if (GENDER_MALE == gender) {
                itemIcon = @"icon-mood-boy-2.png";
            } else {
                itemIcon = @"icon-mood-girl-2.png";
            }
            break;
        case MEMO_MOOD_TERRIBLE:
            if (GENDER_MALE == gender) {
                itemIcon = @"icon-mood-boy-1.png";
            } else {
                itemIcon = @"icon-mood-girl-1.png";
            }
            break;
        case MEMO_SKINCARE_MASK:
            itemIcon = @"icon-care-mask";
            break;
        case MEMO_SKINCARE_STEAM:
            itemIcon = @"icon-care-steam";
            break;
        case MEMO_SKINCARE_FACIAL:
            itemIcon = @"icon-care-massage-face";
            break;
        case MEMO_SKINCARE_CLEANSE:
            itemIcon = @"icon-care-cleanse";
            break;
        case MEMO_SKINCARE_CREAM:
            itemIcon = @"icon-care-cream";
            break;
        case MEMO_SKINCARE_ESSENCE:
            itemIcon = @"icon-care-essence";
            break;
        case MEMO_SKINCARE_TONER:
            itemIcon = @"icon-care-toner";
            break;
        case MEMO_SKINCARE_NUTRIMENT:
            itemIcon = @"icon-care-nutrition";
            break;
        case MEMO_SKINCARE_SUNSCREEN:
            itemIcon = @"icon-care-uv";
            break;
        case MEMO_MEDICALSKINCARE_BEAUTYSALON:
            itemIcon = @"icon-special-surgery";
            break;
        case MEMO_MEDICALSKINCARE_HOSPITAL:
            itemIcon = @"icon-special-hospital";
            break;
        case MEMO_WORKOUT_WALKING:
            itemIcon = @"icon-sport-walk";
            break;
        case MEMO_WORKOUT_JOGGING:
            itemIcon = @"icon-sport-run";
            break;
        case MEMO_WORKOUT_YOGA:
            itemIcon = @"icon-sport-yoga";
            break;
        case MEMO_WORKOUT_OTHERS:
            itemIcon = @"icon-sport-other";
            break;
        case MEMO_EXTERNALFACTORS_UV:
            itemIcon = @"icon-factor-uv";
            break;
        case MEMO_EXTERNALFACTORS_SLEEPDEPRIVATION:
            itemIcon = @"icon-factor-lack-sleep";
            break;
        case MEMO_EXTERNALFACTORS_POORDIET:
            itemIcon = @"icon-factor-unhealthy-food";
            break;
        case MEMO_EXTERNALFACTORS_UNWASHED:
            itemIcon = @"icon-factor-lack-washface";
            break;
        case MEMO_EXTERNALFACTORS_MENSTRUALPERIOD:
            itemIcon = @"icon-factor-period";
            break;
        case MEMO_OTHERFACTORS_BODYSPA:
            itemIcon = @"icon-relax-spa-body";
            break;
        case MEMO_OTHERFACTORS_FACESPA:
            itemIcon = @"icon-relax-spa-face";
            break;
        default:
            itemIcon = @"";
            break;
    }
    return itemIcon;
}

+ (int)getMemoItemNumInGroup: (NSInteger)value
{
    switch (value) {
        case MEMO_GROUP_BODYPART:
            return MEMO_BODYPART_NUM - MEMO_BODYPART_START - 1;
            break;
        case MEMO_GROUP_MOOD:
            return MEMO_MOOD_NUM - MEMO_MOOD_START - 1;
            break;
        case MEMO_GROUP_SKINCARE:
            return MEMO_SKINCARE_NUM - MEMO_SKINCARE_START - 1;
            break;
        case MEMO_GROUP_MEDICALSKINCARE:
            return MEMO_MEDICALSKINCARE_NUM - MEMO_MEDICALSKINCARE_START - 1;
            break;
        case MEMO_GROUP_WORKOUT:
            return MEMO_WORKOUT_NUM - MEMO_WORKOUT_START - 1;
            break;
        case MEMO_GROUP_EXTERNALFACTORS:
            return MEMO_EXTERNALFACTORS_NUM - MEMO_EXTERNALFACTORS_START - 1;
            break;
        case MEMO_GROUP_OTHERFACTORS:
            return MEMO_OTHERFACTORS_NUM - MEMO_OTHERFACTORS_START - 1;
            break;
        default:
            return 0;
            break;
    }
}

+ (NSString *)getQuestionTypeString: (NSInteger)value
{
    NSString *questionType = nil;
    switch (value) {
        case QUESTION_TYPE_BASIC:
            questionType = @"基本生活情况";
            break;
        case QUESTION_TYPE_AGE:
            questionType = @"肌肤年龄自测";
            break;
        default:
            questionType = @"";
            break;
    }
    return questionType;
}

+ (double)heightForString:(NSString *)str font:(UIFont *)font andWidth:(float)width
{
    double height = 0.0f;
    if (IS_IOS7) {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        height = ceil(rect.size.height);
    } else {
        CGSize sizeToFit = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        height = sizeToFit.height;
    }
    
    return height;
}

+ (double)widthForString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    double width = 0.0f;
    if (IS_IOS7) {
        CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
        width = rect.size.width;
    } else {
        CGSize sizeToFit = [str sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
        width = sizeToFit.width;
    }
    return width;
}

+ (NSDictionary *)getSystemInfo
{
    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString *systemName = [[UIDevice currentDevice] systemName];
    
    NSString *device = [[UIDevice currentDevice] model];
    
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appVersion = [bundleInfo objectForKey:@"CFBundleShortVersionString"];
    
    NSString *appBuildVersion = [bundleInfo objectForKey:@"CFBundleVersion"];
    
    NSArray *languageArray = [NSLocale preferredLanguages];
    
    NSString *language = [languageArray objectAtIndex:0];
    
    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *country = [locale localeIdentifier];
    
    // 手机型号
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
   
    [infoDic setObject:country forKey:@"country"];
    [infoDic setObject:language forKey:@"language"];
    [infoDic setObject:systemName forKey:@"systemName"];
    [infoDic setObject:systemVersion forKey:@"systemVersion"];
    [infoDic setObject:device forKey:@"device"];
    [infoDic setObject:deviceModel forKey:@"deviceModel"];
    [infoDic setObject:appVersion forKey:@"appVersion"];
    [infoDic setObject:appBuildVersion forKey:@"appBuildVersion"];
    
    return infoDic;
}

+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = [[UIImage alloc] init];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd_HHmmssSSS"];
    return [df stringFromDate:date];
}

+ (UIFont *)customFontWithPath:(NSString *)path size:(CGFloat)size
{
    NSURL *fontURL = [NSURL fileURLWithPath:path];
    
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontURL);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    
    return font;
}

+ (UIFont *)weatherIconFontWithSize:(CGFloat)size
{
    UIFont *font = [DPUtil customFontWithPath:[[NSBundle mainBundle] pathForResource:@"WeatherIcons-Regular" ofType:@"otf"] size:size];
    return font;
}



+ (NSString *)weatherTextWithWeatherCode:(NSInteger)weatherCode
{
    if (weatherCode == DAY_SUNNY || weatherCode == DAY_FAIR) {
        return @"";
    } else if (weatherCode == NIGHT_CLEAR || weatherCode == NIGHT_FAIR) {
        return @"";
    } else if (weatherCode == CLOUDY || weatherCode == DAY_PARTLY_CLOUDY ||
               weatherCode == NIGHT_PARTLY_CLOUDY || weatherCode == DAY_MOSTLY_CLOUDY ||
               weatherCode == NIGHT_MOSTLY_CLOUDY) {
        return @"";
    } else if (weatherCode == OVERCAST) {
        return @"";
    } else if (weatherCode == SHOWER) {
        return @"";
    } else if (weatherCode == THUNDER_SHOWER || weatherCode == THUNDER_SHOWER_WITH_HAIL) {
        return @"";
    } else if (weatherCode == LIGHT_RAIN || weatherCode == MODERATE_RAIN) {
        return @"";
    } else if (weatherCode == HEAVY_RAIN) {
        return @"";
    } else if (weatherCode == STORM || weatherCode == HEAVY_STORM || weatherCode == SEVERE_STORM) {
        return @"";
    } else if (weatherCode == ICE_RAIN || weatherCode == SLEET) {
        return @"";
    } else if (weatherCode == SNOW_FLURRY || weatherCode == LIGHT_SNOW ||
               weatherCode == MODERATE_SNOW || weatherCode == HEAVY_SNOW || weatherCode == SNOWSTORM) {
        return @"";
    } else if (weatherCode == DUST || weatherCode == SAND || weatherCode == DUSTSTORM || weatherCode == SANDSTORM) {
        return @"";
    } else if (weatherCode == FOGGY || weatherCode == HAZE) {
        return @"";
    } else if (weatherCode == WINDY || weatherCode == BLUSTERY) {
        return @"";
    } else if (weatherCode == HURRICANE || weatherCode == TROPICAL_STORM || weatherCode == TORNADO) {
        return @"";
    } else if (weatherCode == COLD) {
        return @"";
    } else if (weatherCode == HOT) {
        return @"";
    } else {
        return @"";
    }
    
    
    return nil;
}

+ (NSString *)weatherWindWithWindLevel:(NSInteger)windLevel
{
    if (windLevel > 0 && windLevel < 6) {
        return @"";
    } else if (windLevel > 5 && windLevel < 11) {
        return @"";
    } else if (windLevel > 10 && windLevel < 16) {
        return @"";
    }else {
        return @"";
    }
    
    return nil;
}



+ (NSString *)windDescTextWithWindLevel:(NSInteger)windLevel
{
    if (windLevel == 0) {
        return @"无风";
    } else if (windLevel == 1) {
        return @"软风";
    } else if (windLevel == 2) {
        return @"轻风";
    } else if (windLevel == 3) {
        return @"微风";
    } else if (windLevel == 4) {
        return @"和风";
    } else if (windLevel == 5) {
        return @"清风";
    } else if (windLevel == 6) {
        return @"强风";
    } else if (windLevel == 7) {
        return @"劲风";
    } else if (windLevel == 8) {
        return @"大风";
    } else if (windLevel == 9) {
        return @"烈风";
    } else if (windLevel == 10) {
        return @"狂风";
    } else if (windLevel == 11) {
        return @"暴风";
    } else if (windLevel == 12) {
        return @"台风";
    } else {
        return @"微风";
    }
    return nil;
}

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

+ (BOOL)isStrNotEmpty:(NSString *)str
{
    if ([DPUtil isNotNull:str]) {
        if ([str isEqualToString:@""]) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return NO;
    }
}

+ (NSInteger)uvLevelWithUVDesc:(NSString *)uvDesc
{
    if ([uvDesc isEqualToString:@"最弱"]) {
        return 1;
    } else if ([uvDesc isEqualToString:@"弱"]) {
        return 2;
    } else if ([uvDesc isEqualToString:@"中等"]) {
        return 3;
    } else if ([uvDesc isEqualToString:@"强"]) {
        return 4;
    } else if ([uvDesc isEqualToString:@"很强"]) {
        return 5;
    }
    return 1;
}

+ (NSString *)facePartNameWithCode:(FACE_PART)facePart
{
    if (facePart == FOREHEAD) {
        return @"额头";
    } else if (facePart == NOSE) {
        return @"鼻子";
    } else if (facePart == CHIN) {
        return @"下巴";
    } else if (facePart == FACE_LEFT) {
        return @"左脸颊";
    } else if (facePart == FACE_RIGHT) {
        return @"右脸颊";
    }else if (facePart == FULL_FACE) {
        return @"全脸";
    }
    return @"额头";
}

+ (NSString *)CosmeticsStatusWithCode:(COSMETICS_LIST)cosmetic
{
    if (cosmetic == COSMETICS_USING) {
        return @"正用";
    } else if (cosmetic == COSMETICS_WANT) {
        return @"想用";
    } else if (cosmetic == COSMETICS_USED) {
        return @"用过";
    }
    return @"正用";
}

+ (NSString *)facePartIconStrWithCode:(FACE_PART)facePart andGender:(GENDER)gender
{
    NSString *iconStr = @"";
    if (GENDER_FEMALE == gender) {
        switch (facePart) {
            case FOREHEAD:
                iconStr = @"icon_history_girl_forehead";
                break;
            case NOSE:
                iconStr = @"icon_history_girl_nose";
                break;
            case CHIN:
                iconStr = @"icon_history_girl_chin";
                break;
            case FACE_LEFT:
                iconStr = @"icon_history_girl_leftcheek";
                break;
            case FACE_RIGHT:
                iconStr = @"icon_history_girl_rightcheek";
                break;
            case FULL_FACE:
                iconStr = @"icon_history_girl_fullface";
                break;

            default:
                break;
        }
    } else {
        switch (facePart) {
            case FOREHEAD:
                iconStr = @"icon_history_boy_forehead";
                break;
            case NOSE:
                iconStr = @"icon_history_boy_nose";
                break;
            case CHIN:
                iconStr = @"icon_history_boy_chin";
                break;
            case FACE_LEFT:
                iconStr = @"icon_history_boy_leftcheek";
                break;
            case FACE_RIGHT:
                iconStr = @"icon_history_boy_rightcheek";
                break;
            case FULL_FACE:
                iconStr = @"icon_history_boy_fullface";
                break;
            default:
                break;
        }
    }
    return iconStr;
}

+ (NSString *)urlEncode:(NSString *)url {
    NSString *encUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger len = [encUrl length];
    const char *c;
    c = [encUrl UTF8String];
    NSString *ret = @"";
    for(int i = 0; i < len; i++) {
        switch (*c) {
            case '/':
                ret = [ret stringByAppendingString:@"%2F"];
                break;
            case '\'':
                ret = [ret stringByAppendingString:@"%27"];
                break;
            case ';':
                ret = [ret stringByAppendingString:@"%3B"];
                break;
            case '?':
                ret = [ret stringByAppendingString:@"%3F"];
                break;
            case ':':
                ret = [ret stringByAppendingString:@"%3A"];
                break;
            case '@':
                ret = [ret stringByAppendingString:@"%40"];
                break;
            case '&':
                ret = [ret stringByAppendingString:@"%26"];
                break;
            case '=':
                ret = [ret stringByAppendingString:@"%3D"];
                break;
            case '+':
                ret = [ret stringByAppendingString:@"%2B"];
                break;
            case '$':
                ret = [ret stringByAppendingString:@"%24"];
                break;
            case ',':
                ret = [ret stringByAppendingString:@"%2C"];
                break;
            case '[':
                ret = [ret stringByAppendingString:@"%5B"];
                break;
            case ']':
                ret = [ret stringByAppendingString:@"%5D"];
                break;
            case '#':
                ret = [ret stringByAppendingString:@"%23"];
                break;
            case '!':
                ret = [ret stringByAppendingString:@"%21"];
                break;
            case '(':
                ret = [ret stringByAppendingString:@"%28"];
                break;
            case ')':
                ret = [ret stringByAppendingString:@"%29"];
                break;
            case '*':
                ret = [ret stringByAppendingString:@"%2A"];
                break;
            default:
                ret = [ret stringByAppendingFormat:@"%c", *c];
        }
        c++;
    }
    
    return ret;
}

+ (UIImage *)addLogoOnImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(image.size);
    CGSize imageSize = image.size;
    
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    
    UIImage *maskImage = [UIImage imageNamed:@"icon_molijing_logo" color:[UIColor orangeColor]];
    
    [maskImage drawInRect:CGRectMake(0, 0, maskImage.size.width, maskImage.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


+ (NSDictionary *)serverRequestSign:(NSString *)queryPath
{
    NSString *userId = [NSString stringWithFormat:@"%d", [DPSettingData userID]];
    NSString *sid = [DPSettingData sid];
    NSString *timeInterval = [DPSettingData timestamp];
    //  当前时间戳
    NSString *timestamp = nil;
    if ([DPUtil isStrNotEmpty:timeInterval]) {
        NSDate *localeDate = [NSDate date];
        timestamp = [NSString stringWithFormat:@"%lld", (llroundf([localeDate timeIntervalSince1970] + [timeInterval integerValue])) * 1000];
    } else {
        timestamp = @"";
    }
    
    if (![DPUtil isStrNotEmpty:sid]) {
        sid = @"";
    }
    
    if (![DPUtil isStrNotEmpty:userId]) {
        userId = @"-1";
    }
    
    if (![DPUtil isStrNotEmpty:queryPath]) {
        queryPath = @"";
    } else {
        if (![queryPath hasPrefix:@"/"]) {
            queryPath = [NSString stringWithFormat:@"/%@", queryPath];
        }
    }
    
    NSString *sign = [[NSString stringWithFormat:@"%@%@%@%@", queryPath, userId, sid, timestamp] md5];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:3];
    [result setObject:sign forKey:@"sign"];
    [result setObject:userId forKey:@"userId"];
    [result setObject:timestamp forKey:@"timestamp"];
    
    return result;
}

// 获取结果子项中文描述
+ (NSString *)resultItemNameWithCode:(TEST_RESULT_ITEM)item
{
    NSString *name;
    switch (item) {
        case TEST_RESULT_ITEM_OVERALL:
            name = @"综合";
            break;
        case TEST_RESULT_ITEM_WATER_OIL:
            name = @"水油";
            break;
        case TEST_RESULT_ITEM_WHITE:
            name = @"美白";
            break;
        case TEST_RESULT_ITEM_PORE:
            name = @"毛孔";
            break;
        case TEST_RESULT_ITEM_SENSITIVITY:
            name = @"敏感";
            break;
        default:
            break;
    }
    return name;
}
// 获取结果子项小图标
+ (NSString *)resultItemIconStrWithCode:(TEST_RESULT_ITEM)item
{
    NSString *path;
    switch (item) {
        case TEST_RESULT_ITEM_OVERALL:
            path = @"icon_overall";
            break;
        case TEST_RESULT_ITEM_WATER_OIL:
            path = @"icon_waterandoil";
            break;
        case TEST_RESULT_ITEM_WHITE:
            path = @"icon_white";
            break;
        case TEST_RESULT_ITEM_PORE:
            path = @"icon_pore";
            break;
        case TEST_RESULT_ITEM_SENSITIVITY:
            path = @"icon_sensitivity";
            break;
        default:
            break;
    }
    return path;
}

// 将1转换为a 2转换为b
+ (NSString *)formateNumberOptionToEnglishOption:(NSInteger)numberOption
{
    if (numberOption <= 0) {
        return @"a";
    }
    char temp = 'a';
    char result = temp + numberOption - 1;
    
    return [NSString stringWithFormat:@"%c", result];
}
// 将a转换为1 b转换为2
+ (NSInteger)formateEnglishOptionToNumberOption:(NSString *)englishOption
{
    const char* temp = [englishOption UTF8String];
    NSInteger result = temp[0] - 'a' + 1;
    return result > 0 ? result : 1;
}

+ (NSString *)getIntegralChangeDescStrFromEnum:(INTEGRAL_CHANGE_WAY)changeWay
{
    NSString *desc = @"";
    switch (changeWay) {
        case INTEGRAL_GAIN_BY_WHOLE_FACE_TEST:
            desc = @"每日首次全脸检测奖励";
            break;
        default:
            break;
    }
    return desc;
}

@end
