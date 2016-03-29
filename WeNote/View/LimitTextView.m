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
@interface LimitTextView()<HPGrowingTextViewDelegate>
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) UIFont * font;
@property (nonatomic, strong) HPGrowingTextView * textView;
@property (nonatomic, strong) UIButton * editBtn;
@end

@implementation LimitTextView
-(instancetype)initWithString:(NSString*)text andFont:(UIFont*)font{
    self = [super init];
    if (self) {
        self.font = font;
        self.text = text;
        self.maxLines = 1;
        self.minLines = 1;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    HPGrowingTextView * tv = [HPGrowingTextView new];
    self.textView = tv;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.delegate =  self;
    
    self.textView.font = self.font;
    self.textView.clipsToBounds = YES;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.text = self.text;
    self.textView.editable = NO;
    self.textView.maxNumberOfLines = self.maxLines;
    self.textView.isScrollable = NO;
    self.textView.internalTextView.showsVerticalScrollIndicator = NO;
    self.textView.internalTextView.scrollEnabled = NO;
    self.textView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-EditImageWidth);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];

    
    
    UIButton * btn = [UIButton new];
    self.editBtn = btn;
    self.editBtn.backgroundColor = [UIColor blackColor];
    [self.editBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.editBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.editBtn addTarget:self action:@selector(startEdit) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editBtn];

    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(EditImageWidth, EditImageWidth));
        make.left.equalTo(self.textView.mas_right).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
    }];


}
-(void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView{
    if (growingTextView.internalTextView.markedTextRange == nil && growingTextView.internalTextView.text.length > self.limitLenth)      {
        growingTextView.internalTextView.text = [growingTextView.internalTextView.text substringToIndex:self.limitLenth];
    }
}

-(void)startEdit{
    self.textView.editable = YES;
    self.editCallback(YES);
}
-(void)endEdit{
    self.textView.editable = NO;
    self.editCallback(NO);
}
@end
