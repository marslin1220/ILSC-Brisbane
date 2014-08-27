//
//  PropertyListReader.m
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/7/16.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import "PropertyListReader.h"

@implementation PropertyListReader

+ (NSDictionary *)getDataByPropertyListFileName:(NSString *)propertyListFileName
{
    NSError *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath = [PropertyListReader getPropertyListPathWithFilename:propertyListFileName];

    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *properties = (NSDictionary *)[NSPropertyListSerialization
                                                propertyListWithData:plistXML
                                                options:NSPropertyListMutableContainersAndLeaves
                                                format:&format
                                                error:&errorDesc];
    if (!properties) {
        NSLog(@"Error reading plist: %@, format: %u", errorDesc, format);
    }

    return properties;
}

+ (NSString *)getPropertyListPathWithFilename:(NSString *)propertyListFileName
{
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", propertyListFileName, @"plist"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:propertyListFileName ofType:@"plist"];
    }

    return plistPath;
}

@end
