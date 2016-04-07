//
//  NoteTextView.m
//  WeNote
//
//  Created by WangPan on 16/4/6.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "NoteTextView.h"
#import "NoteTextContainer.h"
#import "NoteTextStorage.h"
#import "NoteLayoutManager.h"
#import "NoteMuString.h"
@interface NoteTextView()<UITextViewDelegate>
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) NSMutableArray * imgViewsArr;
@property (nonatomic, strong) NSMutableArray * imgFramesArr;
//@property (nonatomic, strong) NoteTextContainer * textContainer;
//@property (nonatomic, strong) NoteTextStorage * textStorage;
//@property (nonatomic, strong) NoteLayoutManager * layoutManager;
@property (nonatomic, strong) NoteMuString * muString;
@property (nonatomic, strong) NSMutableArray * pathsArr;
@end

@implementation NoteTextView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgViewsArr = [NSMutableArray array];
        self.imgFramesArr = [NSMutableArray array];
        self.pathsArr = [NSMutableArray array];
        [self createTextView];
    }
    return self;
}


-(void)createTextView{
    UITextView * tv = [[UITextView alloc] initWithFrame:self.bounds];
    self.textView = tv;
    self.textView.editable = NO;
    [self addSubview:self.textView];
}

#pragma setters

-(void)setEditable:(BOOL)editable{
    self.textView.editable = editable;
}

-(void)setImageArr:(NSArray *)imageArr{
    for (int i = 0; i < imageArr.count;  i ++) {
        UIImage * img  = imageArr[i];
        UIImageView * iv = [UIImageView new];
        CGRect rect = CGRectZero;
        if (self.imgFramesArr.count >= imageArr.count) {
            rect = [self.imgFramesArr[i] CGRectValue];
        }else{
            CGSize aSize = [Utilities fitImage:img toSize:CGSizeMake(100, 100)];
            rect = CGRectMake(i * 20 + 20, i * 20 + 200, aSize.width, aSize.height);
        }
        iv.image = img;
        [self.imgViewsArr addObject:iv];
        [self.textView addSubview:iv];
    }
}
-(void)setTextString:(NSMutableString *)textString{
    self.muString = [textString copy];
    self.textView.text = self.muString;
}
-(void)setImgFrameArr:(NSArray *)imgFrameArr{
    [self.imgFramesArr addObjectsFromArray:imgFrameArr];
    for (int i = 0 ; i < imgFrameArr.count; i ++) {
        CGRect rect = [imgFrameArr[i]  CGRectValue];
        if (self.imgViewsArr.count >= imgFrameArr.count) {
            UIImageView * iv = self.imgViewsArr[i];
            iv.frame = rect;
        }
        UIBezierPath * rectPath = [UIBezierPath bezierPathWithRect:rect];
        [self.pathsArr addObject:rectPath];
    }
    self.textView.textContainer.exclusionPaths = self.pathsArr;
}

#pragma delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
}
@end





