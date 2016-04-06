//
//  SelectBtnView.h
//  WeNote
//
//  Created by WangPan on 16/3/31.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectBlock) (int index);
@interface SelectBtnView : UIView
//约定数组都有相同切足够的元素。
@property (nonatomic, strong) NSArray * itemsArr;
@property (nonatomic, strong) NSArray * nomPicNameArr;
@property (nonatomic, strong) NSArray * heiPicNameArr;
@property (nonatomic, strong) NSArray * selectPicNameArr;
@property (nonatomic, assign) NSInteger indexSelect;
@property (nonatomic, copy) selectBlock selectCallback;
@end
