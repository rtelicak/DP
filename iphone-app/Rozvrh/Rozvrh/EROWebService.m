//
//  EROWebService.m
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROWebService.h"

@implementation EROWebService

+ (instancetype)sharedInstance {
    static EROWebService *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EROWebService new];
    });
    return sharedInstance;
}

- (void)getFacultiesWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure {
    NSURL *baseURL = [EROUtility getWebServicePath];
    NSURL *facultyURL = [baseURL URLByAppendingPathComponent:@"getFaculty"];

    NSURLRequest *request = [NSURLRequest requestWithURL:facultyURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (response) {
            NSError *e;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            if (success) {
                success (result);
            }
        } else {
            if (failure) {
                failure (error);
            }
        }
    }];
}

- (void)getLessonsWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure {
    NSURL *baseURL = [EROUtility getWebServicePath];
    NSURL *lessonURL = [baseURL URLByAppendingPathComponent:@"getLesson"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:lessonURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (response) {
            NSError *e;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            if (success) {
                success (result);
            }
        } else {
            if (failure) {
                failure (error);
            }
        }
    }];
}

-(void) getInstitutesWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure {
    NSURL *baseURL = [EROUtility getWebServicePath];
    NSURL *instituteURL = [baseURL URLByAppendingPathComponent:@"getInstitute"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:instituteURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (response) {
            NSError *e;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            if (success) {
                success (result);
            }
        } else {
            if (failure) {
                failure (error);
            }
        }
    }];
}

- (void)getGroupsWithSuccess:(EROWebServiceSuccess)success failure:(EROWebServiceFailure)failure {
    NSURL *baseURL = [EROUtility getWebServicePath];
    NSURL *groupURL = [baseURL URLByAppendingPathComponent:@"getGroup"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:groupURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (response) {
            NSError *e;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            if (success) {
                success (result);
            }
        } else {
            if (failure) {
                failure (error);
            }
        }
    }];
}

@end
