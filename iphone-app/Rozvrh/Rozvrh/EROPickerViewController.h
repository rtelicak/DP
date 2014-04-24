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


@property (strong, nonatomic) NSMutableArray *faculties;
@property (strong, nonatomic) NSMutableArray *years;
@property (strong, nonatomic) NSMutableArray *departments;
@property (strong, nonatomic) NSMutableArray *groups;

@end
