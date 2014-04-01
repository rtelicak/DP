//
//  EROScheduleSearchCriterion.h
//  Rozvrh
//
//  Created by Roman Telicak on 31/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EROScheduleSearchCriterion : NSObject
@property (nonatomic, strong) NSString *facultyCode;
@property (nonatomic, strong) NSString *departmentCode;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *groupNumber;

+ (BOOL) isScheduleCriterionAlreadyInFavourites: (EROScheduleSearchCriterion *) criterion;
- (NSDictionary*) transformToDictionary;
+ (void) transformToDictionaryAndUpdateUserDefaultsWithCriteriaArray: (NSMutableArray *) scheduleCriteria;

@end
