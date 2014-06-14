//
//  EROUtility.h
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EROAppDelegate.h"
#import "sqlite3.h"

@interface EROUtility : NSObject

+ (NSURL *) getWebServicePath;
+ (NSString *) getDatabasePath;
+ (NSString *) getDatabaseName;
+ (NSMutableArray *)getFavouritesSelections;
+ (BOOL) getDatabaseUpdateStatus;
+ (void) setDatabaseUpdateStatus:(BOOL) status reason:(NSString*) reason;
+ (void) emptyFavoriteList;

+ (void) fillDatabase;
+ (void) createAndFillDatabase;


@end
