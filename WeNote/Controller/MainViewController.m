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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNoteTitle];
}

-(void)createNoteTitle{
    NSString * titStr = @"一江春水向东流 两只黄鹂鸣翠柳";
    UIFont * font = [UIFont systemFontOfSize:20];
    LimitTextView * ltv = [[LimitTextView alloc] initWithFrame:CGRectMake(0, 0, 200 , 100) andString:titStr andFont:font];
    ltv.limitLenth = 30;
    [self.view addSubview:ltv];
    [ltv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 100));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(100);
    }];
    ltv.editCallback = ^(BOOL edit){
        if (edit) {
            
        }else{
            [self createNoteTitle1];
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
