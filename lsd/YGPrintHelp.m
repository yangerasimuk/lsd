//
//  YGPrintHelp.m
//  lsd
//
//  Created by Ян on 02/04/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGPrintHelp.h"
#import "defineConstants.h"

@implementation YGPrintHelp

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
 Print help info about application.
 */
- (void)print{
    
    // nice output with separate line
    if(self.options.addSeparateLine == YGOptionAddSeparateLineYes)
        printf("\n");
    
    printf("lsd. List directories for macOS. Version: %s, build %s. %s", kLsdVersion, kLsdBuild, kLsdAuthor);
    printf("\nUsage: lsd -[lv?adncmsbeh] \
           \n\tl - print directories in line (default), \
           \n\tv - print directories in vertical colomn, \
           \n\t? - print help (this info), \
           \n\ta - ascending sort, \
           \n\td - descending sort (default), \
           \n\tn - sort by name (default), \
           \n\tc - sort by created date, \
           \n\tm - sort by modified date, \
           \n\ts - sort by size (attention! may spend a long time), \
           \n\tb - basic show mode (only directory name), \
           \n\te - extended show mode (more info about date or size), \
           \n\th - show hidden/dotted directories. \
           ");
    
    printf("\nConfig file: ~/.lsd.config.xml");
    printf("\nMIT license. Sources: https://github.com/yangerasimuk/lsd");
    
    // nice output with separate line
    if(self.options.addSeparateLine == YGOptionAddSeparateLineYes)
        printf("\n");
    printf("\n");
}

@end
