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

/**
 Base init, set actual options for superclass.
 
 - options: options for command.
 */
- (instancetype)initWithOptions:(YGOptions *)options{
    self = [super initWithOptions:options];
    if(self){
        ;
    }
    return self;
}

/**
 Print list of directories in vertical colomn. Have base and extended mode.
 */
- (void)print{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *curDir = [fm currentDirectoryPath];
    NSDirectoryEnumerator *de = [fm enumeratorAtPath:curDir];
    NSString *fsObject = @"";
    BOOL isDir = NO;
    NSMutableArray<YGDirectory *> *dirs = [[NSMutableArray alloc] init];
    
    while(fsObject = [de nextObject]){
        
        // do not go in subdirectories
        [de skipDescendants];
        
        // select only directories
        if([fm fileExistsAtPath:fsObject isDirectory:&isDir] && isDir){
            YGDirectory *dir = [[YGDirectory alloc] initWithName:fsObject atPath:curDir sortBy:self.options.sortBy];
            
            // skip hidden/dotted files
            if((self.options.showDotted == YES) || (self.options.showDotted == NO && !dir.isDotted))
                [dirs addObject:dir];
        }
    }
    
    NSArray *sortedDirs = [NSArray arrayWithArray:[YGDirectorySorter sort:dirs byOrder:self.options.sortBy inDirection:self.options.sortDirection]];
    
    // choice extended or base show mode
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

/**
 Make date string for YGDirectory instance in more human veiw. For example: 2017-03-31 10:34:51 | March 31, 2017.
 
    - sortedDirs: array of sorted directories to get info for align colomns,
 
    - return: size string in more human view. For example: 2017-03-31 10:34:51 | March 31, 2017.
 */
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
            dateStringHumanView = [YGPrintVertical dateInHumanView:dir.created withLocaleIdentifier:self.options.localeIdentifier];
        }
        else if(sortBy == YGOptionSortByModified){
            dateString = [formatter stringFromDate:dir.modified];
            dateStringHumanView = [YGPrintVertical dateInHumanView:dir.modified withLocaleIdentifier:self.options.localeIdentifier];
        }

        [resultString appendFormat:@"\n%@%@%@ | %@", \
         [YGPrintVertical alignDir:dir.name maxDirNameLength:maxDirNameLength], \
         kPrintVerticalExtendedGap,
         dateString, \
         dateStringHumanView];
    }
    
    return [resultString copy];

}

/**
 Transform date in more human view. 2017-03-31 10:34:51 +0000 -> March 31, 2017..
 
    - date: date property of directory,
 
    - localeIdentifier: identifier for localize string (store in config file),
 
    - return: size in nice, usefull string. For example: March 31, 2017 (@"en_EN" local).
 */
+ (NSString *)dateInHumanView:(NSDate *)date withLocaleIdentifier:(YGOptionLocaleIdentifier)localeIdentifier{
    
    NSString *locale = @"";
    if(localeIdentifier == YGOptionLocaleIdentifierRu)
        locale = kPrintVerticalLocaleIdentifierRu;
    else
        locale = kPrintVerticalLocaleIdentifierEn;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:locale]];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [formatter stringFromDate:date];
}

/**
 Make size string for YGDirectory instance in more human veiw. 15560749240 -> 15'560'749'240 B | 15 GB
 
    - sortedDirs: array of sorted directories to get info for align colomns,
 
    - return: size string in more human view. For example: 15'560'749'240 B | 15 GB.
 */
- (NSString *)stringExtendedForSize:(NSArray *)sortedDirs{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSUInteger maxDirNameLength = 0;
    NSUInteger maxLocationOfSizeSeparator = 0;
    //NSUInteger maxSizeLengthToSeparator = 0;
    
    // get max directory name and max location of separator
    for(YGDirectory *dir in sortedDirs){
        if([dir.name length] > maxDirNameLength)
            maxDirNameLength = [dir.name length];
        
        NSString *size = [NSString stringWithFormat:@"%@", [YGPrintVertical sizeInHumanView:dir.size]];
        NSRange range = [size rangeOfString:@"|"];
        NSUInteger i = 0;
        if(range.location != NSNotFound)
            i = range.location;
        
        if(i > maxLocationOfSizeSeparator)
            maxLocationOfSizeSeparator = i;
    }
    
    for(YGDirectory *dir in sortedDirs){

        [resultString appendFormat:@"\n%@%@%@", \
         [YGPrintVertical alignDir:dir.name maxDirNameLength:maxDirNameLength], \
         kPrintVerticalExtendedGap,
         [YGPrintVertical alignSize:[YGPrintVertical sizeInHumanView:dir.size] maxLocationOfSizeSeparator:maxLocationOfSizeSeparator]];
    }
    
    return [resultString copy];
}

/**
 Transform name string of selected directory, to align in nice colomn. Next colomn will have same offset. To short names append spaces.
 
    - dirName: size string of selected directory,
 
    - maxDirNameLength: max directory name length,
 
    - return: aligned directory name string.
 */
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

/**
 Transform size string of selected directory, to align in nice colomn. To short names add spaces.
 
    - sizeString: size string of selected directory,
 
    - maxSeparatorIndex: max location of separator '|' in string,
 
    - return: aligned size string for selected directory.
 */
+ (NSString *)alignSize:(NSString *)sizeString maxLocationOfSizeSeparator:(NSUInteger)maxLocationOfSizeSeparator {
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSRange range = [sizeString rangeOfString:@"|"];
    NSUInteger indexGap = 0;
    
    if(range.location != NSNotFound){
        indexGap = maxLocationOfSizeSeparator - range.location;
    }
    else{
        indexGap = maxLocationOfSizeSeparator - 1;
    }
    
    if(indexGap != 0)
        for(NSUInteger i = indexGap; i > 0; i--)
            [resultString appendString:@" "];

    [resultString appendFormat:@"%@", sizeString];
    
    return [resultString copy];
}

/**
 Transform size in bytes in more human view. 15560749240 -> 15'560'749'240 B | 15 GB.
 
    - size: directory contens size in bytes,
    
    - return: size in nice, usefull string - 15'560'749'240 B | 15 GB.
 */
+ (NSString *)sizeInHumanView:(NSUInteger)size{
    
    NSString *resultString = @"";
    NSUInteger leadNum = 0, trailNum = 0, abbIndex = 0;
    
    // B, KB, MB, GB...
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
