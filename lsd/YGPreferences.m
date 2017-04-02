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
+ (BOOL) isExists;
+ (YGOptions *)defaultOptions;
+ (void)setDefaultOptions;
@end

@implementation YGPreferences

- (instancetype) init{
    self = [super init];
    if(self){
        if(![YGPreferences isExists])
            [YGPreferences setDefaultOptions];
        
        _options = [YGPreferences defaultOptions];
    }
    return self;
}

+ (YGOptions *)defaultOptions{
    
    YGOptions *resultOptions = [[YGOptions alloc] init];
    
    YGConfig *config = [YGConfig sharedInstance];
    
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
    
    NSString *showDottedDirs = [NSString stringWithFormat:@"%@", [config valueForKey:@"ShowDottedDirs"]];
    if([showDottedDirs compare:@"Yes"] == NSOrderedSame)
        resultOptions.showDottedDirs = YGOptionShowDottedDirsYES;
    else if([showDottedDirs compare:@"No"] == NSOrderedSame)
        resultOptions.showDottedDirs = YGOptionShowDottedDirsNO;

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

    return resultOptions;
}

+ (void)setDefaultOptions{
    
    YGConfig *config = [YGConfig sharedInstance];
    
    [config setValue:@"Line" forKey:@"PrintType"];
    [config setValue:@"Name" forKey:@"SortBy"];
    [config setValue:@"Desc" forKey:@"SortDirection"];
    [config setValue:@"No" forKey:@"ShowDottedDir"];
    [config setValue:@"Basic" forKey:@"ShowMode"];
    [config setValue:@"en_EN" forKey:@"LocaleIdentifier"];

}

+ (BOOL) isExists{
    
    if([YGConfig isExists])
        return YES;
    else
        return NO;
}

@end
