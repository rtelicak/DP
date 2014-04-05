//
//  EROScheduleTableViewController.h
//  Rozvrh
//
//  Created by Roman Telicak on 30/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EROScheduleSearchCriterion.h"

@interface EROScheduleTableViewController : UITableViewController

@property (nonatomic, strong) EROScheduleSearchCriterion *scheduleArguments;
@property (nonatomic, strong) NSMutableArray *lecturesArray;
@property (nonatomic, strong) NSDictionary *selectedLecture;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavouriteButton;
- (IBAction)addFavouriteButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedUiPicker;
- (IBAction)segmentedButtonPressed:(id)sender;

@end
