//
//  YGDirectory.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGDirectory.h"

@implementation YGDirectory

-(instancetype)initWithName:(NSString *)name atPath:(NSString *)path{
    self = [super init];
    if(self){
        _name = [name copy];
        _fullName = [NSString stringWithFormat:@"%@/%@", path, name];
    }
    return self;
}

- (instancetype) initWithName:(NSString *)name{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [self initWithName:name atPath:[fm currentDirectoryPath]];
}

@end
