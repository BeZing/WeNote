//
//  NetWork.m
//  WeNote
//
//  Created by WangPan on 16/3/29.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"
@implementation NetWork
static NetWork * manager = nil;

+(instancetype)shareManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self allocWithZone:NULL] init];
        
    });
    return manager;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}


-(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^) (id responsed))sucess failure:(void (^)(NSError * error))failure{
    AFHTTPSessionManager * asManager = [AFHTTPSessionManager manager];
    [asManager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        if (failure) {
            ErrLog(@"%@",error);
            failure(error);
        }
    }];
}

@end
