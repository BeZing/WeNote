//
//  MainViewController.m
//  WeNote
//
//  Created by WangPan on 16/3/28.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "MainViewController.h"
#import "LimitTextView.h"
#import "SelectBtnView.h"
#import "ToolItemView.h"
#import "NoteTextView.h"

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
    [self createToolItems];
}

-(void)createToolItems{
    ToolItemView * tv  = [[ToolItemView alloc] initWithFrame:CGRectMake(SVWidth - 60, SVHeight / 2 - 60, 60, 160) andItems:@[@"1",@"2"]];
//    tv.backgroundColor = [UIColor orangeColor];
    UIImage * img1 = [UIImage imageNamed:@"btn.png"];
    UIImage * img2 = [UIImage imageNamed:@"btn.png"];
    tv.nomPicArr = @[img1,img2];
    tv.clickback = ^(NSString * item){
        if ([item isEqualToString:@"1"]) {
            NoteTextView * ntv = [[NoteTextView alloc] initWithFrame:CGRectMake(0, 0, SVWidth, SVHeight)];
            ntv.textString = [NSMutableString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"moon" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
            ntv.imageArr = @[img1,img2];
            ntv.imgFrameArr = @[[NSValue valueWithCGRect:CGRectMake(20, 20, 30, 30)],[NSValue valueWithCGRect:CGRectMake(100, 140, 34, 45)]];
            [self.view addSubview:ntv];
        }
    };
    [self.view addSubview:tv];
}

-(void)getNoteInfo{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"仰望星空的猫头鹰先生" forKey:NOTE_TITLE_KEY];
    [ud setObject:@"没有看门狗的城市，狐狸就是守护者。" forKey:NOTE_ADMO_KEY];
    [ud setObject:@"2016" forKey:NOTE_TAG_KEY];
    [ud setObject:@"owl" forKey:NOTE_USER_KEY];
    [ud synchronize];
    _textArr = @[[ud objectForKey:NOTE_TITLE_KEY],[ud objectForKey:NOTE_ADMO_KEY],[ud  objectForKey:NOTE_TAG_KEY],[ud objectForKey:NOTE_USER_KEY]];
    _fontArr = @[[UIFont systemFontOfSize:20],[UIFont systemFontOfSize:14],[UIFont systemFontOfSize:16],[UIFont systemFontOfSize:16]];
    _lentArr = @[@"16",@"60",@"8",@"8"];
}

-(void)createNoteTitle{
//    NSString * titString = [];
    //iphone name " "前，如果长，空格后。如果还是长，默认@"xxxxx";
    for (int i = 0; i < _textArr.count; i ++) {
        LimitTextView * titText = [LimitTextView new];
        titText.limitLenth = [_lentArr[i] intValue];
        titText.text = _textArr[i];
        titText.font = _fontArr[i];
        titText.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:titText];
        __block NSString * infoKey;
        [titText mas_makeConstraints:^(MASConstraintMaker *make) {
            switch (i) {
                case 0:
                    make.size.mas_equalTo(CGSizeMake(SVWidth - 80, 88));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.top.equalTo(self.view).with.offset(100);
                    infoKey = NOTE_TITLE_KEY;
                    break;
                case 1:
                    make.size.mas_equalTo(CGSizeMake(SVWidth - 40, 88));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.top.equalTo(self.view).with.offset(200);
                    infoKey = NOTE_ADMO_KEY;

                    break;
                case 2:
                    make.size.mas_equalTo(CGSizeMake(SVWidth - 200, 40));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.bottom.equalTo(self.view).with.offset(-100);
                    infoKey = NOTE_TAG_KEY;
                    titText.bomLineColor = [UIColor lightGrayColor];

                    break;
                case 3:
                    make.size.mas_equalTo(CGSizeMake(SVWidth - 200, 40));
                    make.centerX.equalTo(self.view.mas_centerX);
                    make.bottom.equalTo(self.view).with.offset(-40);
                    infoKey = NOTE_USER_KEY;
                    titText.bomLineColor = [UIColor lightGrayColor];

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
