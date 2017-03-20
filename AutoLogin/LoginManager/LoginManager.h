//
//  LoginManager.h
//  IvarList
//
//  Created by cnmobi on 2017/3/10.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface LoginManager : NSObject

@property (nonatomic) User *user;

+ (instancetype)shareManager;

@end
