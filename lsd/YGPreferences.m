//
//  YGPreferences.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGPreferences.h"
#import "YGApplication.h"

@interface YGPreferences()
+ (YGOptions *)defaultOptions;
+ (void)setDefaultOptions;
@end

@implementation YGPreferences

/**
 Base init. Check config exists, if not - create config file, then set default options.
 */
- (instancetype) init{
    self = [super init];
    if(self){
        if(![YGConfig isExists])
            [YGPreferences setDefaultOptions];
        
        _options = [YGPreferences defaultOptions];
    }
    return self;
}

/**
 Get default options of command from config.
 
    - return: default options of command.
 */
+ (YGOptions *)defaultOptions{
    
    YGOptions *resultOptions = [[YGOptions alloc] init];
    
    // single
    YGConfig *config = [YGConfig sharedInstance];
    
    // if config contents not defined string - print help
    NSString *printType = [NSString stringWithFormat:@"%@", [config valueForKey:@"PrintType"]];
    if([printType compare:@"Line"] == NSOrderedSame)
        resultOptions.printType = YGOptionPrintTypeLine;
    else if([printType compare:@"Vertical"] == NSOrderedSame)
        resultOptions.printType = YGOptionPrintTypeVertical;
    else
        resultOptions.printType = YGOptionPrintTypeHelp;
    
    NSString *sortBy = [NSString stringWithFormat:@"%@", [config valueForKey:@"SortBy"]];
    if([sortBy compare:@"Name"] == NSOrderedSame)
        resultOptions.sortBy = YGOptionSortByName;
    else if([sortBy compare:@"Created"] == NSOrderedSame)
        resultOptions.sortBy = YGOptionSortByCreated;
    else if([sortBy compare:@"Modified"] == NSOrderedSame)
        resultOptions.sortBy = YGOptionSortByModified;
    else if([sortBy compare:@"Size"] == NSOrderedSame)
        resultOptions.sortBy = YGOptionSortBySize;

    NSString *sortDirection = [NSString stringWithFormat:@"%@", [config valueForKey:@"SortDirection"]];
    if([sortDirection compare:@"Asc"] == NSOrderedSame)
        resultOptions.sortDirection = YGOptionSortDirectionAscending;
    else if([sortDirection compare:@"Desc"] == NSOrderedSame)
        resultOptions.sortDirection = YGOptionSortDirectionDescending;
    
    NSString *showDotted = [NSString stringWithFormat:@"%@", [config valueForKey:@"ShowDotted"]];
    if([showDotted compare:@"Yes"] == NSOrderedSame)
        resultOptions.showDotted = YGOptionShowDottedYes;
    else if([showDotted compare:@"No"] == NSOrderedSame)
        resultOptions.showDotted = YGOptionShowDottedNo;

    NSString *showMode = [NSString stringWithFormat:@"%@", [config valueForKey:@"ShowMode"]];
    if([showMode compare:@"Basic"] == NSOrderedSame)
        resultOptions.showMode = YGOptionShowModeBasic;
    else if([showMode compare:@"Extended"] == NSOrderedSame)
        resultOptions.showMode = YGOptionShowModeExtended;

    NSString *localeIdentifier = [NSString stringWithFormat:@"%@", [config valueForKey:@"LocaleIdentifier"]];
    if([localeIdentifier compare:@"ru_RU"] == NSOrderedSame)
        resultOptions.localeIdentifier = YGOptionLocaleIdentifierRu;
    else if([localeIdentifier compare:@"Extended"] == NSOrderedSame)
        resultOptions.localeIdentifier = YGOptionLocaleIdentifierEn;
    
    NSString *showInfo = [NSString stringWithFormat:@"%@", [config valueForKey:@"ShowInfo"]];
    if([showInfo compare:@"Yes"] == NSOrderedSame)
        resultOptions.showInfo = YGOptionShowInfoYes;
    else if([showInfo compare:@"No"] == NSOrderedSame)
        resultOptions.showInfo = YGOptionShowInfoNo;

    NSString *addSeparateLine = [NSString stringWithFormat:@"%@", [config valueForKey:@"AddSeparateLine"]];
    if([addSeparateLine compare:@"Yes"] == NSOrderedSame)
        resultOptions.addSeparateLine = YGOptionAddSeparateLineYes;
    else if([addSeparateLine compare:@"No"] == NSOrderedSame)
        resultOptions.addSeparateLine = YGOptionAddSeparateLineNo;
    
    return resultOptions;
}

/**
 Write default options to config.
 */
+ (void)setDefaultOptions{
    
    YGConfig *config = [YGConfig sharedInstance];
    
    [config setValue:@"Line" forKey:@"PrintType"];
    [config setValue:@"Name" forKey:@"SortBy"];
    [config setValue:@"Desc" forKey:@"SortDirection"];
    [config setValue:@"No" forKey:@"ShowDotted"];
    [config setValue:@"Basic" forKey:@"ShowMode"];
    [config setValue:@"en_EN" forKey:@"LocaleIdentifier"];
    [config setValue:@"No" forKey:@"ShowInfo"];
    [config setValue:@"Yes" forKey:@"AddSeparateLine"];
}

@end
