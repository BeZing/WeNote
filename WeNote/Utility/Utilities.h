//
//  Utilities.h
//  MyObjectiveC
//
//  Created by WangPan on 15/5/25.
//  Copyright (c) 2015年 WangPan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HEXCOLOR(hexString) [UIColor colorWithRed:((float)((hexString & 0xFF0000) >> 16))/255.0 green:((float)((hexString & 0xFF00) >> 8))/255.0 blue:((float)(hexString & 0xFF))/255.0 alpha:1.0]


@interface Utilities : NSObject

+(BOOL)isMobileNumber:(NSString *)num;
+(BOOL)isPasswordLength:(NSString *)pass;
+(BOOL)isPasswordWithPass :(NSString *)pass andRePass : (NSString *)rePass;
+(BOOL)isChineseName:(NSString*)string;
+(BOOL)isVerify:(NSString *)verify;
+(BOOL)isMail:(NSString *)mail;

+(NSString*)timeToString:(NSDate*)time;
+(NSDate*)stringToTime:(NSString*)time;

+(NSString*)documentPath;
+(NSString*)cachesPath;

+(UIColor*)colorWithHex:(NSInteger)hex andAlpha:(CGFloat)alpha;
+(UIColor*)hexColor:(NSInteger)hex;

+(NSString*)getMD5:(NSString*)string;

+(NSMutableDictionary*)getDictFromPlistByKey:(NSString*)key;
+(void)writeDict:(NSMutableDictionary*)dict toPlistByKey:(NSString*)key;

+(CGSize)sizeOfStringByMaxWidth:(CGSize)size andFont:(UIFont *)font text:(NSString*)string;
+(void)creatLabelCalcuSizeByRect:(CGRect)rect text:(NSString*)text tag:(NSInteger)tag fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor bgColor:(UIColor*)bgColor alignment:(NSTextAlignment)alignment supView:(UIView*)supView;
+(void)creatLabelByRect:(CGRect)rect text:(NSString*)text tag:(NSInteger)tag textStyle:(NSString*)textStyle textColor:(UIColor*)textColor  alignment:(NSTextAlignment)alignment  supView:(UIView*)supView;


+(NSString *)getChinaDateTimeInterval:(NSString *)dateString;
+(UIFont*)getSysemFont:(NSString*)textStyle;
@end
