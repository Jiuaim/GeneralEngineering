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

typedef NS_ENUM(NSInteger, NetworkRequestType) {
    NetworkRequestTypeGET,  // GET请求
    NetworkRequestTypePOST,  // POST请求
};

typedef void(^SZRequestSuccess)(id result);
typedef void(^SZRequestError)(NSError *error);
typedef void(^SZRequestProgress)(CGFloat writeKB, CGFloat totalKB);

@interface SZNetworkTool : NSObject

+ (NetworkStates)getNetworkStates;


+ (void)getNetworkRequestWithUrlString:(NSString *)urlString params:(id)params succeed:(SZRequestSuccess)succeed error:(SZRequestError)error;


+ (void)postNetworkRequestWithUrlString:(NSString *)urlString params:(id)params succeed:(SZRequestSuccess)succeed error:(SZRequestError)error;


+ (void)uploadWithurlString:(NSString *)urlString params:(id)params image:(UIImage *)image progress:(SZRequestProgress)progress succeed:(SZRequestSuccess)succeed fail:(SZRequestError)err;


@end
