//
//  LimitTextView
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^editBlock)(BOOL edit);

@interface LimitTextView : UIView
@property (nonatomic, assign) int minLines;
@property (nonatomic, assign) int maxLines;
@property (nonatomic, assign) int limitLenth;
@property (nonatomic, copy)  editBlock editCallback;

-(instancetype)initWithString:(NSString*)titStr andFont:(UIFont*)font;
@end
