//
//  FileManager.m
//  Buoi 16 bvn
//
//  Created by doductrung on 7/9/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager
- (NSMutableArray *) contentOfAppBundle: (NSURL*) bundleDir
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error;
    NSArray *propertiesToGet = @[
                                 NSURLIsDirectoryKey,
                                 NSURLIsReadableKey,
                                 NSURLCreationDateKey,
                                 NSURLContentAccessDateKey,
                                 NSURLContentModificationDateKey];// Add nil if property declare is NSMutableArray
    
   NSArray *result = [fileManager contentsOfDirectoryAtURL:bundleDir includingPropertiesForKeys:propertiesToGet options:0 error:&error];
    NSMutableArray *resultArray = [NSMutableArray arrayWithArray:result];
    if(error!=nil){
        NSLog(@"Error :%@", error);
    }
    return resultArray;
}
- (NSString*) stringValueOfBoolValue: (NSString*) property
                               ofURL:(NSURL*) url
{
    NSNumber *boolValue = nil;
    NSError *error = nil;
    [url getResourceValue:&boolValue forKey:property error:&error];
    if(error!=nil){
        NSLog(@"Failed to get property of url");
    }
    return [boolValue isEqualToNumber:@YES]?@"YES":@"NO";
}
- (void) printURLProperty: (NSURL*) url
{
    NSDate *date = nil;
    NSError *error = nil;
    NSLog(@"Item name: %@", [url lastPathComponent]);
    NSLog(@"Is a directory: %@", [self stringValueOfBoolValue:NSURLIsDirectoryKey ofURL:url]);
    NSLog(@"Is a readable: %@", [self stringValueOfBoolValue:NSURLIsReadableKey ofURL:url]);
    [url getResourceValue:&date forKey:NSURLCreationDateKey error:&error];
    NSLog(@"Creation date: %@", date);
    [url getResourceValue:&date forKey:NSURLContentAccessDateKey error:&error];
    NSLog(@"Access date: %@", date);
    [url getResourceValue:&date forKey:NSURLContentModificationDateKey error:&error];
    NSLog(@"Modification date: %@", date);
}

@end
