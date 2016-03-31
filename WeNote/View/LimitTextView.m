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
@property (nonatomic, copy) NSString * text;
@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UIButton * editBtn;
@property (nonatomic, strong) UIView * bomLine;
@end

@implementation LimitTextView
-(instancetype)initWithString:(NSString*)text andFont:(UIFont*)font{
    self = [super init];
    if (self) {
        self.font = font;
        self.text = text;
        self.hasBomLine = NO;
        self.bomLineColor = [UIColor lightGrayColor];
        self.editImg = [UIImage imageNamed:DefaultImageName];
        self.heiImg = [UIImage imageNamed:DefaultImageName];
        self.selectImg = [UIImage imageNamed:DefaultImageName];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"edit.png"]];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{

    UITextView * tv = [UITextView new];
    self.textView = tv;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate =  self;
    self.textView.font = self.font;
    self.textView.clipsToBounds = YES;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.text = [self.text copy];
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-EditImageWidth);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];

    if (self.hasBomLine) {
        UIView * lineView = [UIView new];
        self.bomLine = lineView;
        self.bomLine.backgroundColor = self.bomLineColor;
        [self addSubview:self.bomLine];
        
        [self.bomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom).with.offset(0);
            make.left.equalTo(self.textView.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(self.bounds.size.width - EditImageWidth, 1));
        }];
    }
    
    UIButton * btn = [UIButton new];
    self.editBtn = btn;
    [self.editBtn setImage:self.editImg forState:UIControlStateNormal];
    [self.editBtn setImage:self.heiImg forState:UIControlStateHighlighted];
    [self.editBtn setImage:self.selectImg forState:UIControlStateSelected];
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

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.markedTextRange == nil && [self getByteLenth:textView.text] > self.limitLenth * 2) {
        for (int i  = textView.text.length; i >= self.limitLenth; i--) {
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
@end
