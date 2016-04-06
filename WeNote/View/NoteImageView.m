//
//  NoteImageView.m
//  WeNote
//
//  Created by WangPan on 16/4/5.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "NoteImageView.h"
@interface NoteImageView()
@property (nonatomic, strong) UIView * scaleView;
@property (nonatomic, strong) UIView * rotationView;
@end
@implementation NoteImageView
-(instancetype)initWithFrame:(CGRect)frame andImage:(UIImage*)image{
    self = [super init];
    if (self) {
        self.isEditting = YES;
        [self createScaleItem];
    }
    return self;
}

-(void)createScaleItem{

}
-(void)layoutSubviews{
    
}
-(void)drawRect:(CGRect)rect{
    
    
}
@end
