//
//  NetManager.h
//  WeNote
//
//  Created by WangPan on 16/3/29.
//  Copyright © 2016年 Wang Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+(instancetype)shareManager;
-(void)POST:(NSString *)URLString getJsonByParameters:(id)parameters
                        success:(void (^) (id responsed))sucess
                        failure:(void (^)(NSError * error))failure;

-(void)POST:(NSString *)URLString uploadImageByParameters:(id)parameters
                        data:(NSData*)imageData
                        imgName:(NSString*)name
                        imgType:(NSString*)type
                        progress:(void(^)(NSProgress * uploadProgress))progress
                        success:(void (^) (id responsed))sucess
                        failure:(void (^)(NSError * error))failure;
@end
