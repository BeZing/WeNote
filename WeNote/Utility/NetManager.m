//
//  NetManager.m
//  WeNote
//
//  Created by WangPan on 16/3/29.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import "NetManager.h"
#import "AFNetworking.h"
@implementation NetManager
static NetManager * manager = nil;

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


-(void)POST:(NSString *)URLString getJsonByParameters:(id)parameters
                        success:(void (^) (id responsed))sucess
                        failure:(void (^)(NSError * error))failure
{
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

-(void)POST:(NSString *)URLString uploadImageByParameters:(id)parameters
                        data:(NSData*)imageData
                        imgName:(NSString*)name
                        imgType:(NSString*)type
                        progress:(void(^)(NSProgress * uploadProgress))progress
                        success:(void (^) (id responsed))sucess
                        failure:(void (^)(NSError * error))failure
{
    AFHTTPSessionManager * asManger = [AFHTTPSessionManager manager];
    [asManger POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        NSString * fullName = [[name stringByAppendingString:@"."] stringByAppendingString:type] ;
        [formData appendPartWithFileData:imageData name:name fileName:fullName mimeType:[@"image/" stringByAppendingString:type]];
    } progress:^(NSProgress *  uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
