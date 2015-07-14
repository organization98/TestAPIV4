//
//  NSDictionary+DictionaryFromJSON.h
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/14/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DictionaryFromJSON)

+ (NSDictionary *)dictionaryFromJSON:(NSData *)data with:(NSError *)error;

@end
