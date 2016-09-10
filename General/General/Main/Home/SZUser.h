//
//  SZUser.h
//  General
//
//  Created by llbt on 16/9/9.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZNetworkTool.h"

@interface SZUser : NSObject

/** 直播地址 */
@property (nonatomic, copy  ) NSString   *flv;
/** 昵称 */
@property (nonatomic, copy  ) NSString   *nickname;
/** 照片地址 */
@property (nonatomic, copy  ) NSString   *photo;
/** 所在地区 */
@property (nonatomic, copy  ) NSString   *position;
/** 房间号 */
@property (nonatomic, copy  ) NSString   *roomid;
/** 用户id */
@property (nonatomic, copy  ) NSString   *useridx;
/** 是否是新人 */
@property (nonatomic, assign) NSUInteger newStar;
/** 服务器号 */
@property (nonatomic, assign) NSUInteger serverid;
/** 性别 */
@property (nonatomic, assign) NSUInteger sex;
/** 等级 */
@property (nonatomic, assign) NSUInteger starlevel;

@end
