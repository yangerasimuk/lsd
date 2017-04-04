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

    @autoreleasepool {
        
        // single
        YGApplication *app = [YGApplication sharedInstance];
        
        // parse arguments in command line
        if(argc == 1) //lsd
            [app defineOptions:nil];
        else if(argc == 2) //lsd -vs
            [app defineOptions:[NSString stringWithUTF8String:argv[1]]];
        
        // print options for testing
        if([app options].showInfo == YGOptionShowInfoYes)
            printf("%s\n\n", [[app.options description] UTF8String]);
        
        // fabric command creation with options
        id<YGPrinting> command = [YGCommand commandWithOptions:[app options]];
        
        // result print
        [command print];
        
    }
    
    return 0;
}
