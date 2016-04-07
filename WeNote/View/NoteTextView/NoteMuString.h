//
//  NoteMuString.h
//  WeNote
//
//  Created by WangPan on 16/4/6.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger , NoteContentType) {
    NoteContentTypeText = 0,
    NoteContentTypeUrl,
    NoteContentTypePhone
};
@interface NoteMuString : NSMutableString
@property (nonatomic, strong) NSMutableString * mas;
@end
