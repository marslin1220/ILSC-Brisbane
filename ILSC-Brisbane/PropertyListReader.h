//
//  PropertyListReader.h
//  ILSC-Brisbane
//
//  Created by 林 政龍 on 2014/7/16.
//  Copyright (c) 2014年 marstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyListReader : NSObject

+ (NSDictionary *)getDataByPropertyListFileName:(NSString *)propertyListFileName;

@end
