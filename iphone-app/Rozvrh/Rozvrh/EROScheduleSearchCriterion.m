//
//  EROScheduleSearchCriterion.m
//  Rozvrh
//
//  Created by Roman Telicak on 31/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROScheduleSearchCriterion.h"
#import "EROUtility.h"

@implementation EROScheduleSearchCriterion

+ (BOOL) isScheduleCriterionAlreadyInFavourites: (EROScheduleSearchCriterion *) criterion {
    
    NSMutableArray *favouritesFromUserDefaults = [EROUtility getFavouritesSelections];
    
    for (int i = 0; i < favouritesFromUserDefaults.count; i++) {
        EROScheduleSearchCriterion *c = [favouritesFromUserDefaults objectAtIndex:i];
        
        if ([c.facultyCode isEqual:criterion.facultyCode] &&
            [c.year isEqual:criterion.year] &&
            [c.departmentCode isEqual:criterion.departmentCode] &&
            [c.groupNumber isEqual:criterion.groupNumber]
            ) {

            return YES;
        }
    }
    
    return  NO;
}

-(NSDictionary *)transformToDictionary {
    NSDictionary *d = @{@"facultyCode": self.facultyCode,
                        @"year": self.year,
                        @"departmentCode": self.departmentCode,
                        @"groupNumber": self.groupNumber
                        };
    
    return d;
}

+ (void)transformToDictionaryAndUpdateUserDefaultsWithCriteriaArray:(NSMutableArray *)scheduleCriteria {
    NSMutableArray *transformedFavourites = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < scheduleCriteria.count; i++) {
        [transformedFavourites addObject:[[scheduleCriteria objectAtIndex:i] transformToDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:transformedFavourites forKey:@"EROFavourites"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end

