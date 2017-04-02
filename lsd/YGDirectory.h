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

@property NSString *name;
@property NSString *fullName;
@property NSDate *created;
@property NSDate *modified;
@property NSUInteger size;
@property BOOL isDotted;

@end
