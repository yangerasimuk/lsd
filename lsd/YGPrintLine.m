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
#import "defineConstants.h"

@implementation YGPrintLine

- (instancetype)initWithOptions:(YGOptions *)options{
    self = [super initWithOptions:options];
    if(self){
        ;
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
            
            // lazy init - create directory properties only defined in SortBy option (+name)
            YGDirectory *dir = [[YGDirectory alloc] initWithName:fsObject atPath:curDir sortBy:self.options.sortBy];
                        
            [dirs addObject:dir];
        }
    }
    
    NSArray *sortedDirs = [NSArray arrayWithArray:[YGDirectorySorter sort:dirs byOrder:self.options.sortBy inDirection:self.options.sortDirection]];
    
    printf("\n");
    for(YGDirectory *dir in sortedDirs){
        printf(kPrintLineGap, [dir.name UTF8String]);
    }
}

@end
