//
//  KeyChain.m
//  KeyChain
//
//  Created by cnmobi on 2017/3/20.
//  Copyright © 2017年 cnmobi. All rights reserved.
//

#import "GJyKeyChain.h"
#import "Const.h"
#import "LoginManager.h"

@implementation GJyKeyChain

#pragma mark - Custom API

+ (void)updateKeyChain {

    NSMutableDictionary *keyChainDic = [NSMutableDictionary dictionary];
    [keyChainDic setObject:GJy.user_name forKey:KEY_UserName];
    [keyChainDic setObject:GJy.token forKey:KEY_Token];
    NSLog(@"%@", keyChainDic);
    
    [GJyKeyChain save:KEY_KeyChainKey data:keyChainDic];
}

+ (void)deleteKeyChain {

    [GJyKeyChain delete:KEY_KeyChainKey];

    NSLog(@"username = %@ && token = %@", GJy.user_name, GJy.token);
}

+ (void)InfoOfKeyChain:(void(^)(NSString *token,NSString *userName))KeyChainBlock withNull:(void(^)(BOOL isNull))error {
    
    NSMutableDictionary *keyChainDic = (NSMutableDictionary *)[GJyKeyChain load:KEY_KeyChainKey];
    NSString *userName = [keyChainDic objectForKey:KEY_UserName];
    NSString *token = [keyChainDic objectForKey:KEY_Token];
    
    
    if (userName && token) {
        
        KeyChainBlock(token,userName);
    } else {
        
        BOOL isNil = 1;
        error(isNil);
    }
}


#pragma mark - Root API
/**
 取钥匙串
 */
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            
            (id)kSecClassGenericPassword,
            (id)kSecClass,
            service,
            (id)kSecAttrService,
            service,
            (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,
            (id)kSecAttrAccessible,
            nil];
}

/**
 保存内容
 */
+ (void)save:(NSString *)service data:(id)data {
    
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

/**
 加载内容
 */
+ (id)load:(NSString *)service {
    
    id ret = nil;
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
            
        }
    }
    
    if (keyData) {
        
        CFRelease(keyData);
    }
    
    return ret;
}

/**
 删除内容
 */
+ (void)delete:(NSString *)service {
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];

    SecItemDelete((CFDictionaryRef)keychainQuery);
}


@end


