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
    //YGFileName *_fileName;
    //NSString *_fileName;
    NSMutableDictionary *_dictionary;
}
@end

@implementation YGConfig

- (instancetype)init{
    self = [super init];
    if(self){
        _fileName = [YGConfig fileNameByDefault];
        //_dictionary = [[NSDictionary alloc] initWithContentsOfFile:_fileName.fullName];
        if([YGConfig isExists])
            _dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:_fileName];
        else
            _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (YGConfig *)sharedInstance{
    static YGConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[YGConfig alloc] init];
    });
    return config;
}

- (NSString *)valueForKey:(NSString *)key{
    return [NSString stringWithFormat:@"%@", _dictionary[key]];
}

- (void) setValue:(NSString *)value forKey:(NSString *)key{
    [_dictionary setValue:value forKey:key];
    [_dictionary writeToFile:[YGConfig fileNameByDefault] atomically:YES];
}


+ (NSString *)fileNameByDefault{
    return [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), kLsdConfigName];
}

+ (BOOL)isExists{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if([fm fileExistsAtPath:[YGConfig fileNameByDefault]])
        return YES;
    else
        return NO;
}

@end
