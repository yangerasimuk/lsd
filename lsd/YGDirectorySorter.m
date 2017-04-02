//
//  YGDirectorySorter.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGDirectorySorter.h"

@implementation YGDirectorySorter

/**
 Sort directories by given property and direction.
 
    - dirs: array of selected, but unsorted directories for process,
 
    - sortBy: directory property for sort by,
 
    - sortDirection: direction of sorting: ascending or descending,
 
    - return: array of sorted YGDirectory objects.
 
 Names compare in lowercase.
 */
+ (NSArray<YGDirectory *> *)sort:(NSArray<YGDirectory *> *)dirs byOrder:(YGOptionSortBy)sortBy inDirection:(YGOptionSortDirection)sortDirection{
    
    NSArray<YGDirectory *> *directories = [[NSArray alloc] init];
    
    directories = [dirs sortedArrayUsingComparator:^NSComparisonResult(YGDirectory *obj1, YGDirectory *obj2){
        
        if(sortBy == YGOptionSortByName){
            if(sortDirection == YGOptionSortDirectionAscending){
                if([[obj1.name lowercaseString] compare:[obj2.name lowercaseString]] == NSOrderedAscending)
                    return NSOrderedAscending;
                else if([[obj1.name lowercaseString] compare:[obj2.name lowercaseString]] == NSOrderedDescending)
                    return NSOrderedDescending;
                else
                    return NSOrderedSame;
            }
            else{
                if([[obj1.name lowercaseString] compare:[obj2.name lowercaseString]] == NSOrderedAscending)
                    return NSOrderedDescending;
                else if([[obj1.name lowercaseString] compare:[obj2.name lowercaseString]] == NSOrderedDescending)
                    return NSOrderedAscending;
                else
                    return NSOrderedSame;

            }
        }
        else if(sortBy == YGOptionSortByCreated){
            if(sortDirection == YGOptionSortDirectionAscending){
                if([obj1.created compare:obj2.created] == NSOrderedAscending)
                    return NSOrderedAscending;
                else if([obj1.created compare:obj2.created] == NSOrderedDescending)
                    return NSOrderedDescending;
                else
                    return NSOrderedSame;
            }
            else{
                if([obj1.created compare:obj2.created] == NSOrderedAscending)
                    return NSOrderedDescending;
                else if([obj1.created compare:obj2.created] == NSOrderedDescending)
                    return NSOrderedAscending;
                else
                    return NSOrderedSame;
            }
        }
        else if(sortBy == YGOptionSortByModified){
            if(sortDirection == YGOptionSortDirectionAscending){
                if([obj1.modified compare:obj2.modified] == NSOrderedAscending)
                    return NSOrderedAscending;
                else if([obj1.modified compare:obj2.modified] == NSOrderedDescending)
                    return NSOrderedDescending;
                else
                    return NSOrderedSame;
            }
            else{
                if([obj1.modified compare:obj2.modified] == NSOrderedAscending)
                    return NSOrderedDescending;
                else if([obj1.modified compare:obj2.modified] == NSOrderedDescending)
                    return NSOrderedAscending;
                else
                    return NSOrderedSame;
            }
            
        }
        else if(sortBy == YGOptionSortBySize){
            if(sortDirection == YGOptionSortDirectionAscending){
                if(obj1.size < obj2.size)
                    return NSOrderedAscending;
                else if(obj1.size > obj2.size)
                    return NSOrderedDescending;
                else
                    return NSOrderedSame;
            }
            else{
                if(obj1.size > obj2.size)
                    return NSOrderedAscending;
                else if(obj1.size < obj2.size)
                    return NSOrderedDescending;
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
