//
//  ERODatabaseAccess.m
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "ERODatabaseAccess.h"

@implementation ERODatabaseAccess

// FACULTY
+(void)insertFacultiesFromArray:(NSMutableArray*)facultiesArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM fakulta"];
    
    for (id faculty in facultiesArray) {
        [db executeUpdate:@"INSERT INTO fakulta (kod, nazov) VALUES (?,?);", [faculty objectForKey:@"kod"], [faculty objectForKey:@"nazov"]];
    }
    
    [db close];
}

// LESSON
+(void) insertLessonsFromArray:(NSMutableArray *)lessonsArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM hodina"];
    
    for (id lesson in lessonsArray) {
        [db executeUpdate:@"INSERT INTO hodina (cislo, cas_od, cas_do) VALUES (?,?,?);", [lesson objectForKey:@"cislo"], [lesson objectForKey:@"cas_od"], [lesson objectForKey:@"cas_do"]];
    }
    
    [db close];
}

// INSTITUTE
+(void) insertInstitutesFromArray:(NSMutableArray *)instituteArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM katedra"];
    
    for (id institute in instituteArray) {
        [db executeUpdate:@"INSERT INTO katedra (kod, nazov, id_fakulta) VALUES (?,?,?);", [institute objectForKey:@"kod"], [institute objectForKey:@"nazov"], [[institute objectForKey:@"id_fakulta"] integerValue]];
    }
    
    [db close];
}

// GROUPS
+(void)insertGroupsFromArray:(NSMutableArray*)groupArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM kruzok"];
    
    for (id group in groupArray) {
        [db executeUpdate:@"INSERT INTO kruzok (kod, cislo, nazov, id_odbor) VALUES (?,?,?,?);", [group objectForKey:@"kod"], [group objectForKey:@"cislo"], [group objectForKey:@"nazov"], [group objectForKey:@"id_odbor"]];
    }
    
    [db close];
    
}

@end
