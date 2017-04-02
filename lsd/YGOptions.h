//
//  YGOptions.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>

enum YGOptionPrintType {
    YGOptionPrintTypeLine,
    YGOptionPrintTypeVertical,
    YGOptionPrintTypeHelp
};
typedef enum YGOptionPrintType YGOptionPrintType;

enum YGOptionSortBy {
    YGOptionSortByName,
    YGOptionSortByCreated,
    YGOptionSortByModified,
    YGOptionSortBySize
    
};
typedef enum YGOptionSortBy YGOptionSortBy;

enum YGOptionSortDirection {
    YGOptionSortDirectionAscending,
    YGOptionSortDirectionDescending
};
typedef enum YGOptionSortDirection YGOptionSortDirection;

enum YGOptionShowDottedDirs{
    YGOptionShowDottedDirsNO,
    YGOptionShowDottedDirsYES
};
typedef enum YGOptionShowDottedDirs YGOptionShowDottedDirs;

enum YGOptionShowMode {
    YGOptionShowModeBasic,
    YGOptionShowModeExtended
};
typedef enum YGOptionShowMode YGOptionShowMode;

enum YGOptionLocaleIdentifier {
    YGOptionLocaleIdentifierRu,
    YGOptionLocaleIdentifierEn
};
typedef enum YGOptionLocaleIdentifier YGOptionLocaleIdentifier;


@interface YGOptions : NSObject

- (instancetype)initWithPrintType:(YGOptionPrintType)printType sortBy:(YGOptionSortBy)sortBy sortDirection:(YGOptionSortDirection)sortDireciton showDottedDirs:(YGOptionShowDottedDirs)showDottedDirs showMode:(YGOptionShowMode)showMode localeIdentifier:(YGOptionLocaleIdentifier)localeIdentifier;

- (NSString *)description;

@property YGOptionPrintType printType;
@property YGOptionSortBy sortBy;
@property YGOptionSortDirection sortDirection;
@property YGOptionShowDottedDirs showDottedDirs;
@property YGOptionShowMode showMode;
@property YGOptionLocaleIdentifier localeIdentifier;

@end
