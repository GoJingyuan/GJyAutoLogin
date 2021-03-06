//
//  LoginManager.m
//  IvarList
//
//  Created by cnmobi on 2017/3/10.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

static LoginManager *manager = nil;

#pragma mark - 防错处理与加载信息
+ (BOOL)couldLoginWithCache {
    
    [GJyKeyChain InfoOfKeyChain:^(NSString *token, NSString *userName) {
        
    } withNull:^(BOOL isNull) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:UserInfoMark] isKindOfClass:[NSDictionary class]]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:UserInfoMark];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    
    return [LoginManager shareManager].user.isLogin;
}


#pragma mark - 单例唯一性
//创建单例
+ (instancetype)shareManager {

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
        
        if (!manager.user) {
        
            manager.user = [[User alloc] init];
            
            __weak typeof (manager) weakManager = manager;
            
            [GJyKeyChain InfoOfKeyChain:^(NSString *token, NSString *userName) {
               
                weakManager.user.token = token;
                weakManager.user.user_name = userName;

            } withNull:^(BOOL isNull) {
                
                NSLog(@"钥匙串为空");
            }];
        }
    });

    return manager;
}


//覆盖该方法主要确保当用户通过[[Singleton alloc] init]创建对象时对象的唯一性，alloc方法会调用该方法，只不过zone参数默认为nil，因该类覆盖了allocWithZone方法，所以只能通过其父类分配内存，即[super allocWithZone:zone]
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [super allocWithZone:zone];
        if (!manager.user) {
            
            manager.user = [[User alloc] init];
            
            __weak typeof (manager) weakManager = manager;
            
            [GJyKeyChain InfoOfKeyChain:^(NSString *token, NSString *userName) {
                
                weakManager.user.token = token;
                weakManager.user.user_name = userName;
                
            } withNull:^(BOOL isNull) {
                
                NSLog(@"钥匙串为空");
            }];
        }
    });
    
    return manager;
}

//覆盖该方法主要确保当用户通过copy方法产生对象时对象的唯一性
- (id)copy {
    
    return self;
}

//覆盖该方法主要确保当用户通过mutableCopy方法产生对象时对象的唯一性
- (id)mutableCopy {
    
    return self;
}


@end
