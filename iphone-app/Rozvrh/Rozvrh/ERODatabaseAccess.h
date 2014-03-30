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

+ (void)insertFacultiesFromArray:(NSMutableArray*)facultiesArray;
+ (void)insertLessonsFromArray:(NSMutableArray*)lessonsArray;
+ (void)insertInstitutesFromArray:(NSMutableArray*)institutesArray;
+ (void)insertGroupsFromArray:(NSMutableArray*)groupsArray;
+ (void)insertRoomsFromArray:(NSMutableArray*)roomsArray;
+ (void)insertDepartmentsFromArray:(NSMutableArray*)departmentsArray;
+ (void)insertSubjectsFromArray:(NSMutableArray*)subjectsArray;
+ (void)insertTeachersFromArray:(NSMutableArray*)teachersArray;
+ (void)insertLecturesFromArray:(NSMutableArray*)lecturesArray;

+ (NSMutableArray *) getFacultiesFromDatabase;
+ (NSMutableArray *) getDepartmentsFromDatabaseByFacultyId: (int)facultyId andYear:(NSString *) year;
+ (NSMutableArray *) getGroupNumbersWithFacultyCode:(NSString*) facultyCode year:(NSString *) year andDepartmentCode:(NSString *) departmentCode;

@end
