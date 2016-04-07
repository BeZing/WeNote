//
//  SelectBtnView.m
//  WeNote
//
//  Created by WangPan on 16/3/31.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "SelectBtnView.h"

@interface SelectBtnView()

@property (nonatomic, strong) NSArray * items;
@property (nonatomic, strong) NSMutableArray * btnArr;

@end


@implementation SelectBtnView
-(instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnArr = [NSMutableArray array];
        self.itemsArr = items;
        self.indexSelect = 0;
        [self createBtns];
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
    self.selectCallback(self.itemsArr[sender.tag - 1000]);
}


#pragma setters
-(void)createBtns{
    
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

-(void)setNomPicArr:(NSArray *)nomPicArr{
    _nomPicArr = nomPicArr;
    for (int i = 0; i < _nomPicArr.count; i++) {
        UIButton * btn = self.btnArr[i];
        [btn setImage:_nomPicArr[i] forState:UIControlStateNormal];
    }
}

-(void)setHeiPicArr:(NSArray *)heiPicArr{
    _heiPicArr = heiPicArr;
    for (int i = 0; i < _heiPicArr.count; i++) {
        UIButton * btn = self.btnArr[i];
        [btn setImage:_heiPicArr[i] forState:UIControlStateHighlighted];
    }
}

-(void)setSelectPicArr:(NSArray *)selectPicArr{
    _selectPicArr = selectPicArr;
    for (int i = 0; i < _selectPicArr.count; i++) {
        UIButton * btn = self.btnArr[i];
        [btn setImage:_selectPicArr[i] forState:UIControlStateSelected];
    }
}

-(void)setIndexSelect:(NSInteger)indexSelect{
    _indexSelect = indexSelect;
    if (self.btnArr.count > _indexSelect) {
        UIButton * btn = self.btnArr[_indexSelect];
        btn.selected = YES;
    }
}
@end






