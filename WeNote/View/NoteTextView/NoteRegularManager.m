//
//  NoteRegularManager.m
//  WeNote
//
//  Created by WangPan on 16/4/7.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "NoteRegularManager.h"

@implementation NoteRegularManager


+ (NSMutableArray *)matchMobileLink:(NSString *)pattern{
    
    NSRegularExpression*regular=[[NSRegularExpression alloc]initWithPattern:@"(\\(86\\))?(13[0-9]|15[0-35-9]|17[0-9]|18[0125-9])\\d{8}" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];

    return  [self getLinkArrBy:regular andPattern:pattern];
}



+ (NSMutableArray *)matchWebLink:(NSString *)pattern{
    
    NSRegularExpression*regular=[[NSRegularExpression alloc]initWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:NSRegularExpressionDotMatchesLineSeparators|NSRegularExpressionCaseInsensitive error:nil];
    
    return  [self getLinkArrBy:regular andPattern:pattern];
    
}

+(NSMutableArray *)getLinkArrBy:(NSRegularExpression*)regular andPattern:(NSString*)pattern{
    NSMutableArray *linkArr = [NSMutableArray arrayWithCapacity:0];
    
    NSArray* array=[regular matchesInString:pattern options:0 range:NSMakeRange(0, [pattern length])];
    
    for( NSTextCheckingResult * result in array){
        
        NSString * string=[pattern substringWithRange:result.range];
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:string,NSStringFromRange(result.range), nil];
        
        [linkArr addObject:dic];
    }
    // NSLog(@"linkArr == %@",linkArr);
    return linkArr;
}
@end
