//
//  DefineHeader.h
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//
#import "KeyDefineHeader.h"
#ifndef DefineHeader_h
#define DefineHeader_h




#ifdef DEBUG
#define ObjLog(obj)     NSLog(@"[line:%d]%@",__LINE__,obj)
#define DeLog(fmt, ...) NSLog((@"[lineNum:%d]" fmt), __LINE__, ##__VA_ARGS__)
#define ErrLog(fmt, ...) NSLog((@"\n==Error********Start\n==Function:%s\n" "==LineNum:%d \n" "==" fmt "\n==Error********End"), __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ObjLog(obj)
#define DeLog(fmt, ...)
#define ErrLog(fmt,...)
#endif

#define RGBColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//十六进制色值,0x000000
#define HexColor(_hex_) [UIColor colorWithRed:((float)((hexString & 0xFF0000) >> 16))/255.0 green:((float)((hexString & 0xFF00) >> 8))/255.0 blue:((float)(hexString & 0xFF))/255.0 alpha:1.0]

#define IOSEightOrLater [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0


#endif /* DefineHeader_h */
