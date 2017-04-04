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

/**
 Singleton for application instance.
 */
+ (YGApplication *) sharedInstance{
    
    static YGApplication *app = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        app = [[YGApplication alloc] init];
    });
    
    return app;
}

/**
 Base init. Set properties for default and actual options.
 */
- (instancetype) init{
    self = [super init];
    if(self){
        _options = [[YGOptions alloc] init];
        _preferences = [[YGPreferences alloc] init];
    }
    return self;
}

/**
 Define actual options, first get all options from config, then override with user ones (get from command line).
 
    - args: string of arguments in command line.
 
 If args == nil, all options by defaults.
 */
- (void) defineOptions:(NSString *)args{

    // default options
    _options = _preferences.options;


    // get options from command line, if args == nil, all options by defaults
    if(args){
        for(NSUInteger i = 0; i < [args length]; i++){
            unichar ch = [args characterAtIndex:i];
            
            if(ch == 'l'){ // print in line
                _options.printType = YGOptionPrintTypeLine;
            }
            else if(ch == 'v'){ // print in vertical colomn // vertical
                _options.printType = YGOptionPrintTypeVertical;
            }
            else if(ch == '?'){ // print help
                _options.printType = YGOptionPrintTypeHelp;
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
            else if(ch == 's'){ // sortBy size
                _options.sortBy = YGOptionSortBySize;
            }
            else if(ch == 'a'){ // sort ascending
                _options.sortDirection = YGOptionSortDirectionAscending;
            }
            else if(ch == 'd'){ // sort descending
                _options.sortDirection = YGOptionSortDirectionDescending;
            }
            else if(ch == 'h'){ // hide dotted dirs
                _options.showDotted = YGOptionShowDottedYES;
            }
            else if(ch == 'b'){ // basic show mode
                _options.showMode = YGOptionShowModeBasic;
            }
            else if(ch == 'e'){ // extended show mode
                _options.showMode = YGOptionShowModeExtended;
            }
            else if(ch == 'i'){ // show actual options info
                _options.showInfo = YGOptionShowInfoYES;
            }
        }
    }
}

@end
