//
//  MainViewController.m
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "MainViewController.h"
#import "LimitTextView.h"

@interface MainViewController()
@property (nonatomic, strong) NSArray * textArr;
@property (nonatomic, strong) NSArray * fontArr;
@property (nonatomic, strong) NSArray * lentArr;
@property (nonatomic, strong) NSMutableArray * infoArr;
@end
@implementation MainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getNoteInfo];
    [self createNoteTitle];
}

-(void)getNoteInfo{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"仰望星空的猫头鹰先生的记事本" forKey:NOTE_TITLE_KEY];
    [ud setObject:@"没有看门狗的城市，狐狸就是守护者。" forKey:NOTE_ADMO_KEY];
    [ud setObject:@"2016" forKey:NOTE_TAG_KEY];
    [ud setObject:@"owl" forKey:NOTE_USER_KEY];
    [ud synchronize];
    _textArr = @[[ud objectForKey:NOTE_TITLE_KEY],[ud objectForKey:NOTE_ADMO_KEY],[ud  objectForKey:NOTE_TAG_KEY],[ud objectForKey:NOTE_USER_KEY]];
    _fontArr = @[[UIFont systemFontOfSize:20],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:16]];
    _lentArr = @[@"16",@"30",@"7",@"7"];
}

-(void)createNoteTitle{
//    NSString * titString = [];
    //iphone name " "前，如果长，空格后。如果还是长，默认@"xxxxx";
    for (int i = 0; i < _textArr.count; i ++) {
        LimitTextView * titText = [[LimitTextView alloc] initWithString:_textArr[i] andFont:_fontArr[i]];
        titText.limitLenth = [_lentArr[i] intValue];
        [self.view addSubview:titText];
        __block NSString * infoKey;
        [titText mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (i) {
                case 0:
                    make.size.mas_equalTo(CGSizeMake(SelfWidth - 80, 88));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.top.equalTo(self.view).with.offset(100);
                    infoKey = NOTE_TITLE_KEY;
                    break;
                case 1:
                    make.size.mas_equalTo(CGSizeMake(SelfWidth - 60, 88));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.top.equalTo(self.view).with.offset(200);
                    
                    infoKey = NOTE_ADMO_KEY;

                    break;
                case 2:
                    make.size.mas_equalTo(CGSizeMake(SelfWidth - 100, 40));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.bottom.equalTo(self.view).with.offset(-100);
                    infoKey = NOTE_TAG_KEY;

                    break;
                case 3:
                    make.size.mas_equalTo(CGSizeMake(SelfWidth - 100, 40));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.bottom.equalTo(self.view).with.offset(-40);
                    infoKey = NOTE_USER_KEY;

                    break;
                default:
                    break;
            }
        }];
        titText.editCallback = ^(NSString* info){
            [self setInfomation:info ByKey:infoKey];
        };
    }
}


-(void)setInfomation:(NSString*)info ByKey:(NSString*)key{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:info forKey:key];
    [ud synchronize];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
