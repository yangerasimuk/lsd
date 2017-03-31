//
//  YGDirectorySorter.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGDirectorySorter.h"

@implementation YGDirectorySorter

+ (NSArray<YGDirectory *> *)sort:(NSArray<YGDirectory *> *)dirs byOrder:(YGOptionSortBy)sortBy inDirection:(YGOptionSortDirection)sortDirection{
    
    NSArray<YGDirectory *> *directories = [[NSArray alloc] init];
    directories = [dirs sortedArrayUsingComparator:^NSComparisonResult(YGDirectory *obj1, YGDirectory *obj2){
        
        if(sortBy == YGOptionSortByName){
            if(sortDirection == YGOptionSortDirectionAscending){
                if([obj1.name compare:obj2.name] == NSOrderedAscending)
                    return NSOrderedAscending;
                else if([obj1.name compare:obj2.name] == NSOrderedDescending)
                    return NSOrderedDescending;
                else
                    return NSOrderedSame;
            }
            else{
                if([obj1.name compare:obj2.name] == NSOrderedAscending)
                    return NSOrderedDescending;
                else if([obj1.name compare:obj2.name] == NSOrderedDescending)
                    return NSOrderedAscending;
                else
                    return NSOrderedSame;

            }
        }
        else
            return NSOrderedSame;
        
    }];
    
    
    return directories;
}

@end
