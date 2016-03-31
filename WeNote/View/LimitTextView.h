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
@property (nonatomic, assign) int limitLenth;
@property (nonatomic, assign) BOOL hasBomLine;
@property (nonatomic, strong) UIColor * bomLineColor;
@property (nonatomic, copy)  editBlock editCallback;

-(instancetype)initWithString:(NSString*)titStr andFont:(UIFont*)font;
@end
