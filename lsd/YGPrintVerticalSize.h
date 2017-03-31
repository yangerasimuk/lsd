//
//  YGPrintVerticalSize.h
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGCommand.h"

@interface YGPrintVerticalSize : YGCommand <YGPrinting>

- (instancetype)initWithOptions:(YGOptions *)options;
- (void)print;


@end
