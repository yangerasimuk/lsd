//
//  YGDirectory.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGOptions.h"

@interface YGDirectory : NSObject

- (instancetype) initWithName:(NSString *)name atPath:(NSString *)path sortBy:(YGOptionSortBy)sortBy;
- (instancetype) initWithName:(NSString *)name atPath:(NSString *)path;
- (instancetype) initWithName:(NSString *)name;

/// Directory name
@property NSString *name;

/// Directory full name (path + name)
@property NSString *fullName;

/// Date created, get from file attributes
@property NSDate *created;

/// Date modified, get from file attributes
@property NSDate *modified;

/// Size in bytes, sum of all files (recursive)
@property NSUInteger size;

/// Is directory hidden/dotted?
@property BOOL isDotted;

@end
