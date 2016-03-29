//
//  Utilities.m
//  MyObjectiveC
//
//  Created by WangPan on 15/5/25.
//  Copyright (c) 2015年 WangPan. All rights reserved.
//

#import "Utilities.h"
#import <CommonCrypto/CommonDigest.h>
#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>

#define passLength 6
@implementation Utilities

//判断是否是合法的手机号
+(BOOL)isMobileNumber:(NSString *)num{
    NSString * mobile = @"^1(3[0-9]|5[0-35-9]|7[7]|8[0-9])\\d{8}$";
    NSPredicate * regMobile = [NSPredicate predicateWithFormat: @"SELF MATCHES %@",mobile];
    return [regMobile evaluateWithObject:num];
}

//判断String是否大于N位
+(BOOL)isPasswordLength:(NSString *)pass{
    return pass.length >= passLength;
}

//判断两个String是否相等并且大于6位
+(BOOL)isPasswordWithPass :(NSString *)pass andRePass : (NSString *)rePass{
    return [pass isEqualToString:rePass] && [self isPasswordLength:pass];
}

//判断String是否是2-4个汉字
+(BOOL)isChineseName:(NSString*)name{
    NSString * text = @"^[\\u4e00-\\u9fa5]{2,3,4}$";
    NSPredicate * regName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",text];
    return [regName evaluateWithObject:name];
}

//判断是否是合法的6位验证码
+(BOOL)isVerify:(NSString *)verify{
    NSString * vf = @"^\\d{6}$";
    NSPredicate * regVF = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", vf];
    return [regVF evaluateWithObject:verify];
}

//初步判断是否是合法的邮箱地址
+(BOOL)isMail:(NSString *)mail{
    NSString * email = @"^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,5}$";
    NSPredicate * mailReg = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",email];
    return [mailReg evaluateWithObject:mail];
}

//本地时间格式转换成字符串
+(NSString*)timeToString:(NSDate*)time{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterFullStyle;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:time];
}

//字符串转换成时间格式
+(NSDate*)stringToTime:(NSString*)time{
    NSDate * date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([time rangeOfString:@"T"].location != NSNotFound) {
        NSString * timeString = [time stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        date = [formatter dateFromString:timeString];
    }else{
        date = [formatter dateFromString:time];
    }
    return date;
}

//获取当前应用的documets文件夹路径
+(NSString*)documentPath{
    NSArray * docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = docs.lastObject;
    return document;
}

//获取当前应用的Cache路径
+(NSString*)cachesPath{
    NSArray * cas = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * cache = cas.lastObject;
    return cache;
}


//--------通过0x000000获取RGB颜色
+(UIColor*)colorWithHex:(NSInteger)hex andAlpha:(CGFloat)alpha{
    return  [UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hex & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hex & 0xFF))/255.0 alpha:alpha];
}
+(UIColor*)hexColor:(NSInteger)hex{
   return  [UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16))/255.0 green:((CGFloat)((hex & 0xFF00) >> 8))/255.0 blue:((CGFloat)(hex & 0xFF))/255.0 alpha:1.0];
}

//通过key值获取plist字典中对应key的dict
+(NSMutableDictionary*)getDictFromPlistByKey:(NSString*)key{
    NSMutableDictionary * dict;
    NSString *path = [[self documentPath] stringByAppendingPathComponent:@"appData.plist"];
    NSDictionary * mainDict = [NSDictionary dictionaryWithContentsOfFile:path];
    if (mainDict) {
        dict = [mainDict objectForKey:key];
    }else{
        dict = [NSMutableDictionary dictionary];
    }
    return dict;
}

//通过key值将key为dict的字典写入plist字典中
+(void)writeDict:(NSMutableDictionary*)dict toPlistByKey:(NSString*)key{
    NSMutableDictionary * mainDict;
    NSString *path = [[self documentPath] stringByAppendingPathComponent:@"appData.plist"];
    NSMutableDictionary * tempDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (tempDict) {
        mainDict = tempDict;
    }else{
        mainDict = [NSMutableDictionary dictionary];
    }
    [mainDict setObject:dict forKey:key];
    [mainDict writeToFile:path atomically:YES];
}

//根据字体大小和宽高上限获取string的宽高度
+(CGSize)sizeOfStringByMaxWidth:(CGSize)size andFont:(UIFont *)font text:(NSString*)string{
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}


//根据字体大小和宽高上限获取string的宽高度的label
+(void)creatLabelCalcuSizeByRect:(CGRect)rect text:(NSString*)text tag:(NSInteger)tag fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor bgColor:(UIColor*)bgColor  alignment:(NSTextAlignment)alignment supView:(UIView*)supView{
    UILabel *label;
    CGSize size = [self sizeOfStringByMaxWidth:rect.size andFont:[UIFont systemFontOfSize:fontSize] text:text];
    CGRect  newRect = CGRectMake(rect.origin.x, rect.origin.y, size.width, rect.size.height);
    if  ([supView viewWithTag:tag] == nil) {
        label = [[UILabel alloc] initWithFrame:newRect];
        label.backgroundColor = [UIColor clearColor];
        label.text = text;
        label.font = [UIFont systemFontOfSize:fontSize];
        label.textColor = textColor;
        label.backgroundColor = bgColor;
        label.textAlignment = alignment;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.tag = tag;
        [supView addSubview:label];
    }else{
        label = (UILabel*)[supView viewWithTag:tag];
        label.text = text;
        label.frame = newRect;
    }
}

//固定rect的label
+(void)creatLabelByRect:(CGRect)rect text:(NSString*)text tag:(NSInteger)tag textStyle:(NSString*)textStyle textColor:(UIColor*)textColor  alignment:(NSTextAlignment)alignment  supView:(UIView*)supView{
    UILabel *label = (UILabel *)[supView viewWithTag:tag];
    if  (!label) {
        label = [[UILabel alloc] initWithFrame:rect];
        label.tag = tag;
        [supView addSubview:label];
    }
    label.text = text;
    label.frame = rect;
    label.font = [UIFont preferredFontForTextStyle:textStyle];
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.lineBreakMode = NSLineBreakByWordWrapping;
}

//获取md5值，需要import头文件
+(NSString*)getMD5:(NSString*)string{
    const char * oriStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(oriStr, (CC_LONG)strlen(oriStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x",result[i]];
    }
    return [hash lowercaseString];
}


//获取指定时间到当前时间的间隔
+(NSString *)getChinaDateTimeInterval:(NSString *)dateString{
    int month;
    int comyear,commonth,comday,comhour,commin,comsec;
    NSArray *timeArray = [dateString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
    month = [[timeArray objectAtIndex:1] intValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *nowTimeArray = [nowString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
    
    comyear =  [[nowTimeArray objectAtIndex:0] intValue]-[[timeArray objectAtIndex:0] intValue];
    commonth = [[nowTimeArray objectAtIndex:1] intValue]-[[timeArray objectAtIndex:1] intValue];
    comday = [[nowTimeArray objectAtIndex:2] intValue]-[[timeArray objectAtIndex:2] intValue];
    comhour = [[nowTimeArray objectAtIndex:3] intValue]-[[timeArray objectAtIndex:3] intValue];
    commin = [[nowTimeArray objectAtIndex:4] intValue]-[[timeArray objectAtIndex:4] intValue];
    comsec = [[nowTimeArray objectAtIndex:5] intValue]-[[timeArray objectAtIndex:5] intValue];
    
    if (comsec < 0) {
        comsec += 60;
        commin--;
    }
    if (commin < 0) {
        commin += 60;
        comhour--;
    }
    if (comhour < 0) {
        comhour += 24;
        comday--;
    }
    if (comday < 0) {
        switch (month) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                comday += 31;
                break;
            case 4:
            case 6:
            case 9:
            case 11:
                comday += 30;
                break;
            case 2:
                if (([[nowTimeArray objectAtIndex:0] intValue]%4&&[[nowTimeArray objectAtIndex:0] intValue]%100 )|| [[nowTimeArray objectAtIndex:0] intValue]%400 ) {
                    comday += 29;
                }
                else{
                    comday += 28;
                }
                break;
                
            default:
                break;
        }
        commonth--;
    }
    if (commonth < 0) {
        commonth += 12;
        comyear--;
    }
    
    if(comyear > 0){
        return [NSString stringWithFormat:@"%d年前更新",comyear];
    }
    if(commonth > 0){
        return [NSString stringWithFormat:@"%d月前更新",commonth];
    }
    if(comday > 0){
        return [NSString stringWithFormat:@"%d天前更新",comday];
    }
    if(comhour > 0){
        return [NSString stringWithFormat:@"%d小时前更新",comhour];
    }
    if(commin > 0){
        return [NSString stringWithFormat:@"%d分钟前更新",commin];
    }
    if(comsec > 0){
        return [NSString stringWithFormat:@"%d秒前更新",comsec];
    }else {
        return [NSString stringWithFormat:@"1秒前更新"];
    }

}


+ (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSUInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSUInteger i,i2;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        for (i2=0; i2<3; i2++) {
            value <<= 8;
            if (i+i2 < length) {
                value |= (0xFF & input[i+i2]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    (uint8_t)table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    (uint8_t)table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? (uint8_t)table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? (uint8_t)table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+(UIFont*)getSysemFont:(NSString*)textStyle{
    UIFont * font = [[NSUserDefaults standardUserDefaults] objectForKey:CUSFONTKEY];
    if (!font) {
        font = [UIFont preferredFontForTextStyle:textStyle];
    }
    return font;
}
@end
