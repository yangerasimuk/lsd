//
//  YGDirectory.m
//  lsd
//
//  Created by Ян on 31/03/2017.
//  Copyright © 2017 Yan Gerasimuk. All rights reserved.
//

#import "YGDirectory.h"

#import "defineConstants.h"

@interface YGDirectory()
+ (NSUInteger)recursiveWalkIn:(NSString *)dir;
- (NSUInteger)calcSize;
- (id) attributeOfDirectoryByString:(NSString *)attribute;
@end

@implementation YGDirectory

/**
 Base init, set all properties of directory. Selective, lazy creation of directory: init only name, path, is dotted flag and property from sortBy argument.
 
    - name: directory name,
 
    - path: directory path,
 
    - sortBy: directory property for sort in print command,
 
    - return: YGDirectory instance.
 */
-(instancetype)initWithName:(NSString *)name atPath:(NSString *)path sortBy:(YGOptionSortBy)sortBy{
    self = [super init];
    if(self){
        _name = [name copy];
        _fullName = [NSString stringWithFormat:@"%@/%@", path, name];
        if([_name characterAtIndex:0] == '.')
            _isDotted = YES;
        else
            _isDotted = NO;

        if(sortBy == YGOptionSortByCreated)
            _created = [self attributeOfDirectoryByString:@"NSFileCreationDate"];
        else if(sortBy == YGOptionSortByModified)
            _modified = [self attributeOfDirectoryByString:@"NSFileModificationDate"];
        else if(sortBy == YGOptionSortBySize)
            _size = [self calcSize];
    }
    return self;
}

/**
 Wrapper for base init, with name and path, and default argument sortBy.
 */
-(instancetype)initWithName:(NSString *)name atPath:(NSString *)path{
    return [self initWithName:name atPath:path sortBy:YGOptionSortByName];
}

/**
 Wrapper for base init, with name, current path and default argument sortBy.
 */
- (instancetype) initWithName:(NSString *)name{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [self initWithName:name atPath:[fm currentDirectoryPath] sortBy:YGOptionSortByName];
}

/**
 Recursive walk in all subdirectories of directory for getting size of directory.
 
    - dir: directory for begining walk,
 
    - return: sum of all files sizes.
 */
+ (NSUInteger)recursiveWalkIn:(NSString *)dir{
        
    NSUInteger acc = 0;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *de = [fm enumeratorAtPath:dir];
    id fsObject = nil;
    BOOL isDir = NO;
    NSError *error = nil;
    
    while(fsObject = [de nextObject]){
        [de skipDescendants];
        
        NSString *fsObjectPath = [NSString stringWithFormat:@"%@/%@", dir, fsObject];
        
        if([fm fileExistsAtPath:fsObjectPath isDirectory:&isDir]){
            
            if(isDir){
                
                acc += [YGDirectory recursiveWalkIn:[NSString stringWithFormat:@"%@", fsObjectPath]];
                
            }
            else{
                NSDictionary *attr = [fm attributesOfItemAtPath:[NSString stringWithFormat:@"%@", fsObjectPath] error:&error];
                                
                NSNumber *number = [NSNumber numberWithLong:0];
                number = [attr valueForKey:@"NSFileSize"];
                acc += [number unsignedIntegerValue];
                
                if(error){
                    printf("\n%s. Error: %s", [fsObjectPath UTF8String], [[error description] UTF8String]);
                }
            }
            
        }
        else{
            printf("\n%s is not exists.", [fsObjectPath UTF8String]);
        }
    }
    
    return acc;
}

/**
 Calc size of directory. Wrapper on recursive message recursiveWalkIn.
 */
- (NSUInteger)calcSize{
    return [YGDirectory recursiveWalkIn:_fullName];
}

/**
 Getting file attribute of current directory by attribute name.
 
    - attribute: name of attribute,
 
    - return: id object of attribute. NSUInteger, NSDate, NSString etc.
 */
- (id)attributeOfDirectoryByString:(NSString *)attribute{

    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attr = [fm attributesOfItemAtPath:_fullName error:&error];
    
    if(error){
        printf("\n%s. Error: %s", [_fullName UTF8String], [[error description] UTF8String]);
    }
    
    return [attr valueForKey:attribute];
}

@end
