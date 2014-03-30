//
//  ERODepartment.h
//  Rozvrh
//
//  Created by Roman Telicak on 27/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERODepartment : NSObject

@property (nonatomic, assign) int id_odbor;
@property (nonatomic, strong) NSString *kod;
@property (nonatomic, strong) NSString *nazov;
@property (nonatomic, assign) int pocet_studentov;
@property (nonatomic, assign) int id_fakulta;
@property (nonatomic, assign) int rocnik;

@end
