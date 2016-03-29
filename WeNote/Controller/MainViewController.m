//
//  MainViewController.m
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "MainViewController.h"
#import "LimitTextView.h"

@interface MainViewController()
@property (nonatomic, strong) UITextField * titleTF;
@property (nonatomic, strong) UITextField * nameTF;
@property (nonatomic, strong) UITextField * classTF;
@end
@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self createNoteTitle];
}

-(void)createNoteTitle{
//    NSString * titString = [];
    NSString * titStr = @"一个两个三个四个五个六个七个八个九个aaabbbbcccdddeeefff";
    UIFont * font = [UIFont systemFontOfSize:20];
    LimitTextView * ltv = [[LimitTextView alloc] initWithString:titStr andFont:font];
    ltv.limitLenth = 26;
    ltv.maxLines = 4;
    [self.view addSubview:ltv];
    [ltv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(230, 120));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(100);
    }];
    ltv.editCallback = ^(BOOL edit){
        if (edit) {
            [self createNoteTitle1];

        }else{
        }
    };
}
-(void)createNoteTitle1{
    ObjLog(@"=====1");
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
