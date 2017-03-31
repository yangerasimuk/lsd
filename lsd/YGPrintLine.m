//
//  YGPrintLine.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGPrintLine.h"
#import "YGDirectory.h"
#import "YGDirectorySorter.h"

@implementation YGPrintLine

- (instancetype)initWithOptions:(YGOptions *)options{
    self = [super init];
    if(self){
        _options = options;
    }
    return self;
}

- (void)print{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *curDir = [fm currentDirectoryPath];
    NSDirectoryEnumerator *de = [fm enumeratorAtPath:curDir];
    NSString *fsObject = @"";
    BOOL isDir = NO;
    NSMutableArray<YGDirectory *> *dirs = [[NSMutableArray alloc] init];
    
    while(fsObject = [de nextObject]){
        
        [de skipDescendants];
        
        if([fm fileExistsAtPath:fsObject isDirectory:&isDir] && isDir){
            YGDirectory *dir = [[YGDirectory alloc] initWithName:fsObject atPath:curDir];
            [dirs addObject:dir];
        }
        
    }
    
    NSArray *sortedDirs = [NSArray arrayWithArray:[YGDirectorySorter sort:dirs byOrder:_options.sortBy inDirection:_options.sortDirection]];
    
    for(YGDirectory *dir in sortedDirs){
        printf("%s\t\t", [dir.name UTF8String]);
    }
}

@end
