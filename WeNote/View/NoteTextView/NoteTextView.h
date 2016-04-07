//
//  NoteTextView.h
//  WeNote
//
//  Created by WangPan on 16/4/6.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTextView : UIView
@property (nonatomic, strong) NSArray * imageArr;
@property (nonatomic, strong) NSArray * imgFrameArr;
@property (nonatomic, strong) NSMutableString * textString;
@property (nonatomic, assign) BOOL editable;
@end
