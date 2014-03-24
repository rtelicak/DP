//
//  ERODatabaseAccess.h
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "EROUtility.h"


@interface ERODatabaseAccess : NSObject

+(void)insertFacultiesFromArray:(NSMutableArray*)facultiesArray;
+(void)insertLessonsFromArray:(NSMutableArray*)lessonsArray;
+(void)insertInstitutesFromArray:(NSMutableArray*)instituteArray;
+(void)insertGroupsFromArray:(NSMutableArray*)instituteArray;

@end
