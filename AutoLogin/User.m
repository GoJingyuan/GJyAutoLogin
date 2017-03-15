//
//  User.m
//  IvarList
//
//  Created by cnmobi on 2017/3/10.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import "User.h"
#import <objc/runtime.h>
#import "LoginManager.h"

@implementation User 

static NSString *const UserInfoMark = @"UserInfoMark";

#pragma mark - 判断是否登录

- (BOOL)isLogin {
    
    return self.token != nil;
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
        
        [self updateUserInfo];
    }
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
}

/**
 忽略后台所给的用不到的的属性
 */
- (NSArray *)ignorePropertyArray {
  
    return @[@"_ignore1",@"_ignore2",@"_ignore3"];  //return nil;
}

#pragma mark - 退出登录清空用户信息
- (void)logout {

    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:UserInfoMark];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [LoginManager shareManager].user = [[User alloc] init];
}


@end
