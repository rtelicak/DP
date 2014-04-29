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

+ (NSString*)getDatabaseName {
    
    NSString *databasePath = [(EROAppDelegate *)[[UIApplication sharedApplication] delegate] databaseName];
    
    return databasePath;
}

+ (void) fillDatabase {
    NSLog(@"importing initialized ...");

    [self populateLectures];
    [self populateLessons];
    [self populateFaculties];
    [self populateInstitutes];
    [self populateGroups];
    [self populateRooms];
    [self populateDepartments];
    [self populateSubjects];
    [self populateTeachers];
    [self populateDays];
    [self populateVersion];
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

+ (BOOL) getDatabaseUpdateStatus {

    NSDictionary *statusDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"isDatabaseUpdateNeeded"];
        
    BOOL updateDB = [[statusDictionary objectForKey:@"status"] boolValue];
    
    return updateDB;
}

+ (void) setDatabaseUpdateStatus: (BOOL) status reason:(NSString *)reason{
    
    // popup alertview
    if ([reason isEqualToString:@"error"]) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"errorOccuredWhileInsertingData" object:self userInfo:nil];
    }
    
    NSNumber *boolStatusNumber = [NSNumber numberWithBool:status];
    
    NSDictionary *d = @{
                        @"status": boolStatusNumber,
                        @"reason": reason
                        };
    
    [[NSUserDefaults standardUserDefaults] setObject:d forKey:@"isDatabaseUpdateNeeded"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
    }];
}

// DAYS
+(void) populateVersion {
    [[EROWebService sharedInstance] getVersionWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        NSMutableArray *versionArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertVersionFromArray:versionArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating version: %@", error);
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
       [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
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
        [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
    }];
    
}

+ (void)createAndFillDatabase {
    sqlite3 *rozvrhDB;
    NSString *databasePath = [self getDatabasePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:databasePath]) {
        [fileManager removeItemAtPath:databasePath error:NULL];
    }
    
    if (sqlite3_open([databasePath UTF8String], &rozvrhDB) == SQLITE_OK)
    {
        NSMutableArray *queryArray = [[NSMutableArray alloc] initWithObjects:
                             @"CREATE TABLE den (id_den INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL, den varchar(10) NOT NULL)",
                             @"CREATE TABLE fakulta (id_fakulta integer primary key, kod varchar(10), nazov varchar(250))",
                             @"CREATE TABLE hodina (id_hodina integer primary key, cislo integer, cas_od varchar(20), cas_do varchar(20))",
                             @"CREATE TABLE katedra (id_katedra INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , id_fakulta INTEGER, kod VARCHAR, nazov VARCHAR)",
                             @"CREATE TABLE kruzok (id_kruzok INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , kod VARCHAR, cislo INTEGER, nazov VARCHAR, id_odbor INTEGER)",
                             @"CREATE TABLE miestnost (id_miestnost INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , kod VARCHAR, nazov VARCHAR, kapacita VARCHAR)",
                             @"CREATE TABLE odbor (id_odbor INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , kod VARCHAR, nazov VARCHAR, pocet_studentov INTEGER, id_fakulta INTEGER, rocnik INTEGER)",
                             @"CREATE TABLE predmet (id_predmet INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE,kod VARCHAR,nazov Varchar,skratka VARCHAR,vymera VARCHAR,prednaska INTEGER,povinny INTEGER,semester INTEGER)",
                             @"CREATE TABLE ucitel (id_ucitel INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , id_katedra INTEGER, kod VARCHAR, priezvisko VARCHAR, meno VARCHAR, titul VARCHAR, titul_za VARCHAR)",
                             @"CREATE TABLE verzia (id_verzia integer primary key, verzia varchar(50))",
                             @"CREATE TABLE vyuka (id_vyuka INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE,id_kruzok INTEGER,id_den INTEGER,id_hodina INTEGER,id_predmet INTEGER,prednaska INTEGER,id_miestnost INTEGER,id_ucitel INTEGER,polrok VARCHAR,id_rozvrh INTEGER);",
                            nil];
        
        char *errMsg;
        
        for (int i = 0; i < [queryArray count]; i++) {
            
            NSString *query = [NSString stringWithFormat:@"%@", [queryArray objectAtIndex:i]];
            const char *sql_stmt = [query cStringUsingEncoding:NSASCIIStringEncoding];
            
            if (sqlite3_exec(rozvrhDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
                [EROUtility setDatabaseUpdateStatus:YES reason:@"error"];
            }
        }
        
        sqlite3_close(rozvrhDB);
        
        [EROUtility fillDatabase];
        
    } else {
        NSLog(@"Failed to open/create database");
    }
    
}






































@end
