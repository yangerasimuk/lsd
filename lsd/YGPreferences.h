//
//  YGPreferences.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGOptions.h"
#import "YGConfig.h"

@interface YGPreferences : NSObject

- (instancetype) init;

/// Default options for command, get from config
@property YGOptions *options;

@end
