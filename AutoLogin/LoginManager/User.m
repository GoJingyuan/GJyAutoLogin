//
//  User.m
//  IvarList
//
//  Created by cnmobi on 2017/3/10.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import "LoginManager.h"
#import <objc/runtime.h>
#import "GJyKeyChain.h"

@implementation User 

#pragma mark - 判断是否登录
- (BOOL)isLogin {
    
    //卸载App不会影响钥匙串,不能仅从token出是否登录
    return self.token && self.ID;
}


#pragma mark - 初始化用户信息
- (id)init {
    
    if (self = [super init]) {
        
        [self loadUserDataFromCache];
    }
    return self;
}

- (void)loadUserDataFromCache {
    
    id dict = [[NSUserDefaults standardUserDefaults] objectForKey:UserInfoMark];
    
    if ([dict isKindOfClass:[NSDictionary class]]) {

        [self initWithDict:dict];
    } else {
        
        return;
    }
}

- (void)initWithDict:(id)dict {
    
    /*
     1.使用KVC的字典转模型,无法转移模型中嵌套的模型
     2.如需对接复杂的登录模型,可以参考MJExtension框架下的字典转模型mj_setKeyValues
     */
    [self setValuesForKeysWithDictionary:dict];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoMark] isKindOfClass:[NSDictionary class]]) {
        //当账号密码登录时执行以下代码
        [self updateUserInfo];
    }

    
//    /*
//     NSUserDefaults写入文件需要时间,在某种情况下可能会造成写入失败,
//     故不再使用UserInfoMark的类型来区分登录类型(自动登录或账号密码登录)
//     
//     if (![[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoMark] isKindOfClass:[NSDictionary class]]) {
//         //当账号密码登录时执行以下代码
//         [self updateUserInfo];
//     }
//     */
//    if (self.isLogin) {
//        [self updateUserInfo];
//    }
}


#pragma mark - KVC字典转模型, 筛选或修改字段
-(void)setValue:(id)value forKey:(NSString *)key {

    //公司后台返回均是id，请根据需要修改
    if ([key isEqualToString:@"id"]) {
        
        [super setValue:value forKey:@"ID"];
    } else {
    
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    //此方法必须重写,找不到的Key不做处理就好了
    NSLog(@"%s\n当前模型中未检索到key\nkey = %@\nvalue = %@\n", __func__ , key, value);
}


#pragma mark - 更新用户信息
- (void)updateUserInfo {
    
        if (!self.token) {
            
            return;
        }
    
        unsigned int propertyCount;
        
        Ivar *ivars = class_copyIvarList([self class], &propertyCount);
        
        NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:5];
        
        for (int i = 0; i < propertyCount; i++) {
            
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            
            if (self.ignorePropertyArray && [self.ignorePropertyArray containsObject:key]) {
                
                continue;
            }
            
            [mArray addObject:key];
        }
        
        free(ivars);
        
        NSDictionary *userInfoDict = [self dictionaryWithValuesForKeys:mArray];
        
        NSMutableDictionary *mUserInfoDict = [userInfoDict mutableCopy];
        
        for (NSString *key in userInfoDict.allKeys) {
            
            id value = [self valueForKey:key];
            
            //NSLog(@"key : %@  value : %@  [value class] : %@",key,value,[value class]);
            
            if (!value) {
                
                 [mUserInfoDict removeObjectForKey:key];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:mUserInfoDict forKey:UserInfoMark];
    
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        NSLog(@"成功保存用户数据");
}

/**
 忽略不能存入NSUserDefaults的属性,如账号、密码、用户身份token等信息
 */
- (NSArray *)ignorePropertyArray {

    //return nil;
    
    return @[@"_token",@"_user_name"];
}

#pragma mark - 退出登录清空用户信息
- (void)logout {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:UserInfoMark];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [GJyKeyChain deleteKeyChain];
    
    [LoginManager shareManager].user = [[User alloc] init];
}


@end
