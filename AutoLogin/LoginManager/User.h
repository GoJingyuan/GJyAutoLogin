//
//  User.h
//  IvarList
//
//  Created by cnmobi on 2017/3/10.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

//用户资料模型
#import <Foundation/Foundation.h>
#import "Const.h"

@interface User : NSObject

#pragma mark - API
/**
 判断当前登录状态
 */
- (BOOL)isLogin;

/**
 手动登录成功后调用此方法保存用户信息,其他情况请勿调用
 */
- (void)initWithDict:(id)dict;

/**
 修改后用户信息后调用,保存用户最新资料
 */
- (void)updateUserInfo;

/**
 退出登录,清空用户信息
 */
- (void)logout;


#pragma mark - Property (请根据不同项目自行替换)

@property (nonatomic,copy)      NSString *token;          //登录获取
@property (nonatomic,copy)      NSString *user_name;      //昵称
@property (nonatomic,copy)      NSString *ID;             //用户名id
@property (nonatomic,copy)      NSString *phone;          //手机号码
@property (nonatomic,copy)      NSString *head_photo;     //头像地址
@property (nonatomic,assign)    double balance;           //余额
@property (nonatomic,copy)      NSString *birthday;       //生日
@property (nonatomic,assign)    NSInteger sex;            //性别
@property (nonatomic,assign)    NSInteger rank_integral;  //积分
@property (nonatomic,assign)    NSInteger rank_id;        //积分等级
@property (nonatomic,copy)      NSString *pay_integral;   //积分
@property (nonatomic,copy)      NSString *easemob_id;     //环信账号
@property (nonatomic,copy)      NSString *oneself_code;   //本人推荐码
@property (nonatomic,copy)      NSString *referral_code;  //推荐人邀请码
@property (nonatomic,copy)      NSString *child_id;       //小孩id
@property (nonatomic,assign)    BOOL is_payword;          //是否设置了支付密码
@property (nonatomic,copy)      NSString *pay_salt;       //加密字符串
@property (nonatomic,copy)      NSString *openId;         //第三方登录ID


@end
