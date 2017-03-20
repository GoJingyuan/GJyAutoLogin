//
//  KeyChain.h
//  KeyChain
//
//  Created by cnmobi on 2017/3/20.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

//KeyChain工具,使用前需依赖Security.framework和<Security/Security.h>
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface GJyKeyChain : NSObject

#pragma mark - Custom API

/**
 保存用户名和Token
 */
+ (void)updateKeyChain;

/**
 删除用户名和Token
 */
+ (void)deleteKeyChain;

/**
 返回token和userName,仅在单例初始化时调用
 */
+ (void)singleInstanceWithKeyChain:(void(^)(NSString *token,NSString *userName))KeyChainBlock withNull:(void(^)(BOOL isNull))error;


@end
