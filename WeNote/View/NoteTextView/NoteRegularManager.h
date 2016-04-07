//
//  NoteRegularManager.h
//  WeNote
//
//  Created by WangPan on 16/4/7.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteRegularManager : NSObject

+ (NSMutableArray *)matchMobileLink:(NSString *)pattern;

+ (NSMutableArray *)matchWebLink:(NSString *)pattern;

@end
