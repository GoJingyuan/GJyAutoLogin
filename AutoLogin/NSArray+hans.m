//
//  NSArray+hans.m
//  NSArray_description
//
//  Created by 郭景元 on 15/11/7.
//  Copyright © 2015年 郭景元. All rights reserved.
//

#import "NSArray+hans.h"

@implementation NSArray (hans)

- (NSString *)descriptionWithLocale:(id)locale;
{
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendFormat:@"(\r\n"];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@\r\n",obj];
    }
    
    [str appendFormat:@")"];

    return str.copy;
}

@end


@implementation NSDictionary (hans)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    [str appendFormat:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendFormat:@"\t%@ = %@\n",key,obj];
    }];

    [str appendFormat:@"}"];
    return str.copy;
}

@end






