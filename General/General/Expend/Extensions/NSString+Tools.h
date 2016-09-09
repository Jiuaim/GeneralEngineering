//
//  NSString+Tools.h
//  General
//
//  Created by llbt on 16/9/6.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)
+ (NSString *)cachesPathString;

//
+ (NSString *)generateAbsoluteURL:(NSString *)url params:(id)params;
@end
