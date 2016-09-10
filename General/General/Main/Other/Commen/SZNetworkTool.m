//
//  SZNetworkTool.m
//  General
//
//  Created by llbt on 16/9/2.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZNetworkTool.h"
#import <MJExtension.h>

#define kTimeOut 20.0

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

+ (void)getNetworkRequestWithUrlString:(NSString *)urlString params:(id)params succeed:(SZRequestSuccess)succeed error:(SZRequestError)error {
    [self requestType:NetworkRequestTypeGET url:urlString params:params succeed:succeed error:error];
}

+ (void)postNetworkRequestWithUrlString:(NSString *)urlString params:(id)params succeed:(SZRequestSuccess)succeed error:(SZRequestError)error {
    [self requestType:NetworkRequestTypePOST url:urlString params:params succeed:succeed error:error];
}

+ (void)requestType:(NetworkRequestType)type url:(NSString *)url params:(id)params succeed:(SZRequestSuccess)succeed error:(SZRequestError)err {
    NSString *urlString = [url hasSuffix:@"http"] ? url: URLString(url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (type == NetworkRequestTypeGET) {
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            BLOCK_EXEC(succeed,dic);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            BLOCK_EXEC(err,error);
        }];
    } else {
        [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            BLOCK_EXEC(succeed,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            BLOCK_EXEC(err,error);
        }];
    }
}


+ (void)uploadWithurlString:(NSString *)urlString params:(id)params image:(UIImage *)image progress:(SZRequestProgress)progress succeed:(SZRequestSuccess)succeed fail:(SZRequestError)err {
    NSString *url = [urlString hasSuffix:@"http"] ? urlString: URLString(urlString);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        NSString *imageFileName;
        if (imageFileName == nil || imageFileName.length == 0) {
            imageFileName = @"default";
        }
        [formData appendPartWithFileData:imageData name:imageFileName fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat uploadKB = uploadProgress.completedUnitCount / 1024.0;
        CGFloat totalKB = uploadProgress.totalUnitCount / 1024.0;
        BLOCK_EXEC(progress,uploadKB,totalKB);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BLOCK_EXEC(succeed,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK_EXEC(err,error);
    }];
    
}

@end
