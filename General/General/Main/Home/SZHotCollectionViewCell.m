//
//  SZHotCollectionViewCell.m
//  General
//
//  Created by llbt on 16/9/9.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZHotCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation SZHotCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 4) / 3.0, 100)];
        [self.contentView addSubview:self.bgImage];
    }
    return self;
}

- (void)setUser:(SZUser *)user {
    _user = user;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:_user.photo]];
}
@end
