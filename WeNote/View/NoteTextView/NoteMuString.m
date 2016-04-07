//
//  NoteMurString.m
//  WeNote
//
//  Created by WangPan on 16/4/6.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "NoteMuString.h"

@implementation NoteMuString
-(instancetype)init{
    self = [super init];
    if (self) {
        self.mas = [NSMutableString new];
    }
    return self;
}

-(NSUInteger)length{
    return self.mas.length;
}

-(unichar)characterAtIndex:(NSUInteger)index{
    return [self.mas characterAtIndex:index];
}

-(void)getCharacters:(unichar *)buffer range:(NSRange)range{
    [self.mas getCharacters:buffer range:range];
}

-(void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString{
    [self.mas replaceCharactersInRange:range withString:aString];
}

@end
