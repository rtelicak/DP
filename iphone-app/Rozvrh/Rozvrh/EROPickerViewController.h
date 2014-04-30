//
//  EROPickerViewController.h
//  Rozvrh
//
//  Created by Roman Telicak on 26/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERODatabaseAccess.h"

@interface EROPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *submitPickerButton;
- (IBAction)refreshButton:(id)sender;
- (IBAction)searchButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *facultyViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupViewLabel;



@property (strong, nonatomic) NSMutableArray *faculties;
@property (strong, nonatomic) NSMutableArray *years;
@property (strong, nonatomic) NSMutableArray *departments;
@property (strong, nonatomic) NSMutableArray *groups;

@property (strong, nonatomic) NSString *navigationBarTitle;

@end
