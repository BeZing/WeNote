//
//  LimitTextView.m
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "LimitTextView.h"
#define EditImageWidth 30
@interface LimitTextView()<UITextViewDelegate>
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UIButton * editBtn;
@end

@implementation LimitTextView
-(instancetype)initWithFrame:(CGRect)frame andString:(NSString*)text andFont:(UIFont*)font{
    self = [super init];
    if (self) {
        self.font = font;
        self.text = text;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    UITextView * tv = [UITextView new];
    self.textView = tv;
    self.textView.delegate = self;
    self.textView.text = self.text;
    [self addSubview:self.textView];
    
    CGSize sizeToFit = [self.textView sizeThatFits:CGSizeMake(self.bounds.size.width - EditImageWidth, MAXFLOAT)];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-EditImageWidth);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(sizeToFit.width, sizeToFit.height));
    }];
    self.textView.font = self.font;
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    self.textView.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton * btn = [UIButton new];
    self.editBtn = btn;
    [self addSubview:self.editBtn];

    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(EditImageWidth, EditImageWidth));
        make.left.equalTo(self.textView.mas_right).with.offset(0);
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
    }];
    self.editBtn.backgroundColor = [UIColor blackColor];
    [self.editBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.editBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.editBtn addTarget:self action:@selector(startEdit) forControlEvents:UIControlEventTouchUpInside];

}
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.markedTextRange == nil && textView.text.length > self.limitLenth)      {
        textView.text = [textView.text substringToIndex:self.limitLenth];
    }
    DeLog(@"%f",textView.contentOffset.y);
}
-(void)startEdit{
    self.textView.editable = !self.textView.editable;
    self.editCallback(self.textView.editable);
}
-(void)endEdit{
    self.textView.editable = NO;
    self.editCallback(NO);
}
@end
