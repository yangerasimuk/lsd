//
//  YGCommand.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGCommand.h"
#import "YGPrintLine.h"
#import "YGPrintVertical.h"
#import "YGPrintHelp.h"

@implementation YGCommand

/**
 Base init, set command options.
 */
- (instancetype)initWithOptions:(YGOptions *)options{
    self = [super init];
    if(self){
        _options = options;
    }
    return self;
}

/**
 Fabric message for creation new command in depends of actual options.
 
 - options: actual options of command.
 
 - return: object with print message. YGPrintLine, YGPrintVertical or YGPrintHelp.
 */
+ (id<YGPrinting>)commandWithOptions:(YGOptions *)options{
    
    id<YGPrinting> command = nil;
    
    if(options.printType == YGOptionPrintTypeLine){
        command = [[YGPrintLine alloc] initWithOptions:options];
    }
    else if(options.printType == YGOptionPrintTypeVertical){
        command = [[YGPrintVertical alloc] initWithOptions:options];
    }
    else
        command = [[YGPrintHelp alloc] initWithOptions:options];
    
    return command;
}

@end
