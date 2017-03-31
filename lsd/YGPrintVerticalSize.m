
//
//  YGPrintVerticalSize.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGPrintVerticalSize.h"

@implementation YGPrintVerticalSize
- (instancetype)initWithOptions:(YGOptions *)options{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (void)print{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *curDir = [fm currentDirectoryPath];
    NSDirectoryEnumerator *de = [fm enumeratorAtPath:curDir];
    NSString *fsObject = @"";
    BOOL isDir = NO;
    
    while(fsObject = [de nextObject]){
        
        [de skipDescendants];
        
        if([fm fileExistsAtPath:fsObject isDirectory:&isDir] && isDir){
            printf("%s\t", [fsObject UTF8String]);
            
        }
        
    }
}



@end
