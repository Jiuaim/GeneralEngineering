//
//  SZNetworkTool.m
//  General
//
//  Created by llbt on 16/9/2.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZNetworkTool.h"
#import <MJExtension.h>

@implementation SZNetworkTool

// 判断网络类型
+ (NetworkStates)getNetworkStates {
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    break;
                case 1:
                    states = NetworkStates2G;
                    break;
                case 2:
                    states = NetworkStates3G;
                    break;
                case 3:
                    states = NetworkStates4G;
                    break;
                case 5:
                    states = NetworkStatesWIFI;
                    break;
                default:
                    break;
            }
        }
    }
    return states;
}


+ (void)getRequestWithURL:(NSString *)url onSuccess:(SZRequestSuccess)succBlck onError:(SZRequestError)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succBlck(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

+ (void)getRequestWithString:(NSString *)string onSuccess:(SZRequestSuccess)succBlck onError:(SZRequestError)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:string parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succBlck(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

+ (void)postRequestWithURL:(NSString *)url paramters:(id)paramters onSuccess:(SZRequestSuccess)succBlck onError:(SZRequestError)errorBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/plain",@"text/html",nil];
    manager.responseSerializer = [ AFHTTPResponseSerializer serializer ];
    
    [manager POST:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succBlck(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
    
}

+(void)postRequestWithURL:(NSString *)url image:(NSArray *)imageArray key:(NSString *)key paramters:(id)paramters onSuccess:(SZRequestSuccess)succBlck onError:(SZRequestError)errorBlock {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < imageArray.count; i++) {
        NSData *data = UIImageJPEGRepresentation([imageArray objectAtIndex:i], 0.01);
        [array addObject:data];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",SeverHost,url] parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageArray.count; i++) {
            [formData appendPartWithFileData:array[i]  name:key fileName:[NSString stringWithFormat:@"%d.jpeg",i] mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succBlck(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
