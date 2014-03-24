//
//  EROWebService.h
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EROUtility.h"

typedef void (^EROWebServiceSuccess)(id responseObject);
typedef void (^EROWebServiceFailure)(NSError *error);

@interface EROWebService : NSObject

+ (instancetype)sharedInstance;

- (void)getFacultiesWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure;
- (void)getLessonsWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure;
- (void)getInstitutesWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure;
- (void)getGroupsWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure;

@end
