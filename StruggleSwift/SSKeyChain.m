//
//  SSKeyChain.m
//  StruggleSwift
//
//  Created by 黄刚 on 2017/12/24.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import "SSKeyChain.h"
#import <Security/Security.h>

@implementation SSKeyChain

//通过service这一个参数就和keychainitemwrapper里面提前预设了参数一样，把kSecAttrAccount和kSecAttrService直接用service一个参数设定了，然后把访问类型也预置了。
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
//    初始化4个键值对的字典
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
    
}

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
//    读数据
+ (id)load:(NSString *)service {
    
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
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
    if (keyData)
        CFRelease(keyData);
    return ret;
    
}

@end
