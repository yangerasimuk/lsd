//
//  YGApplication.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGOptions.h"
#import "YGPreferences.h"

@interface YGApplication : NSObject

+ (YGApplication *) sharedInstance;
- (void) defineOptions:(NSString *)args;

/// Options overrided by user, get from command line
@property (readonly) YGOptions *options;

/// Options by default, get from config
@property (readonly) YGPreferences *preferences;

@end
