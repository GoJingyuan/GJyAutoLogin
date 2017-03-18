//
//  ViewController.m
//  AutoLogin
//
//  Created by cnmobi on 2017/3/14.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "LoginManager.h"
#import "User.h"

#define GJy [LoginManager shareManager].user

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)LoginBtn:(id)sender {
    
    NSDictionary *serviceBackDic = @{
                                     @"token":@"2016_07_14",
                                     @"id":@"CM_229",
                                     @"user_name":@"郭景元",
                                     @"phone":@"18639539195",
                                     @"oneself_code":[NSNull null],
                                     @"test_key":@"test_value",
                                     @"sex":@(0)
                                     };
    
    User *user = [[User alloc] init];
    
    [user initWithDict:serviceBackDic];
    
    GJy = user;
    
    NSLog(@"重置属性 : \n%@\n%@\n%@\n%@\n%td",GJy.token,GJy.ID,GJy.user_name,GJy.phone,GJy.sex);
}

- (IBAction)EditBtn:(id)sender {
    
    if (GJy.isLogin) {
        
        GJy.phone = @"459213641";
        
        GJy.ID = @"004";
        
        GJy.user_name = @"GJY";
        
        GJy.token = @"hehe";
        
        GJy.sex = 1;
        
        NSLog(@"修改 : \n%@\n%@\n%@\n%@\n%td",GJy.token,GJy.ID,GJy.user_name,GJy.phone,GJy.sex);
    } else {
        
        NSLog(@"用户未登录");
    }
}

- (IBAction)logout:(id)sender {
    
    [GJy logout];
    NSLog(@"成功退出");
}

- (IBAction)LogBtn:(id)sender {
    
    NSLog(@"输出 : \n%@\n%@\n%@\n%@\n%td",GJy.token,GJy.ID,GJy.user_name,GJy.phone,GJy.sex);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 测试代码:
 
 LoginManager *m1 = [[LoginManager alloc] init];
 
 LoginManager *m0 = [LoginManager shareManager];
 
 LoginManager *m2 = [[LoginManager alloc] init];
 
 LoginManager *m3 = [[LoginManager alloc] init];
 
 LoginManager *m4 = [m3 mutableCopy];
 
 LoginManager *m5 = [m3 mutableCopy];
 
 NSLog(@"\n%@\n%@\n%@\n%@\n%@\n%@",m0,m1,m2,m3,m4,m5);
 */


@end
