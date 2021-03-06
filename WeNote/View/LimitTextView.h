//
//  LimitTextView
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^editBlock)(NSString* info);

@interface LimitTextView : UIView

@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, assign) int limitLenth;
@property (nonatomic, assign) BOOL hasBomLine;
@property (nonatomic, strong) UIColor * bomLineColor;
@property (nonatomic, copy)  editBlock editCallback;
@property (nonatomic, strong) UIImage * editImg;
@property (nonatomic, strong) UIImage * heiImg;
@property (nonatomic, strong) UIImage * selectImg;
@property (nonatomic, assign) NSTextAlignment  textAlignment;
@end
