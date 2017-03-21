# AutoLogin

该项目为使用Runtime和KVC制作的简易自动登录模块,将User中的属性替换为你项目中的属性即可使用

字典-->模型使用了KVC,如果需要嵌套模型或复杂数据类型,请参考使用MJExtension或其他框架.



## Guide : LoginManager为程序单例,User为用户模型,GJyKeyChain为钥匙串



## API介绍:


### A、LoginManager.h

#### + (instancetype)shareManager;
程序单例

#### + (BOOL)couldLoginWithCache;
是否存在可用的用户缓存


### B、User.h

#### - (BOOL)isLogin;
判断用户是否登录

#### - (void)initWithDict:(id)dict;
在登录成功后将后台返回的json数据传入,其他情况下请勿调用

#### - (void)updateUserInfo;
写入硬盘最新的用户信息

#### - (void)logout;
退出登录,清空用户信息

#### - (NSArray *)ignorePropertyArray;
可在内部手动添加需要忽略的属性


### C、GJyKeyChain.h

#### + (void)updateKeyChain;
写入钥匙串信息

#### + (void)deleteKeyChain;
删除钥匙串信息

#### + (void)InfoOfKeyChain:(void(^)(NSString *token,NSString *userName))KeyChainBlock withNull:(void(^)(BOOL isNull))error;
返回自定义的钥匙串信息


