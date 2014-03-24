//
//  EROFaculty.h
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EROFaculty : NSObject

@property (nonatomic, assign) int id_fakulta;
@property (nonatomic, strong) NSString *kod;
@property (nonatomic, strong) NSString *nazov;

@end
