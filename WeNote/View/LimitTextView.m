//
//  LimitTextView.m
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "LimitTextView.h"
#import "HPGrowingTextView.h"

#define EditImageWidth 30
@interface LimitTextView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UIButton * editBtn;
@property (nonatomic, strong) UIView * bomLine;
@end

@implementation LimitTextView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.limitLenth = 20;
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    UITextView * tv = [UITextView new];
    self.textView = tv;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate =  self;
    self.textView.clipsToBounds = YES;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-EditImageWidth);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
    UIButton * btn = [UIButton new];
    self.editBtn = btn;
    [self.editBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 5)];
    [self.editBtn addTarget:self action:@selector(isEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editBtn];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(EditImageWidth, EditImageWidth));
        make.left.equalTo(self.textView.mas_right).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(2);
        make.right.equalTo(self.mas_right).with.offset(0);
    }];

}
-(void)createBomLine{
    UIView * lineView = [UIView new];
    self.bomLine = lineView;
    [self addSubview:self.bomLine];
    [self.bomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textView.mas_bottom).with.offset(0);
        make.left.equalTo(self.textView.mas_left).with.offset(0);
        make.top.equalTo(self.textView.mas_bottom).with.offset(-1);
        make.right.equalTo(self.textView.mas_right).with.offset(0);
    }];
}

-(void)isEdit:(UIButton *)sender{
    self.textView.editable = !self.textView.editable;
    if (self.textView.editable) {
        sender.selected  = YES;
        [self.textView becomeFirstResponder];
    }else{
        sender.selected = NO;
        [self.textView resignFirstResponder];
        self.editCallback(self.textView.text);
    }
}

#pragma textViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.markedTextRange == nil && [self getByteLenth:textView.text] > self.limitLenth * 2) {
        for (int i  = (int)textView.text.length; i >= self.limitLenth; i--) {
            NSString * curText = [textView.text substringToIndex:i];
            if ([self getByteLenth:curText] <= self.limitLenth*2) {
                textView.text = curText;
                break;
            };
        }
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textView.text.length == 0) {
        self.textView.text = [self.text copy];
    }else{
        self.text = [self.textView.text copy];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        self.textView.editable = NO;
        [textView resignFirstResponder];
        return NO;
    }
    if ([self getByteLenth:textView.text] > self.limitLenth*2 && ![text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (int)getByteLenth:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }else {
            p++;
        }
    }
    return strlength;
}


#pragma setters
-(void)setFont:(UIFont *)font{
    self.textView.font = font;
}

-(void)setText:(NSString *)text{
    self.textView.text = text;
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment{
    self.textView.textAlignment = textAlignment;
}

-(void)setHasBomLine:(BOOL)hasBomLine{
    if (hasBomLine) {
        if (!self.bomLine) {
            [self createBomLine];
        }
    }
}
-(void)setBomLineColor:(UIColor *)bomLineColor{
    if (!self.bomLine) {
        [self createBomLine];
    }
    self.bomLine.backgroundColor = bomLineColor;
}

-(void)setHeiImg:(UIImage *)heiImg{
    [self.editBtn setImage:heiImg forState:UIControlStateHighlighted];
}

-(void)setSelectImg:(UIImage *)selectImg{
    [self.editBtn setImage:selectImg forState:UIControlStateSelected];
}

-(void)setEditImg:(UIImage *)editImg{
    [self.editBtn setImage:editImg forState:UIControlStateNormal];
}

-(void)setLimitLenth:(int)limitLenth{
    _limitLenth = limitLenth;
}
@end
