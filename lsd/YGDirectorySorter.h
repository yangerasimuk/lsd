//
//  YGDirectorySorter.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGDirectory.h"
#import "YGOptions.h"

@interface YGDirectorySorter : NSObject

+ (NSArray<YGDirectory *> *)sort:(NSArray<YGDirectory *> *)dirs byOrder:(YGOptionSortBy)sortBy inDirection:(YGOptionSortDirection)sortDirection;

@end
