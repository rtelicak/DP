//
//  EROUtility.m
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROUtility.h"
#import "EROWebService.h"
#import "ERODatabaseAccess.h"
#import "EROScheduleSearchCriterion.h"

@implementation EROUtility

+ (NSURL*)getWebServicePath {
    
    NSURL *webServicePath = [(EROAppDelegate *)[[UIApplication sharedApplication] delegate] webServiceBasePath];
    
    return webServicePath;
}

+ (NSString*)getDatabasePath {
    
    NSString *databasePath = [(EROAppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    
    return databasePath;
}

+ (void) fillDatabase {
    NSLog(@"importing initialized ...");
    [self populateFaculties];
    [self populateLessons];
    [self populateInstitutes];
    [self populateGroups];
    [self populateRooms];
    [self populateDepartments];
    [self populateSubjects];
    [self populateTeachers];
    [self populateLectures];
    [self populateDays];
}

+ (NSMutableArray *)getFavouritesSelections {
    
    NSMutableArray *searchCriterionArray = [[NSMutableArray alloc] init];
    NSMutableArray *favouriteSearchCriteria = [[NSUserDefaults standardUserDefaults] objectForKey:@"EROFavourites"];
    
    NSLog(@"%@", favouriteSearchCriteria);
    
    for (int i = 0; i < [favouriteSearchCriteria count]; i++) {
        EROScheduleSearchCriterion *s = [[EROScheduleSearchCriterion alloc] init];
        
        s.facultyCode = [[favouriteSearchCriteria objectAtIndex:i] objectForKey:@"facultyCode"];
        s.departmentCode = [[favouriteSearchCriteria objectAtIndex:i] objectForKey:@"departmentCode"];
        s.year = [[favouriteSearchCriteria objectAtIndex:i] objectForKey:@"year"];
        s.groupNumber = [[favouriteSearchCriteria objectAtIndex:i] objectForKey:@"groupNumber"];
        
        [searchCriterionArray addObject:s];
    }
    
    return  searchCriterionArray;
}



// FACULTIES
+(void) populateFaculties {
    [[EROWebService sharedInstance] getFacultiesWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *facultiesArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertFacultiesFromArray:facultiesArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating faculties: %@", error);
    }];
}

// DAYS
+(void) populateDays {
    [[EROWebService sharedInstance] getDaysWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *daysArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertDaysFromArray:daysArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating days: %@", error);
    }];
}

// LESSONS
+(void) populateLessons {
    [[EROWebService sharedInstance] getLessonsWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *lessonsArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertLessonsFromArray:lessonsArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating lessons: %@", error);
    }];
}

// INSTITUTES
+(void) populateInstitutes {
    
    [[EROWebService sharedInstance] getInstitutesWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *instituteArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertInstitutesFromArray:instituteArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating institutes: %@", error);
    }];
    
}

// GROUPS
+(void) populateGroups {
    
    [[EROWebService sharedInstance] getGroupsWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *groupArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertGroupsFromArray:groupArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating groups: %@", error);
    }];
    
}

// ROOMS
+(void) populateRooms {
    
    [[EROWebService sharedInstance] getRoomsWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *roomArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertRoomsFromArray:roomArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating rooms: %@", error);
    }];
    
}

// DEPARMTNETS
+(void) populateDepartments {
    
    [[EROWebService sharedInstance] getDepartmentsWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *departmentArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertDepartmentsFromArray:departmentArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating departments: %@", error);
    }];
    
}

// SUBJECTS
+(void) populateSubjects {
    
    [[EROWebService sharedInstance] getSubjectsWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *subjectArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertSubjectsFromArray:subjectArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating subjects: %@", error);
    }];
    
}

// TEACHERS
+(void) populateTeachers {
    
    [[EROWebService sharedInstance] getTeachersWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *teacherArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertTeachersFromArray:teacherArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating teachers: %@", error);
    }];
    
}

// LECTURES
+(void) populateLectures {
    [[EROWebService sharedInstance] getLecturesWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *lectureArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertLecturesFromArray:lectureArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating lectures: %@", error);
    }];
    
}


@end
