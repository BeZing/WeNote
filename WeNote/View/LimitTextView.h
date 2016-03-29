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
@property (nonatomic, assign) BOOL hasUnderLine;
@property (nonatomic, assign) BOOL hasLimitLenth;
@property (nonatomic, assign) NSInteger limitLenth;
@property (nonatomic, copy)  editBlock editCallback;

-(instancetype)initWithFrame:(CGRect)frame andString:(NSString*)titStr andFont:(UIFont*)font;
@end
