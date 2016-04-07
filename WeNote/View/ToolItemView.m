//
//  ToolItemView.m
//  WeNote
//
//  Created by WangPan on 16/4/5.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "ToolItemView.h"
@interface ToolItemView()
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) NSMutableArray * btns;
@end

@implementation ToolItemView
-(instancetype)initWithFrame:(CGRect)frame andItems:(NSArray*)items{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = items;
        self.btns = [NSMutableArray array];
        self.spaceHei = self.frame.size.width / 2;
        [self createTools];
    }
    return self;
}


-(void)click:(UIButton*)sender{
    self.clickback(self.items[sender.tag - 1000]);
}

#pragma setters
-(void)createTools{
    CGFloat hei =  self.bounds.size.width + self.spaceHei;
    for (int i = 0; i < self.items.count; i++) {
        UIButton * itemBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, i * hei, self.bounds.size.width, self.bounds.size.width)];
        itemBtn.tag = i + 1000;
        itemBtn.layer.cornerRadius = self.bounds.size.width / 2;
        itemBtn.clipsToBounds = YES;
        [itemBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        [self.btns addObject:itemBtn];
    }
}

-(void)setSpaceHei:(CGFloat)spaceHei{
    _spaceHei = spaceHei;
    if (self.btns.count > 0) {
        CGFloat hei =  self.bounds.size.width + _spaceHei;
        for (int i = 0;  i < self.btns.count; i ++) {
            UIButton * btn = self.btns[i];
            btn.frame = CGRectMake(0, i * hei, self.bounds.size.width, self.bounds.size.width);
        }
    }
}

-(void)setNomPicArr:(NSArray *)nomPicArr{
    _nomPicArr = nomPicArr;
    for (int i = 0; i < _nomPicArr.count; i ++) {
        UIButton * btn = self.btns[i];
        [btn setImage:_nomPicArr[i] forState:UIControlStateNormal];
    }
}

-(void)setHeiPicArr:(NSArray *)heiPicArr{
    _heiPicArr = heiPicArr;
    for (int i = 0; i < _heiPicArr.count; i ++) {
        UIButton * btn = self.btns[i];
        [btn setImage:_heiPicArr[i] forState:UIControlStateNormal];
    }
}
@end
