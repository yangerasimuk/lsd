//
//  YGApplication.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGApplication.h"

@interface YGApplication()

@end

@implementation YGApplication

+ (YGApplication *) sharedInstance{
    
    static YGApplication *app = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        app = [[YGApplication alloc] init];
    });
    
    return app;
}

- (instancetype) init{
    self = [super init];
    if(self){
        _options = [[YGOptions alloc] init];
        _preferences = [[YGPreferences alloc] init];
    }
    return self;
}


- (void) defineOptions:(NSString *)args{
#ifndef FUNC_DEBUG
#define FUNC_DEBUG
#endif
    
#ifdef FUNC_DEBUG
    printf("\nArgs: %s", [args UTF8String]);
#endif
    
    _options = _preferences.options;

#ifdef FUNC_DEBUG
    printf("\nDefaults: %s", [[_options description] UTF8String]);
#endif
    
    
    if(args){
        for(NSUInteger i = 0; i < [args length]; i++){
            unichar ch = [args characterAtIndex:i];
            
            if(ch == 'l'){ // printLine
                _options.printType = YGOptionPrintTypeLine;
            }
            else if(ch == 'v'){ // printColomn // vertical
                _options.printType = YGOptionPrintTypeVertical;
            }
            else if(ch == 's'){ // printSize
                _options.printType = YGOptionPrintTypeVerticalSize;
            }
            else if(ch == 'n'){ // sort by name
                _options.sortBy = YGOptionSortByName;
            }
            else if(ch == 'c'){ // sort by created date
                _options.sortBy = YGOptionSortByCreated;
            }
            else if(ch == 'm'){ // sort by modified dat
                _options.sortBy = YGOptionSortByModified;
            }
            else if(ch == 'a'){ // sort ascending
                _options.sortDirection = YGOptionSortDirectionAscending;
            }
            else if(ch == 'd'){ // sort descending
                _options.sortDirection = YGOptionSortDirectionDescending;
            }
            else if(ch == 'd'){ // sort descending
                _options.showHideDirs = YGOptionShowHideDirsYES;
            }

        }
    }
#ifdef FUNC_DEBUG
    printf("\nResult: %s", [[_options description] UTF8String]);
#endif
}

@end
