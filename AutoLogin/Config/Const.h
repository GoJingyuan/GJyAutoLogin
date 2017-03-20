//
//  Const.h
//  KeyChain
//
//  Created by cnmobi on 2017/3/20.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

//放在pch文件中, 做全局常量引用
#import <UIKit/UIKit.h>


#define GJy [LoginManager shareManager].user

/**
 UserInfoMark,登录标记,未登录 = "1",已登录 = (NSDictionary *)
 */
UIKIT_EXTERN NSString *const UserInfoMark;

/**
 KeyChainKey,使用该键操作钥匙串
 */
UIKIT_EXTERN NSString * const KEY_KeyChainKey;

/**
 用户名
 */
UIKIT_EXTERN NSString * const KEY_UserName;

/**
 密码
 */
UIKIT_EXTERN NSString * const KEY_Password;

/**
 账号Token
 */
UIKIT_EXTERN NSString * const KEY_Token;


