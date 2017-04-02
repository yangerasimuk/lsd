//
//  YGConfig.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGConfig.h"
#import "defineConstants.h"

@interface YGConfig(){
    NSMutableDictionary *_dictionary;
}
@end

@implementation YGConfig

/** 
 Base init for config. If config exists func load options in inner dictionary.
 
    - return: YGOptions instance.
 */
- (instancetype)init{
    self = [super init];
    if(self){
        _fileName = [YGConfig fileNameByDefault];
        if([YGConfig isExists])
            _dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:_fileName];
        else
            _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/**
 Config singleton.
 
    - return: single instance of YGConfig.
 */
+ (YGConfig *)sharedInstance{
    static YGConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[YGConfig alloc] init];
    });
    return config;
}

/**
 Get default file name for config.
 
    - return: full name for config.
 */
+ (NSString *)fileNameByDefault{
    return [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), kLsdConfigName];
}

/**
 Get value for given key.
 
    - key: key for search in dictionary,
 
    - return: string of value.
 */
- (NSString *)valueForKey:(NSString *)key{
    return [NSString stringWithFormat:@"%@", _dictionary[key]];
}

/**
 Set given value for given key. Set in inner dictinary and extern config file.
 
    - value: string of value for setting,
 
    - key: string of key in option.
 */
- (void) setValue:(NSString *)value forKey:(NSString *)key{
    [_dictionary setValue:value forKey:key];
    [_dictionary writeToFile:[YGConfig fileNameByDefault] atomically:YES];
}

/**
 Check of config file existens.
 
    - return: exists or not.
 */
+ (BOOL)isExists{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if([fm fileExistsAtPath:[YGConfig fileNameByDefault]])
        return YES;
    else
        return NO;
}

@end
