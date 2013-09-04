//
//  FileManager.h
//  Buoi 16 bvn
//
//  Created by doductrung on 7/9/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
- (NSMutableArray *) contentOfAppBundle: (NSURL*) bundleDir;
- (void) printURLProperty: (NSURL*) url;
- (NSString*) stringValueOfBoolValue: (NSString*) property
                               ofURL:(NSURL*) url;
@end
