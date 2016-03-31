//
//  SelectBtn.m
//  WeNote
//
//  Created by WangPan on 16/3/31.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "SelectBtn.h"
@interface SelectBtn()
@property (nonatomic, strong) NSMutableArray * btnArr;
@end
@implementation SelectBtn
-(instancetype)init{
    self = [super init];
    if (self) {
        self.itemsArr = [NSArray array];
        self.nomPicArr = [NSArray array];
        self.heiPicArr = [NSArray array];
        self.selectPicArr = [NSArray array];
        self.indexSelect = 0;
        self.btnArr = [NSMutableArray array];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    for (int i = 0; i < self.itemsArr.count; i ++) {
        UIButton * itemBtn = [UIButton new];
        itemBtn.tag = i + 1000;
        if (i == self.indexSelect) {
            itemBtn.selected = YES;
        }else{
            itemBtn.selected = NO;
        }
        [itemBtn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        
        [itemBtn setImage:self.nomPicArr[i] forState:UIControlStateNormal];
        [itemBtn setImage:self.heiPicArr[i] forState:UIControlStateHighlighted];
        [itemBtn setImage:self.selectPicArr[i] forState:UIControlStateSelected];
        
        [itemBtn setTitle:self.itemsArr[i] forState:UIControlStateNormal];
        [itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(i * self.bounds.size.height / self.itemsArr.count);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
        }];
        [self.btnArr addObject:itemBtn];
    }
}

-(void)selectItem:(UIButton*)sender{
        sender.selected = YES;
    for (int i = 0; i < self.itemsArr.count; i++) {
        if (sender.tag - 1000 != i) {
            UIButton* btn  = self.btnArr[i];
            btn.selected = NO;
        }
    }
    self.selectCallback(sender.tag - 1000);
}
@end
