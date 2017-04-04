//
//  YGOptions.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGOptions.h"

@interface YGOptions()
- (instancetype)initWithPrintType:(YGOptionPrintType)printType sortBy:(YGOptionSortBy)sortBy sortDirection:(YGOptionSortDirection)sortDireciton showDotted:(YGOptionShowDotted)showDotted showMode:(YGOptionShowMode)showMode localeIdentifier:(YGOptionLocaleIdentifier)localeIdentifier showInfo:(YGOptionShowInfo)showInfo addSeparateLine:(YGOptionAddSeparateLine)addSeparateLine;
@end

@implementation YGOptions

/**
 Basic init of options of YGCommand object.
 
    - printType: form of print type (in line or in vertical colomn),
 
    - sortBy: property for sorting selected dirs,
 
    - sortDirection: direction for sorting (ascending or descending),
 
    - showDotted: show or not hidden/dotted directories,
 
    - showMode: show list in basic (only name) or extended (date or size) mode,
 
    - localeIdentifier: locale identifier for more human view of date,
 
    - return: YGOptions instance.
 
    fix
 
 */
- (instancetype)initWithPrintType:(YGOptionPrintType)printType sortBy:(YGOptionSortBy)sortBy sortDirection:(YGOptionSortDirection)sortDireciton showDotted:(YGOptionShowDotted)showDotted showMode:(YGOptionShowMode)showMode localeIdentifier:(YGOptionLocaleIdentifier)localeIdentifier showInfo:(YGOptionShowInfo)showInfo addSeparateLine:(YGOptionAddSeparateLine)addSeparateLine{
    
    self = [super init];
    if(self){
        _printType = printType;
        _sortBy = sortBy;
        _sortDirection = sortDireciton;
        _showDotted = showDotted;
        _showMode = showMode;
        _localeIdentifier = localeIdentifier;
        _showInfo = showInfo;
        _addSeparateLine = addSeparateLine;
    }
    return self;
}

/** 
 Wrapper init for create options with default ones.
 
    - printType: list directories in one vertical colomn,
 
    - sortBy: sort by file name,
 
    - sortDirection: sort in descending mode,
 
    - showDotted: do not show hide directories,
 
    - showMode: basic mode without extended info (dates or size),
 
 fix
 
    - return: YGOptions instance.
 */
- (instancetype)init{
    return [self initWithPrintType:YGOptionPrintTypeVertical sortBy:YGOptionSortByName sortDirection:YGOptionSortDirectionDescending showDotted:YGOptionShowDottedNo showMode:YGOptionShowModeBasic localeIdentifier:YGOptionLocaleIdentifierEn showInfo:YGOptionShowInfoNo addSeparateLine:YGOptionAddSeparateLineYes];
}

/**
 Override description message for debug.
 
    - return: string for print.
 */
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
    
    [result appendString:@" | ShowDotted: "];
    if(_showDotted == YGOptionShowDottedNo)
        [result appendString:@"no"];
    if(_showDotted == YGOptionShowDottedYes)
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
    
    [result appendString:@" | ShowInfo: "];
    if(_showInfo == YGOptionShowInfoYes)
        [result appendString:@"yes"];
    if(_showInfo == YGOptionShowInfoNo)
        [result appendString:@"no"];

    [result appendString:@" | AddSeparateLine: "];
    if(_addSeparateLine == YGOptionAddSeparateLineYes)
        [result appendString:@"yes"];
    if(_addSeparateLine == YGOptionAddSeparateLineNo)
        [result appendString:@"no"];
    
    return [result copy];
}

@end
