//
//  YGConfig.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGConfig : NSObject

+ (BOOL) isExists;
+ (NSString *) fileNameByDefault;
+ (YGConfig *) sharedInstance;
- (NSString *) valueForKey:(NSString *)key;
- (void) setValue:(NSString *)value forKey:(NSString *)key;

/// Config file name
@property (readonly) NSString *fileName;

@end
