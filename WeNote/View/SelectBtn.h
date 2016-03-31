//
//  SelectBtn.h
//  WeNote
//
//  Created by WangPan on 16/3/31.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^selectBlock) (int index);
@interface SelectBtn : UIView
@property (nonatomic, strong) NSArray * itemsArr;
@property (nonatomic, strong) NSArray * nomPicArr;
@property (nonatomic, strong) NSArray * heiPicArr;
@property (nonatomic, strong) NSArray * selectPicArr;
@property (nonatomic, assign) NSInteger indexSelect;
@property (nonatomic, copy) selectBlock selectCallback;
@end
