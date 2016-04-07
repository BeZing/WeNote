//
//  ToolItemView.h
//  WeNote
//
//  Created by WangPan on 16/4/5.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnCallback)(NSString* item);
@interface ToolItemView : UIView
@property (nonatomic, strong) NSArray * nomPicArr;
@property (nonatomic, strong) NSArray * heiPicArr;
@property (nonatomic, assign) CGFloat spaceHei;
@property (nonatomic, copy) btnCallback clickback;

-(instancetype)initWithFrame:(CGRect)frame andItems:(NSArray*)items;
@end
