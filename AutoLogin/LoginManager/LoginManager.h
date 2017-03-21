//
//  LoginManager.h
//  IvarList
//
//  Created by cnmobi on 2017/3/10.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "GJyKeyChain.h"

@interface LoginManager : NSObject

/**
 1.防错处理
 2.载入信息
 */
+ (BOOL)isLoginWithCache;

/**
 单例
 */
+ (instancetype)shareManager;

/**
 用户信息
 */
@property (nonatomic) User *user;


@end
