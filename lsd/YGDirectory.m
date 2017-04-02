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
- (id) attributeOfDirectoryByString:(NSString *)attribute;
+ (NSUInteger)recursiveWalkIn:(NSString *)dir;
@end

@implementation YGDirectory

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


+ (NSUInteger)recursiveWalkIn:(NSString *)dir{
    
    NSUInteger acc = 0;

    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *de = [fm enumeratorAtPath:dir];
    //NSString *curDir = [fm currentDirectoryPath];
    id fsObject = nil;
    BOOL isDir = NO;
    NSError *error = nil;
    
    //printf("\ndir: %s", [dir UTF8String]);
    //printf("\ncurDir: %s", [curDir UTF8String]);
    //printf("\n%s", [ UTF8String]);

    while(fsObject = [de nextObject]){
        [de skipDescendants];
        
        //printf("\nnextObject: %s", [fsObject UTF8String]);
        
        NSString *fsObjectPath = [NSString stringWithFormat:@"%@/%@", dir, fsObject];
        
        //printf("\nfsObjectPath: %s", [fsObjectPath UTF8String]);
        
        if([fm fileExistsAtPath:fsObjectPath isDirectory:&isDir]){
            
            if(isDir){
                acc += [YGDirectory recursiveWalkIn:[NSString stringWithFormat:@"%@", fsObjectPath]];
            }
            else{
                NSDictionary *attr = [fm attributesOfItemAtPath:[NSString stringWithFormat:@"%@", fsObjectPath] error:&error];
                
                //NSLog(@"%@", [attr valueForKey:@"NSFileSize"]);
                //NSUInteger size = (unsigned long long)[attr valueForKey:@"NSFileSize"];
                
                NSNumber *number = [NSNumber numberWithLong:0];
                number = [attr valueForKey:@"NSFileSize"];
                acc += [number longLongValue]; //[attr valueForKey:@"NSFileSize"];
                
                //printf("\tsize = %lu", size);
                
                if(error){
                    //printf("\nError: %s", [[error description] UTF8String]);
                }
            }
            
        }
        else{
            //printf("\nFile is not exists...");
        }
    }
    
    return acc;
}

/**
 Calc size of directory. Wrapper on recursive function.
 */
- (NSUInteger)calcSize{
    return [YGDirectory recursiveWalkIn:_fullName];
}

-(instancetype)initWithName:(NSString *)name atPath:(NSString *)path{
    return [self initWithName:name atPath:path sortBy:YGOptionSortByName];
}

- (instancetype) initWithName:(NSString *)name{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [self initWithName:name atPath:[fm currentDirectoryPath] sortBy:YGOptionSortByName];
}


- (id)attributeOfDirectoryByString:(NSString *)attribute{

    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attr = [fm attributesOfItemAtPath:_fullName error:&error];
    
    return [attr valueForKey:attribute];
}

@end
