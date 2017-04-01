//
//  main.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGApplication.h"
#import "YGCommand.h"
#import "YGOptions.h"

int main(int argc, const char * argv[]) {
#ifndef FUNC_DEBUG
#define FUNC_DEBUG
#endif
    @autoreleasepool {
                
        // singleton
        YGApplication *app = [YGApplication sharedInstance];
        
        // parse argument of command line
        if(argc == 1) //lsd
            [app defineOptions:nil];
        else if(argc == 2) //lsd -vs
            [app defineOptions:[NSString stringWithUTF8String:argv[1]]];
        
#ifdef FUNC_DEBUG
        // actual options
        printf("\n%s\n", [[app.options description] UTF8String]);
#endif
        
        // fabric command with options
        id<YGPrinting> command = [YGCommand commandWithOptions:[app options]];
        
        // result print
        [command print];
        
        printf("\n\n");
    }
    return 0;
}
