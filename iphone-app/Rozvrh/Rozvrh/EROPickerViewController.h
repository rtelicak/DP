//
//  EROPickerViewController.h
//  Rozvrh
//
//  Created by Roman Telicak on 26/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERODatabaseAccess.h"

@interface EROPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSMutableArray *faculties;
@property (strong, nonatomic) NSArray *years;
@property (strong, nonatomic) NSMutableArray *departments;
@property (strong, nonatomic) NSMutableArray *groups;

@end
