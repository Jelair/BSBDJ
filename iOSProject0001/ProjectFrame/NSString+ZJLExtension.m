//
//  NSString+ZJLExtension.m
//  iOSProject0001
//
//  Created by NowOrNever on 31/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "NSString+ZJLExtension.h"

@implementation NSString (ZJLExtension)

- (unsigned long long)fileSize{
    unsigned long long size = 0;
    
    NSFileManager *fmr = [NSFileManager defaultManager];
    //NSArray *subpaths = [fmr subpathsAtPath:self];
    NSDictionary *attr = [fmr attributesOfItemAtPath:self error:nil];
    if([attr.fileType isEqualToString:@"NSFileTypeDirectory"]){
        NSDirectoryEnumerator *enumerator = [fmr enumeratorAtPath:self];
        for (NSString *subpath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subpath];
            NSDictionary *attr = [fmr attributesOfItemAtPath:fullPath error:nil];
            size += [attr[NSFileSize] unsignedIntegerValue];
        }
    }else{
        size = attr.fileSize;
    }
    
    
    return size;
}
@end
