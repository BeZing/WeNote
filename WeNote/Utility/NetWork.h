//
//  NetWork.h
//  WeNote
//
//  Created by WangPan on 16/3/29.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject
+(instancetype)shareManager;
-(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^) (id responsed))sucess failure:(void (^)(NSError * error))failure;
@end
