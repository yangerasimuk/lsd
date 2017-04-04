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
+ (NSUInteger)maxDirNameLength:(NSArray *)dirsSorted;
+ (NSString *) alignDirNameString:(NSString *)dirName withMaxLength:(NSUInteger)maxDirNameLength;
+ (NSString *)dateInHumanView:(NSDate *)date withLocaleIdentifier:(YGOptionLocaleIdentifier)localeIdentifier;
+ (NSString *)stringForSize:(NSUInteger)size;
+ (NSUInteger)maxSizeSeparatorLocation:(NSArray *)dirsSorted;
+ (NSString *)alignSizeString:(NSString *)sizeString withMaxSizeSeparatorLocation:(NSUInteger)maxSizeSeparatorLocation;
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
    NSDirectoryEnumerator *de = [fm enumeratorAtPath:[fm currentDirectoryPath]];
    NSString *fsObject = @"";
    BOOL isDir = NO;
    NSMutableArray<YGDirectory *> *dirs = [[NSMutableArray alloc] init];
    
    while(fsObject = [de nextObject]){
        
        // do not go in subdirectories
        [de skipDescendants];
        
        // select only directories
        if([fm fileExistsAtPath:fsObject isDirectory:&isDir] && isDir){
            YGDirectory *dir = [[YGDirectory alloc] initWithName:fsObject atPath:[fm currentDirectoryPath] sortBy:self.options.sortBy];
            
            // skip hidden/dotted files
            if((self.options.showDotted == YGOptionShowDottedYes)
               || (self.options.showDotted == YGOptionShowDottedNo && !dir.isDotted))
                [dirs addObject:dir];
            
        }
    }
    
    if([dirs count] == 0){
        printf("No files...");
        return;
    }
    
    NSArray *dirsSorted = [NSArray arrayWithArray:[YGDirectorySorter sort:dirs byOrder:self.options.sortBy inDirection:self.options.sortDirection]];
    
    // define first element in loop, for nice output
    int i = 1;
    
    // choice extended or base show mode
    if(self.options.showMode == YGOptionShowModeExtended && self.options.sortBy != YGOptionSortByName){
        
        // max length of dir name in array for align colomns for nice view
        NSUInteger maxDirNameLength = [YGPrintVertical maxDirNameLength:dirsSorted];
        
        if(self.options.sortBy == YGOptionSortByCreated || self.options.sortBy == YGOptionSortByModified){
            
            for(YGDirectory *dir in dirsSorted){
                
                NSDate *date = nil;
                if(self.options.sortBy == YGOptionSortByCreated)
                    date = dir.created;
                else if(self.options.sortBy == YGOptionSortByModified)
                    date = dir.modified;
                
                if(i++ > 1)
                    printf("\n");
                
                printf("%s%s%s", \
                       [[YGPrintVertical alignDirNameString:dir.name withMaxLength:maxDirNameLength] UTF8String], \
                       kPrintVerticalExtendedGap, \
                       [[YGPrintVertical stringForDate:date withLocaleIdentifier:self.options.localeIdentifier] UTF8String] \
                       );
            }
        }
        else if(self.options.sortBy == YGOptionSortBySize){
            
            NSUInteger maxSizeSeparatorLocation = [YGPrintVertical maxSizeSeparatorLocation:dirsSorted];
            
            for(YGDirectory *dir in dirsSorted){
                if(i++ > 1)
                    printf("\n");
                printf("%s%s%s", \
                       [[YGPrintVertical alignDirNameString:dir.name withMaxLength:maxDirNameLength] UTF8String], \
                       kPrintVerticalExtendedGap, \
                       [[YGPrintVertical alignSizeString:[YGPrintVertical stringForSize:dir.size] withMaxSizeSeparatorLocation:maxSizeSeparatorLocation] UTF8String] \
                       );
            }
        }
    }
    else{
        for(YGDirectory *dir in dirs){
            if(i++ > 1)
                printf("\n");
            printf("%s", [dir.name UTF8String]);
        }
    }
}

+ (NSUInteger)maxDirNameLength:(NSArray *)dirsSorted{
    
    NSUInteger maxLength = 0;
    
    for(YGDirectory *dir in dirsSorted){
        if([dir.name length] > maxLength)
            maxLength = [dir.name length];
    }
    
    return maxLength;
}

/** ******************
 Transform name string of selected directory, to align in nice colomn. Next colomn will have same offset. To short names append spaces.
 
 - dirName: size string of selected directory,
 
 - maxDirNameLength: max directory name length,
 
 - return: aligned directory name string.
 */

+ (NSString *) alignDirNameString:(NSString *)dirName withMaxLength:(NSUInteger)maxDirNameLength{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSUInteger nameGap = maxDirNameLength - [dirName length];
    
    if(nameGap > 0){
        [resultString appendFormat:@"%@", dirName];
        for(NSUInteger i = nameGap; i > 0; i--)
            [resultString appendString:@" "];
    }
    else
        [resultString appendFormat:@"%@", dirName];
    
    return [resultString copy];
}


+ (NSString *)stringForDate:(NSDate *)date withLocaleIdentifier:(YGOptionLocaleIdentifier)localIdentifier{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSString *dateString = @"";
    NSString *dateStringHumanView = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kPrintVerticalDateFormatSystem];
    
    dateString = [formatter stringFromDate:date];
    dateStringHumanView = [YGPrintVertical dateInHumanView:date withLocaleIdentifier:localIdentifier];
    
    [resultString appendFormat:@"%@ | %@", \
     dateString, \
     dateStringHumanView];
    
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
 Transform size in bytes in more human view. 15560749240 -> 15'560'749'240 B | 15 GB.
 
 - size: directory contens size in bytes,
 
 - return: size in nice, usefull string - 15'560'749'240 B | 15 GB.
 */
+ (NSString *)stringForSize:(NSUInteger)size{
    
    NSString *resultString = @"";
    NSUInteger leadNum = 0, trailNum = 0, abbIndex = 0;
    
    // B, KB, MB, GB...
    NSArray *abbSize = kPrintVerticalFileSizes;
    
    NSMutableString *stringNum = [[NSMutableString alloc] init];
    NSMutableString *stringNumAll = [[NSMutableString alloc] init];
    
    
    NSString *s = [NSString stringWithFormat:@"%lu", size];
    
    for(int i = (int)([s length] - 1), j = 1; i >= 0; i--, j++){
        
        [stringNumAll insertString:[NSString stringWithFormat:@"%C", [s characterAtIndex:i]] atIndex:0];
        if(j % 3 == 0 && i != 0){
            [stringNumAll insertString:@"'" atIndex:0];
        }
    }
    
    do{
        if(size < 1024 && size != 0){
            [stringNum insertString:[NSString stringWithFormat:@"%lu %@", size, abbSize[abbIndex]] atIndex:0];
            //[stringNumAll insertString:[NSString stringWithFormat:@"%lu", size] atIndex:0];
            break;
        }
        else{
            leadNum = size / 1024;
            trailNum = size % 1024;
            
            //if(trailNum != 0)
                //[stringNumAll insertString:[NSString stringWithFormat:@"'%lu", trailNum] atIndex:0];
            
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


+ (NSUInteger)maxSizeSeparatorLocation:(NSArray *)dirsSorted{

    NSUInteger maxLocation = 0;
    
    for(YGDirectory *dir in dirsSorted){
        
        NSString *sizeString = [NSString stringWithFormat:@"%@", [YGPrintVertical stringForSize:dir.size]];
        NSRange range = [sizeString rangeOfString:@"|"];
        NSUInteger location = 0;
        if(range.location != NSNotFound)
            location = range.location;
        
        if(location > maxLocation)
            maxLocation = location;
    }
    
    return maxLocation;
}


/**************
 Transform size string of selected directory, to align in nice colomn. To short names add spaces.
 
 - sizeString: size string of selected directory,
 
 - maxSeparatorIndex: max location of separator '|' in string,
 
 - return: aligned size string for selected directory.
 */

+ (NSString *)alignSizeString:(NSString *)sizeString withMaxSizeSeparatorLocation:(NSUInteger)maxSizeSeparatorLocation{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSRange range = [sizeString rangeOfString:@"|"];
    NSUInteger indexGap = 0;
    
    if(range.location != NSNotFound && maxSizeSeparatorLocation >= range.location){
        indexGap = maxSizeSeparatorLocation - range.location;
    }
    else if(maxSizeSeparatorLocation > 0){
        indexGap = maxSizeSeparatorLocation - 1;
    }
    
    if(indexGap > 0)
        for(NSUInteger i = indexGap; i > 0; i--)
            [resultString appendString:@" "];
    
    [resultString appendFormat:@"%@", sizeString];
    
    return [resultString copy];
    
}


@end
