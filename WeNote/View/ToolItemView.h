//
//  ToolItemView.h
//  WeNote
//
//  Created by WangPan on 16/4/5.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnCallback)(NSInteger back);
@interface ToolItemView : UIView
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) NSArray * nomPicNameArr;
@property (nonatomic, strong) NSArray * heiPicNameArr;
@property (nonatomic, copy) btnCallback clickback;
@end
