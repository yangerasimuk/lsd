//
//  YGOptions.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGOptions.h"

@implementation YGOptions

/**
 Basic init for options
 */
- (instancetype)initWithPrintType:(YGOptionPrintType)printType sortBy:(YGOptionSortBy)sortBy sortDirection:(YGOptionSortDirection)sortDireciton showDottedDirs:(YGOptionShowDottedDirs)showDottedDirs showMode:(YGOptionShowMode)showMode localeIdentifier:(YGOptionLocaleIdentifier)localeIdentifier{
    
    self = [super init];
    if(self){
        _printType = printType;
        _sortBy = sortBy;
        _sortDirection = sortDireciton;
        _showDottedDirs = showDottedDirs;
        _showMode = showMode;
        _localeIdentifier = localeIdentifier;
    }
    return self;
}

/** 
 Init with default options.
 
 - printType: list directories in one vertical colomn
 
 - sortBy: sort by file name
 
 - sortDirection: sort in ascending mode
 
 - showHideDirs: do not show hide directories
 
 - showMode: basic mode without extended info (dates or size)
 */
- (instancetype)init{
    return [self initWithPrintType:YGOptionPrintTypeVertical sortBy:YGOptionSortByName sortDirection:YGOptionSortDirectionDescending showDottedDirs:YGOptionShowDottedDirsNO showMode:YGOptionShowModeBasic localeIdentifier:YGOptionLocaleIdentifierEn];
}

- (NSString *)description{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:@"Command: "];
    if(_printType == YGOptionPrintTypeLine)
        [result appendString:@"print in line"];
    else if(_printType == YGOptionPrintTypeVertical)
        [result appendString:@"print vertical"];
    
    [result appendString:@" | SortBy: "];
    if(_sortBy == YGOptionSortByName)
        [result appendString:@"name"];
    if(_sortBy == YGOptionSortByCreated)
        [result appendString:@"created"];
    if(_sortBy == YGOptionSortByModified)
        [result appendString:@"modified"];
    if(_sortBy == YGOptionSortBySize)
        [result appendString:@"size"];

    [result appendString:@" | SortDirection: "];
    if(_sortDirection == YGOptionSortDirectionAscending)
        [result appendString:@"ascending"];
    if(_sortDirection == YGOptionSortDirectionDescending)
        [result appendString:@"descending"];
    
    [result appendString:@" | ShowDottedDirs: "];
    if(_showDottedDirs == YGOptionShowDottedDirsNO)
        [result appendString:@"no"];
    if(_showDottedDirs == YGOptionShowDottedDirsYES)
        [result appendString:@"yes"];

        
    [result appendString:@" | ShowMode: "];
    if(_showMode == YGOptionShowModeBasic)
        [result appendString:@"basic"];
    if(_showMode == YGOptionShowModeExtended)
        [result appendString:@"extended"];
    
    [result appendString:@" | LocaleIdentifier: "];
    if(_localeIdentifier == YGOptionLocaleIdentifierRu)
        [result appendString:@"ru_RU"];
    if(_localeIdentifier == YGOptionLocaleIdentifierEn)
        [result appendString:@"en_EN"];

    return [result copy];
}

@end
