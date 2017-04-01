//
//  YGPrintVertical.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGPrintVertical.h"
#import "YGDirectory.h"
#import "YGDirectorySorter.h"
#import "defineConstants.h"

@interface YGPrintVertical()
+ (NSString *)sizeInHumanView:(NSUInteger)size;
@end

@implementation YGPrintVertical

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
            YGDirectory *dir = [[YGDirectory alloc] initWithName:fsObject atPath:curDir sortBy:self.options.sortBy];
            [dirs addObject:dir];
        }
    }
    
    NSArray *sortedDirs = [NSArray arrayWithArray:[YGDirectorySorter sort:dirs byOrder:self.options.sortBy inDirection:self.options.sortDirection]];
    
    if(self.options.showMode == YGOptionShowModeExtended && self.options.sortBy != YGOptionSortByName){
        if(self.options.sortBy == YGOptionSortByCreated)
            printf("%s", [[self stringExtended:sortedDirs forSortByDate:YGOptionSortByCreated] UTF8String]);
        else if(self.options.sortBy == YGOptionSortByModified)
            printf("%s", [[self stringExtended:sortedDirs forSortByDate:YGOptionSortByModified] UTF8String]);
        else if(self.options.sortBy == YGOptionSortBySize)
            printf("%s", [[self stringExtendedForSize:sortedDirs] UTF8String]);
    }
    else{
        for(YGDirectory *dir in sortedDirs)
            printf("\n%s", [dir.name UTF8String]);
    }
}

- (NSString *)stringExtended:(NSArray *)sortedDirs forSortByDate:(YGOptionSortBy)sortBy{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];

    // getm max dir name in array
    NSUInteger maxDirNameLength = 0;
    for(YGDirectory *dir in sortedDirs){
        if([dir.name length] > maxDirNameLength)
            maxDirNameLength = [dir.name length];
    }
    
    NSString *dateString = @"";
    NSString *dateStringHumanView = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kPrintVerticalDateFormatSystem];
    
    
    for(YGDirectory *dir in sortedDirs){
        if(sortBy == YGOptionSortByCreated){
            dateString = [formatter stringFromDate:dir.created];
            dateStringHumanView = [YGPrintVertical dateInHumanView:dir.created];
        }
        else if(sortBy == YGOptionSortByModified){
            dateString = [formatter stringFromDate:dir.modified];
            dateStringHumanView = [YGPrintVertical dateInHumanView:dir.modified];
        }

        [resultString appendFormat:@"\n%@%@%@ | %@", \
         [YGPrintVertical alignDir:dir.name maxDirNameLength:maxDirNameLength], \
         kPrintVerticalExtendedGap,
         dateString, \
         dateStringHumanView];
    }
    
    return [resultString copy];

}

+ (NSString *)dateInHumanView:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [formatter stringFromDate:date];
}

- (NSString *)stringExtendedForSize:(NSArray *)sortedDirs{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSUInteger maxDirNameLength = 0;
    NSUInteger maxSizeLengthToSeparator = 0;
    
    // getm max's
    for(YGDirectory *dir in sortedDirs){
        if([dir.name length] > maxDirNameLength)
            maxDirNameLength = [dir.name length];
        
        NSString *size = [NSString stringWithFormat:@"%@", [YGPrintVertical sizeInHumanView:dir.size]];
        NSRange range = [size rangeOfString:@"|"];
        NSUInteger i = 0;
        if(range.location != NSNotFound)
            i = range.location;
        
        if(i > maxSizeLengthToSeparator)
            maxSizeLengthToSeparator = i;
    }
    
    for(YGDirectory *dir in sortedDirs){

        [resultString appendFormat:@"\n%@%@%@", \
         [YGPrintVertical alignDir:dir.name maxDirNameLength:maxDirNameLength], \
         kPrintVerticalExtendedGap,
         [YGPrintVertical alignSize:[YGPrintVertical sizeInHumanView:dir.size] maxSeparatorIndex:maxSizeLengthToSeparator]];
    }
    
    return [resultString copy];
}

+ (NSString *)alignDir:(NSString *)dirName maxDirNameLength:(NSUInteger)maxDirNameLength{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSUInteger nameGap = maxDirNameLength - [dirName length];
    
    if(nameGap != 0){
        [resultString appendFormat:@"%@", dirName];
        for(NSUInteger i = nameGap; i > 0; i--)
            [resultString appendString:@" "];
    }
    else
        [resultString appendFormat:@"%@", dirName];
    
    return [resultString copy];
}

+ (NSString *)alignSize:(NSString *)sizeString maxSeparatorIndex:(NSUInteger)maxSeparatorIndex {
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSRange range = [sizeString rangeOfString:@"|"];
    NSUInteger indexGap = 0;
    
    if(range.location != NSNotFound){
        indexGap = maxSeparatorIndex - range.location;
    }
    else{
        indexGap = maxSeparatorIndex - 1;
    }
    
    if(indexGap != 0)
        for(NSUInteger i = indexGap; i > 0; i--)
            [resultString appendString:@" "];

    [resultString appendFormat:@"%@", sizeString];
    
    return [resultString copy];
}

+ (NSString *)sizeInHumanView:(NSUInteger)size{
    
    NSString *resultString = @"";
    NSUInteger leadNum = 0, trailNum = 0, abbIndex = 0;
    
    NSArray *abbSize = kPrintVerticalFileSizes;
    
    NSMutableString *stringNum = [[NSMutableString alloc] init];
    NSMutableString *stringNumAll = [[NSMutableString alloc] init];
    
    do{
        
        if(size < 1024 && size != 0){
            [stringNum insertString:[NSString stringWithFormat:@"%lu %@", size, abbSize[abbIndex]] atIndex:0];
            [stringNumAll insertString:[NSString stringWithFormat:@"%lu", size] atIndex:0];
            break;
            
        }
        else{
            leadNum = size / 1024;
            trailNum = size % 1024;
            
            if(trailNum != 0)
                [stringNumAll insertString:[NSString stringWithFormat:@"'%lu", trailNum] atIndex:0];
            
            size = leadNum;
            
            abbIndex++;
            
        }
        
    }while(size > 0);
    
    if([stringNum compare:@""] != NSOrderedSame)
        resultString = [NSString stringWithFormat:@"%@ B | %@", stringNumAll, stringNum];
    else
        resultString = @"0 B";
    
    return resultString;
}


@end
