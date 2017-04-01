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
#import "YGPrintVerticalSize.h"

@implementation YGCommand

- (instancetype)initWithOptions:(YGOptions *)options{
    self = [super init];
    if(self){
        _options = options;
    }
    return self;
}

+ (id<YGPrinting>)commandWithOptions:(YGOptions *)options{
    
    id<YGPrinting> command = nil;
    
    if(options.printType == YGOptionPrintTypeLine){
        command = [[YGPrintLine alloc] initWithOptions:options];
    }
    else if(options.printType == YGOptionPrintTypeVertical){
        command = [[YGPrintVertical alloc] initWithOptions:options];
    }
    
    return command;
}

@end
