//
//  EROUtility.h
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EROAppDelegate.h"

@interface EROUtility : NSObject

+(NSURL *) getWebServicePath;
+(NSString *) getDatabasePath;

+(void) fillDatabase;

@end
