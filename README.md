# AutoLogin

## 该项目为使用Runtime和KVC制作的简易自动登录模块,将User中的属性替换为你项目中的属性即可使用
LoginManager为项目单例,User为用户模型

### - (BOOL)isLogin;
请在程序启动时在Appdelegate中调用判断是否登录,根据是否设置了游客模式切换根控制器
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([LoginManager shareManager].user.isLogin) {
        
        NSLog(@"已登录");
    } else {
        
        NSLog(@"未登录");
    }
    
    return YES;
}

### - (void)initWithDict:(id)dict;
在登录成功后,将服务器json数据传入,其他情况下请勿调用

### - (void)updateUserInfo;
每次修改用户数据后均需调用,更新用户信息

### - (void)logout;
退出登录,清空用户信息

### - (NSArray *)ignorePropertyArray;
可在内部手动添加需要忽略的属性


## Tips:
字典转模型使用了KVC,如果需要嵌套模型或复杂数据类型,请参考使用MJExtension或其他框架的字典转模型技术.
