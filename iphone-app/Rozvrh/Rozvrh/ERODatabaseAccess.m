//
//  ERODatabaseAccess.m
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "ERODatabaseAccess.h"
#import "EROFaculty.h"

@implementation ERODatabaseAccess

// FACULTY
+(void)insertFacultiesFromArray:(NSMutableArray*)facultiesArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM fakulta"];
    
    for (id faculty in facultiesArray) {
        [db executeUpdate:@"INSERT INTO fakulta (id_fakulta, kod, nazov) VALUES (?,?,?);", [faculty objectForKey:@"id_fakulta"], [faculty objectForKey:@"kod"], [faculty objectForKey:@"nazov"]];
    }
    
    [db close];
    NSLog(@"faculties done");
}

// LESSON
+(void) insertLessonsFromArray:(NSMutableArray *)lessonsArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM hodina"];
    
    for (id lesson in lessonsArray) {
        [db executeUpdate:@"INSERT INTO hodina (id_hodina, cislo, cas_od, cas_do) VALUES (?,?,?, ?);",[lesson objectForKey:@"id_hodina"], [lesson objectForKey:@"cislo"], [lesson objectForKey:@"cas_od"], [lesson objectForKey:@"cas_do"]];
    }
    
    [db close];
    NSLog(@"lessons done");
}

// INSTITUTE
+(void) insertInstitutesFromArray:(NSMutableArray *)institutesArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM katedra"];
    
    for (id institute in institutesArray) {
        [db executeUpdate:@"INSERT INTO katedra (id_katedra, kod, nazov, id_fakulta) VALUES (?,?,?,?);", [institute objectForKey:@"id_katedra"], [institute objectForKey:@"kod"], [institute objectForKey:@"nazov"], [[institute objectForKey:@"id_fakulta"] integerValue]];
    }
    
    [db close];
    NSLog(@"institutes done");
}

// GROUPS
+(void)insertGroupsFromArray:(NSMutableArray*)groupsArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM kruzok"];
    
    for (id group in groupsArray) {
        [db executeUpdate:@"INSERT INTO kruzok (id_kruzok, kod, cislo, nazov, id_odbor) VALUES (?,?,?,?,?);", [group objectForKey:@"id_kruzok"], [group objectForKey:@"kod"], [group objectForKey:@"cislo"], [group objectForKey:@"nazov"], [group objectForKey:@"id_odbor"]];
    }
    
    [db close];
    NSLog(@"groups done");
}

// ROOMS
+(void)insertRoomsFromArray:(NSMutableArray*)roomsArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM miestnost"];
    
    for (id room in roomsArray) {
        [db executeUpdate:@"INSERT INTO miestnost (id_miestnost, kod, nazov, kapacita) VALUES (?,?,?,?);", [room objectForKey:@"id_miestnost"], [room objectForKey:@"kod"], [room objectForKey:@"nazov"], [room objectForKey:@"kapacita"]];
    }
    
    [db close];
    NSLog(@"rooms done");
}

// DEPARTMENT
+(void)insertDepartmentsFromArray:(NSMutableArray*)departmentsArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM odbor"];
    
    for (id department in departmentsArray) {
        [db executeUpdate:@"INSERT INTO odbor (id_odbor, kod, nazov, pocet_studentov, id_fakulta, rocnik) VALUES (?,?,?,?,?,?);", [department objectForKey:@"id_odbor"], [department objectForKey:@"kod"], [department objectForKey:@"nazov"], [department objectForKey:@"pocet_studentov"], [department objectForKey:@"id_fakulta"], [department objectForKey:@"rocnik"]];
    }
    
    [db close];
    NSLog(@"departments done");
}

// SUBJECTS
+(void)insertSubjectsFromArray:(NSMutableArray*)subjectsArray {
 
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM predmet"];
    
    for (id subject in subjectsArray) {
        [db executeUpdate:@"INSERT INTO predmet (id_predmet, kod, nazov, skratka, vymera, prednaska, povinny, semester) VALUES (?,?,?,?,?,?,?,?);", [subject objectForKey:@"id_predmet"], [subject objectForKey:@"kod"], [subject objectForKey:@"nazov"], [subject objectForKey:@"skratka"], [subject objectForKey:@"vymera"], [subject objectForKey:@"prednaska"], [subject objectForKey:@"povinny"], [subject objectForKey:@"semester"]];
    }
    
    [db close];
    NSLog(@"subjects done");
}

// TEACHERS
+(void)insertTeachersFromArray:(NSMutableArray*)teachersArray {
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM ucitel"];
    
    for (id teacher in teachersArray) {
        [db executeUpdate:@"INSERT INTO ucitel (id_ucitel, id_katedra, kod, priezvisko, meno, titul, titul_za) VALUES (?,?,?,?,?,?,?);", [teacher objectForKey:@"id_ucitel"], [teacher objectForKey:@"id_katedra"], [teacher objectForKey:@"kod"], [teacher objectForKey:@"priezvisko"], [teacher objectForKey:@"meno"], [teacher objectForKey:@"titul"], [teacher objectForKey:@"titul_za"]];
    }
    
    [db close];
    NSLog(@"teachers done");
}

// LECTURES
+(void)insertLecturesFromArray:(NSMutableArray *)lecturesArray {
    NSLog(@"importing lectures ...");
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM vyuka"];
    
    for (id lecture in lecturesArray) {
        [db executeUpdate:@"INSERT INTO vyuka (id_vyuka, id_kruzok, id_den, id_hodina, id_predmet, prednaska, id_miestnost, id_ucitel) VALUES (?,?,?,?,?,?,?,?);", [lecture objectForKey:@"id_vyuka"], [lecture objectForKey:@"id_kruzok"], [lecture objectForKey:@"id_den"], [lecture objectForKey:@"id_hodina"], [lecture objectForKey:@"id_predmet"], [lecture objectForKey:@"prednaska"], [lecture objectForKey:@"id_miestnost"], [lecture objectForKey:@"id_ucitel"]];
    }
    
    [db close];
    NSLog(@"lectures done");
    NSLog(@"importing to db done.");
}

+(void)insertDaysFromArray:(NSMutableArray *)daysArray {
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    [db executeUpdate:@"DELETE FROM den"];
    
    for (id day in daysArray) {
        [db executeUpdate:@"INSERT INTO den (id_den, den) VALUES (?,?);", [day objectForKey:@"id_den"], [day objectForKey:@"den"]];
    }
    
    [db close];
    NSLog(@"days done");
}

///////////////////////////
// GET THINGS FROM DATABASE
///////////////////////////

+ (NSMutableArray *)getFacultiesFromDatabase {
    NSMutableArray *faculties = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM fakulta"];

    
    while ([result next]) {
        EROFaculty *f = [[EROFaculty alloc] init];
        
        f.id_fakulta = [result intForColumn:@"id_fakulta"];
        f.kod = [result stringForColumn:@"kod"];
        f.nazov = [result stringForColumn:@"nazov"];
        [faculties addObject:f];
    }
    
    [db close];
    
    return faculties;
}

+ (NSMutableArray *)getDepartmentsFromDatabaseByFacultyId:(int)facultyId andYear:(NSString *)year {
    
    NSMutableArray *departmentCodes = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    FMResultSet *result = [db executeQuery:@"SELECT distinct(kod) FROM odbor WHERE id_fakulta = (?) AND rocnik = (?)", [NSString stringWithFormat:@"%d", facultyId], year];
    
    NSLog(@"SELECT distinct(kod) FROM odbor WHERE id_fakulta = %@ AND rocnik = %@", [NSString stringWithFormat:@"%d", facultyId], year);
    
    while ([result next]) {
        
        NSString *departmentCode =  [NSString stringWithFormat:@"%@", [result stringForColumn:@"kod"]];
        
        [departmentCodes addObject:departmentCode];
    }
    
    [db close];

    return departmentCodes;
}

+ (NSMutableArray *) getGroupNumbersWithFacultyCode:(NSString*) facultyCode year:(NSString *) year andDepartmentCode:(NSString *) departmentCode {
    
    NSMutableArray *groupNumbers = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    FMResultSet *result = [db executeQuery:@"select kruzok.cislo from kruzok left join odbor on kruzok.id_odbor = odbor.id_odbor left join fakulta on odbor.id_fakulta = odbor.id_fakulta where fakulta.kod = (?) AND odbor.rocnik = (?) AND odbor.kod = (?)", facultyCode, year, departmentCode];
    
    NSLog(@"select kruzok.cislo from kruzok left join odbor on kruzok.id_odbor = odbor.id_odbor left join fakulta on odbor.id_fakulta = odbor.id_fakulta where fakulta.kod = %@ AND odbor.rocnik = %@ AND odbor.kod = %@", facultyCode, year, departmentCode);
    
    while ([result next]) {
        
        NSString *groupNumber =  [NSString stringWithFormat:@"%d", [result intForColumn:@"cislo"]];
        
        [groupNumbers addObject:groupNumber];
    }
    
    [db close];

    
    return groupNumbers;
}

+(NSMutableArray *)getLessonsWithFacultyCode:(NSString *)facultyCode year:(NSString *)year departmentCode:(NSString *)departmentCode groupNumber:(NSString *)groupNumber {
    
    NSMutableArray *lectures = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    FMResultSet *result = [db executeQuery:@"select id_vyuka, vyuka.prednaska, predmet.nazov, predmet.vymera, predmet.povinny, ucitel.meno, ucitel.priezvisko, ucitel.titul, miestnost.nazov as miestnost, den.den, den.id_den, hodina.cas_od, hodina.cas_do from vyuka left join den on vyuka.id_den = den.id_den left join hodina on vyuka.id_hodina = hodina.id_hodina left join ucitel on vyuka.id_ucitel = ucitel.id_ucitel left join miestnost on vyuka.id_miestnost = miestnost.id_miestnost left join predmet on vyuka.id_predmet = predmet.id_predmet left join kruzok on vyuka.id_kruzok = kruzok.id_kruzok left join odbor on kruzok.id_odbor = odbor.id_odbor left join fakulta on odbor.id_fakulta = fakulta.id_fakulta  where kruzok.cislo = (?) AND odbor.kod = (?) AND odbor.rocnik = (?) AND fakulta.kod = (?) order by den.id_den, hodina.id_hodina", groupNumber, departmentCode, year, facultyCode];
    
    NSLog(@"select id_vyuka, vyuka.prednaska, predmet.nazov, predmet.vymera, predmet.povinny, ucitel.meno, ucitel.priezvisko, ucitel.titul, miestnost.nazov as miestnost, den.den, den.id_den, hodina.cas_od, hodina.cas_do from vyuka left join den on vyuka.id_den = den.id_den left join hodina on vyuka.id_hodina = hodina.id_hodina left join ucitel on vyuka.id_ucitel = ucitel.id_ucitel left join miestnost on vyuka.id_miestnost = miestnost.id_miestnost left join predmet on vyuka.id_predmet = predmet.id_predmet left join kruzok on vyuka.id_kruzok = kruzok.id_kruzok left join odbor on kruzok.id_odbor = odbor.id_odbor left join fakulta on odbor.id_fakulta = fakulta.id_fakulta where kruzok.cislo = %@ AND odbor.kod = %@ AND odbor.rocnik = %@ AND fakulta.kod = %@ order by den.id_den, hodina.id_hodina" , groupNumber, departmentCode, year, facultyCode);
    
    
    while ([result next]) {
        [self buildLectureWithResult: result];

        NSDictionary *lecture = [self buildLectureWithResult:result];
        
        [lectures addObject:lecture];
    }
    
    [db close];
    
    return lectures;
}

+(NSMutableArray *)getLecturesOnlyWithFacultyCode:(NSString *)facultyCode year:(NSString *)year departmentCode:(NSString *)departmentCode groupNumber:(NSString *)groupNumber {
    
    NSMutableArray *lectures = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    FMResultSet *result = [db executeQuery:@"select id_vyuka, vyuka.prednaska, predmet.nazov, predmet.vymera, predmet.povinny, ucitel.meno, ucitel.priezvisko, ucitel.titul, miestnost.nazov as miestnost, den.den, den.id_den, hodina.cas_od, hodina.cas_do from vyuka left join den on vyuka.id_den = den.id_den left join hodina on vyuka.id_hodina = hodina.id_hodina left join ucitel on vyuka.id_ucitel = ucitel.id_ucitel left join miestnost on vyuka.id_miestnost = miestnost.id_miestnost left join predmet on vyuka.id_predmet = predmet.id_predmet left join kruzok on vyuka.id_kruzok = kruzok.id_kruzok left join odbor on kruzok.id_odbor = odbor.id_odbor left join fakulta on odbor.id_fakulta = fakulta.id_fakulta  where kruzok.cislo = (?) AND odbor.kod = (?) AND odbor.rocnik = (?) AND fakulta.kod = (?) AND vyuka.prednaska = 1 order by den.id_den, hodina.id_hodina", groupNumber, departmentCode, year, facultyCode];


    while ([result next]) {
        [self buildLectureWithResult: result];
        
        NSDictionary *lecture = [self buildLectureWithResult:result];
        
        [lectures addObject:lecture];
    }
    
    [db close];
    
    return lectures;

}

+(NSMutableArray *)getSeminarsOnlyWithFacultyCode:(NSString *)facultyCode year:(NSString *)year departmentCode:(NSString *)departmentCode groupNumber:(NSString *)groupNumber {
    
    NSMutableArray *lectures = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[EROUtility getDatabasePath]];
    
    [db open];
    
    FMResultSet *result = [db executeQuery:@"select id_vyuka, vyuka.prednaska, predmet.nazov, predmet.vymera, predmet.povinny, ucitel.meno, ucitel.priezvisko, ucitel.titul, miestnost.nazov as miestnost, den.den, den.id_den, hodina.cas_od, hodina.cas_do from vyuka left join den on vyuka.id_den = den.id_den left join hodina on vyuka.id_hodina = hodina.id_hodina left join ucitel on vyuka.id_ucitel = ucitel.id_ucitel left join miestnost on vyuka.id_miestnost = miestnost.id_miestnost left join predmet on vyuka.id_predmet = predmet.id_predmet left join kruzok on vyuka.id_kruzok = kruzok.id_kruzok left join odbor on kruzok.id_odbor = odbor.id_odbor left join fakulta on odbor.id_fakulta = fakulta.id_fakulta  where kruzok.cislo = (?) AND odbor.kod = (?) AND odbor.rocnik = (?) AND fakulta.kod = (?) AND vyuka.prednaska = 0 order by den.id_den, hodina.id_hodina", groupNumber, departmentCode, year, facultyCode];
    
    
    while ([result next]) {
        [self buildLectureWithResult: result];
        
        NSDictionary *lecture = [self buildLectureWithResult:result];
        
        [lectures addObject:lecture];
    }
    
    [db close];
    
    return lectures;
    
}


+ (NSDictionary *) buildLectureWithResult: (FMResultSet *) result {
    
    NSDictionary *lecture = @{
                              @"id_vyuka": [NSString stringWithFormat:@"%d", [result intForColumn:@"id_vyuka"]],
                              @"subjectName": [result stringForColumn:@"nazov"],
                              @"subjectArea": [result stringForColumn:@"vymera"],
                              @"subjectRequired":[NSNumber numberWithInt:[result intForColumn:@"povinny"]],
                              @"subjectIsLecture":[NSNumber numberWithInt:[result intForColumn:@"prednaska"]],
                              @"teacherName": [result stringForColumn:@"meno"],
                              @"teacherLastname": [result stringForColumn:@"priezvisko"],
                              @"teacherDegree": [NSString stringWithFormat:@"%@", [result stringForColumn:@"titul"]],
                              @"room": [result stringForColumn:@"miestnost"],
                              @"day": [result stringForColumn:@"den"],
                              @"id_day": [NSString stringWithFormat:@"%d",[result intForColumn:@"id_den"]],
                              @"timeFrom": [result stringForColumn:@"cas_od"],
                              @"timeTo": [result stringForColumn:@"cas_do"]
                              };
    return lecture;
}

@end
