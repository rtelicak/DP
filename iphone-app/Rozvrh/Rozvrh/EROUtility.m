//
//  EROUtility.m
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROUtility.h"

@implementation EROUtility

+(NSURL*)getWebServicePath {
    
    NSURL *webServicePath = [(EROAppDelegate *)[[UIApplication sharedApplication] delegate] webServiceBasePath];
    
    return webServicePath;
}

+(NSString*)getDatabasePath {
    
    NSString *databasePath = [(EROAppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    
    return databasePath;
}

@end
