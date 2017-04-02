//
//  YGPrintHelp.h
//  lsd
//
//  Created by Ян on 02/04/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGCommand.h"

@interface YGPrintHelp : YGCommand <YGPrinting>

- (instancetype)initWithOptions:(YGOptions *)options;
- (void)print;

@end
