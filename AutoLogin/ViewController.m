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
#import "Const.h"
#import "GJyKeyChain.h"


@interface ViewController ()

@end

@implementation ViewController

#pragma mark - 登录
- (IBAction)LoginBtn:(id)sender {
    
    NSDictionary *serviceBackDic = @{
                                     @"token":@"2016_07_14",
                                     @"id":@"CM_229",
                                     @"user_name":@"GuoJingyuan",
                                     @"phone":@"186xxxx9195",
                                     @"oneself_code":[NSNull null],
                                     @"test_key":@"test_value",
                                     @"sex":@(1)
                                     };

    User *user = [[User alloc] init];
    
    [user initWithDict:serviceBackDic];
    
    GJy = user;

    NSLog(@"重置属性 : \n%@\n%@\n%@\n%@\n%td",GJy.token,GJy.ID,GJy.user_name,GJy.phone,GJy.sex);
}

#pragma mark - 编辑
- (IBAction)EditBtn:(id)sender {
    
    if (GJy.isLogin) {
        
        GJy.phone = @"459213xxx";
        
        GJy.ID = @"T_4";
        
        GJy.user_name = @"GJy";
        
        GJy.token = @"HeiHeiHei";
        
        GJy.sex = 0;
        
        NSLog(@"修改 : \ntoken:%@\nID:%@\nuser_name:%@\nphone:%@\nsex:%td",GJy.token,GJy.ID,GJy.user_name,GJy.phone,GJy.sex);
        
        //token改变或修改账号/密码时立即调用
        [GJyKeyChain updateKeyChain];
        
        //已在Appdelegate中设置存储,请根据需求决定是否手动调用updateUserInfo
        [GJy updateUserInfo];

    } else {
        
        NSLog(@"用户未登录");
    }
}

#pragma mark - 退出
- (IBAction)logout:(id)sender {
    
    [GJy logout];
    
    NSLog(@"退出成功");
}

#pragma mark - 输出
- (IBAction)LogBtn:(id)sender {
    
    NSLog(@"输出 : \ntoken:%@\nID:%@\nuser_name:%@\nphone:%@\nsex:%td",GJy.token,GJy.ID,GJy.user_name,GJy.phone,GJy.sex);
}

#pragma mark - ViewLife
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"启动App : \ntoken:%@\nID:%@\nuser_name:%@\nphone:%@\nsex:%td",GJy.token,GJy.ID,GJy.user_name,GJy.phone,GJy.sex);
    
    
    NSLog(@"path : %@",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]);

}

#pragma mark - RAM
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
