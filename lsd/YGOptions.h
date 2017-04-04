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

enum YGOptionShowDotted{
    YGOptionShowDottedYes,
    YGOptionShowDottedNo
};
typedef enum YGOptionShowDotted YGOptionShowDotted;

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

enum YGOptionShowInfo {
    YGOptionShowInfoYes,
    YGOptionShowInfoNo
};
typedef enum YGOptionShowInfo YGOptionShowInfo;

enum YGOptionAddSeparateLine {
    YGOptionAddSeparateLineYes,
    YGOptionAddSeparateLineNo
};
typedef enum YGOptionAddSeparateLine YGOptionAddSeparateLine;

@interface YGOptions : NSObject

- (instancetype)initWithPrintType:(YGOptionPrintType)printType sortBy:(YGOptionSortBy)sortBy sortDirection:(YGOptionSortDirection)sortDireciton showDotted:(YGOptionShowDotted)showDotted showMode:(YGOptionShowMode)showMode localeIdentifier:(YGOptionLocaleIdentifier)localeIdentifier addSeparateLine:(YGOptionAddSeparateLine)addSeparateLine;

- (NSString *)description;

/// Type of print: in line or in colomn
@property YGOptionPrintType printType;

/// Property for sort of list items
@property YGOptionSortBy sortBy;

/// Sort direction of list items
@property YGOptionSortDirection sortDirection;

/// Show hidden/dotted directories
@property YGOptionShowDotted showDotted;

/// Show mode: basic (only names) or extended (with more info)
@property YGOptionShowMode showMode;

/// Local identifier to tune date format to more human view
@property YGOptionLocaleIdentifier localeIdentifier;

/// Show help info about all work option of current launch
@property YGOptionShowInfo showInfo;

/// Add separate new line to more usefull output
@property YGOptionAddSeparateLine addSeparateLine;

@end
