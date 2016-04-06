//
//  ToolItemView.m
//  WeNote
//
//  Created by WangPan on 16/4/5.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "ToolItemView.h"
@interface ToolItemView()
@property (nonatomic, strong) NSMutableArray * btns;
@end

@implementation ToolItemView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSArray array];
        self.nomPicNameArr = [NSArray array];
        self.heiPicNameArr = [NSArray array];
        self.btns = [NSMutableArray array];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self createBtns];
}
-(void)createBtns{

}
-(void)click:(UIButton*)sender{
    self.clickback(sender.tag - 1000);
}

-(void)setItems:(NSArray *)items{
    CGFloat hei =  self.bounds.size.width + (self.bounds.size.height - self.items.count * self.bounds.size.width) / (self.items.count - 1);
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

-(void)setNomPicArr:(NSArray *)nomPicArr{
    NSInteger count = nomPicArr.count >= self.btns.count ? self.btns.count: nomPicArr.count;
    for (int i = 0; i < count; i ++) {
        UIButton * btn = self.btns[i];
        [btn setImage:[UIImage imageNamed:nomPicArr[i]] forState:UIControlStateNormal];
    }
}

-(void)setHeiPicNameArr:(NSArray *)heiPicNameArr{
    NSInteger count = heiPicNameArr.count >= self.btns.count ? self.btns.count : heiPicNameArr.count;
    for (int i = 0; i < count; i ++) {
        UIButton * btn = self.btns[i];
        [btn setImage:[UIImage imageNamed:heiPicNameArr[i]] forState:UIControlStateNormal];
    }
}
@end
