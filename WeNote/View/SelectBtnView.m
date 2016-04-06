//
//  SelectBtnView.m
//  WeNote
//
//  Created by WangPan on 16/3/31.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "SelectBtnView.h"
@interface SelectBtnView()
@property (nonatomic, strong) NSMutableArray * btnArr;
@end
@implementation SelectBtnView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemsArr = [NSArray array];
        self.nomPicNameArr = [NSArray array];
        self.heiPicNameArr = [NSArray array];
        self.selectPicNameArr = [NSArray array];
        self.btnArr = [NSMutableArray array];
        self.indexSelect = 0;
    }
    return self;
}


-(void)selectItem:(UIButton*)sender{
    sender.selected = YES;
    for (int i = 0; i < self.itemsArr.count; i++) {
        if (sender.tag - 1000 != i) {
            UIButton* btn  = self.btnArr[i];
            btn.selected = NO;
        }
    }
    self.selectCallback((int)sender.tag - 1000);
}


#pragma setters
-(void)setItemsArr:(NSArray *)itemsArr{
    
    CGFloat hei = self.bounds.size.height / self.itemsArr.count;
    
    for (int i = 0; i < self.itemsArr.count; i ++) {
        UIButton * itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, i * hei, self.bounds.size.width,  hei)];
        itemBtn.tag = i + 1000;
        if (i == self.indexSelect) {
            itemBtn.selected = YES;
        }else{
            itemBtn.selected = NO;
        }
        itemBtn.clipsToBounds = YES;
        [itemBtn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        
        [self.btnArr addObject:itemBtn];
    }
}

-(void)setNomPicNameArr:(NSArray *)nomPicNameArr{
    NSInteger count = nomPicNameArr.count >= self.itemsArr.count ? self.itemsArr.count : nomPicNameArr.count;
    for (int i = 0; i < count; i++) {
        UIButton * btn = self.btnArr[i];
        [btn setImage:[UIImage imageNamed:nomPicNameArr[i]] forState:UIControlStateNormal];
    }
}

-(void)setHeiPicNameArr:(NSArray *)heiPicNameArr{
    NSInteger count = heiPicNameArr.count >= self.itemsArr.count ? self.itemsArr.count : heiPicNameArr.count;
    for (int i = 0; i < count; i++) {
        UIButton * btn = self.btnArr[i];
        [btn setImage:[UIImage imageNamed:heiPicNameArr[i]] forState:UIControlStateHighlighted];
    }
}

-(void)setSelectPicNameArr:(NSArray *)selectPicNameArr{
    NSInteger count = selectPicNameArr.count >= self.itemsArr.count ? self.itemsArr.count : selectPicNameArr.count;
    for (int i = 0; i < count; i++) {
        UIButton * btn = self.btnArr[i];
        [btn setImage:[UIImage imageNamed:selectPicNameArr[i]] forState:UIControlStateSelected];
    }
}

-(void)setIndexSelect:(NSInteger)indexSelect{
    if (self.btnArr.count > indexSelect) {
        UIButton * btn = self.btnArr[indexSelect];
        btn.selected = YES;
    }
}
@end






