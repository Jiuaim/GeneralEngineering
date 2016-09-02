//
//  UIImageView+Category.m
//  General
//
//  Created by llbt on 16/9/1.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "UIImageView+Category.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (Category)

- (void)imageWithPath:(NSString *)path {
    UIImage *defaultImage = [UIImage imageNamed:@"default"];
    if ([path hasPrefix:@"http"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:path] placeholderImage:defaultImage];
    } else {
        self.image = defaultImage;
    }
}

@end
