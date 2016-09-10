//
//  SZHotCollectionViewCell.h
//  General
//
//  Created by llbt on 16/9/9.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZUser.h"

@interface SZHotCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) SZUser *user;
@property (nonatomic, strong) UIImageView *bgImage;
@end
