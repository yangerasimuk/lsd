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

@property (readonly) YGOptions *options;
@property (readonly) YGPreferences *preferences;

@end
