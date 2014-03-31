//
//  EROScheduleTableViewController.h
//  Rozvrh
//
//  Created by Roman Telicak on 30/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EROScheduleTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary *scheduleArguments;
@property (nonatomic, strong) NSMutableArray *lecturesArray;
@property (nonatomic, strong) NSDictionary *selectedLecture;

@end
