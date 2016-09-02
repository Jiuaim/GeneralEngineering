//
//  SZNetworkTool.h
//  General
//
//  Created by llbt on 16/9/2.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};


typedef void(^SZRequestSuccess)(id result);
typedef void(^SZRequestError)(NSError* error);

@interface SZNetworkTool : NSObject

+ (NetworkStates)getNetworkStates;

// GET直接请求
+ (void)getRequestWithString:(NSString *)string
                   onSuccess:(SZRequestSuccess)succBlck
                     onError:(SZRequestError)errorBlock;
// GET拼接服务器请求
+ (void)getRequestWithURL:(NSString*)url
                onSuccess:(SZRequestSuccess)succBlck
                  onError:(SZRequestError)errorBlock;
// POST拼接服务器请求
+ (void)postRequestWithURL:(NSString*)url
                 paramters:(id)paramters
                 onSuccess:(SZRequestSuccess)succBlck
                   onError:(SZRequestError)errorBlock;
// 上传图片请求
+ (void)postRequestWithURL:(NSString*)url
                     image:(NSArray*)imageArray
                       key:(NSString*)key
                 paramters:(id)paramters
                 onSuccess:(SZRequestSuccess)succBlck
                   onError:(SZRequestError)errorBlock;

@end
