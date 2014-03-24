//
//  EROTableViewController.h
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EROUtility.h"
#import "EROFaculty.h"

@interface EROTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *facultiesArray;


-(void) populateFaculties;

@end
