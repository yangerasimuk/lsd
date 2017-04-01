//
//  YGCommand.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGOptions.h"

@protocol YGPrinting

- (void)print;

@end

@interface YGCommand : NSObject

- (instancetype)initWithOptions:(YGOptions *)options;
+ (id<YGPrinting>)commandWithOptions:(YGOptions *)options;

@property YGOptions *options;

@end
