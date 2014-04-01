//
//  EROPickerViewController.m
//  Rozvrh
//
//  Created by Roman Telicak on 26/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROPickerViewController.h"
#import "EROUtility.h"
#import "EROFaculty.h"
#import "EROScheduleTableViewController.h"
#import "EROScheduleSearchCriterion.h"

@interface EROPickerViewController ()
@property EROFaculty *selectedFaculty;
@property NSString *selectedYear;
@property NSString *selectedDepartment;
@property NSString *selectedGroupNumber;

@end

@implementation EROPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeView];
    // Do any additional setup after loading the view.
    
//    NSLog(@"%@", self.pickerView);
}

-(void)initializeView {

//    self.faculties = [[NSMutableArray alloc] initWithObjects:f, nil];
    
    self.faculties = [ERODatabaseAccess getFacultiesFromDatabase];
    
    EROFaculty *f = [[EROFaculty alloc] init];
    f.kod = @"fakulta";
    [self.faculties insertObject:f atIndex:0];

    
    self.years = [[NSArray alloc] init];
    self.departments = [[NSMutableArray alloc] init];
    
    
//    NSArray *newArray=[firstArray arrayByAddingObjectsFromArray:secondArray];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return self.faculties.count;
        case 1:
            return self.years.count;
        case 2:
            return self.departments.count;
        case 3:
            return self.groups.count;
    }
    
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // faculty, year, department, group number
    return 4;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    switch (component) {
        case 0:{
            EROFaculty *faculty = [self.faculties objectAtIndex:row];
            return faculty.kod;
        }
        case 1:
            return [self.years objectAtIndex:row];
        case 2:
            return [self.departments objectAtIndex:row];
        case 3:
            return [self.groups objectAtIndex:row];
    }
    
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        
        // faculty component
        case 0: {
            self.selectedFaculty = [self.faculties objectAtIndex:row];
            if ([self.selectedFaculty.kod isEqual:@"fakulta"]) {
                return;
            }
            
            self.years = @[@"1", @"2", @"3", @"4", @"5"];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            self.selectedYear = [self.years objectAtIndex:0];
            
            //
            
            self.departments = [ERODatabaseAccess getDepartmentsFromDatabaseByFacultyId: self.selectedFaculty.id_fakulta andYear:self.selectedYear];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            self.selectedDepartment = [self.departments objectAtIndex:0];
            
            self.groups = [ERODatabaseAccess getGroupNumbersWithFacultyCode: [NSString stringWithFormat:@"%@", self.selectedFaculty.kod] year:self.selectedYear andDepartmentCode:self.selectedDepartment];
            [self.pickerView reloadComponent:3];
            [self.pickerView selectRow:0 inComponent:3 animated:YES];
            self.selectedGroupNumber = [self.groups objectAtIndex:0];

            
            //
            
//            if (self.selectedDepartment) {
//                self.departments = [ERODatabaseAccess getDepartmentsFromDatabaseByFacultyId: self.selectedFaculty.id_fakulta andYear:self.selectedYear];
//                [self.pickerView reloadComponent:2];
//                
//                [self.pickerView selectRow:0 inComponent:2 animated:YES];
//                self.selectedDepartment = [self.departments objectAtIndex:0];
//                    
//                if (self.selectedYear) {
//                    self.selectedDepartment = [self.departments objectAtIndex:[self.pickerView selectedRowInComponent: 2]] ;
//                    self.groups = [ERODatabaseAccess getGroupNumbersWithFacultyCode: [NSString stringWithFormat:@"%@", self.selectedFaculty.kod] year:self.selectedYear andDepartmentCode:self.selectedDepartment];
//                    [self.pickerView reloadComponent:3];
//                }
//            }
            

//                 self.departments = [[NSMutableArray alloc] init];
//                [self.pickerView reloadComponent:2];


            break;
        }
        
        // year component
        case 1: {
            // populate 3rd component with data
            self.selectedYear = [self.years objectAtIndex:row];
            self.departments = [ERODatabaseAccess getDepartmentsFromDatabaseByFacultyId: self.selectedFaculty.id_fakulta andYear:self.selectedYear];
            [self.pickerView reloadComponent:2];
            
            // reset components to the right, but year
            self.groups = [[NSMutableArray alloc] init];

            break;
        }
        
        // department component
        case 2: {
            self.selectedDepartment = [self.departments objectAtIndex:row];
            self.groups = [ERODatabaseAccess getGroupNumbersWithFacultyCode: [NSString stringWithFormat:@"%@", self.selectedFaculty.kod] year:self.selectedYear andDepartmentCode:self.selectedDepartment];
            NSLog(@"%@", self.groups);
            
            [self.pickerView reloadComponent:3];
            
            break;
        }
            
        case 3: {
            self.selectedGroupNumber = [self.groups objectAtIndex:row];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.submitPickerButton) {
        return;
    }
    
    EROScheduleTableViewController *targetController = [segue destinationViewController];
    EROScheduleSearchCriterion *scheduleSearchCriterion = [[EROScheduleSearchCriterion alloc] init];
    
    scheduleSearchCriterion.facultyCode = self.selectedFaculty.kod;
    scheduleSearchCriterion.year = self.selectedYear;
    scheduleSearchCriterion.departmentCode = self.selectedDepartment;
    scheduleSearchCriterion.groupNumber = self.selectedGroupNumber;
    
    targetController.scheduleArguments = scheduleSearchCriterion;
    
    targetController.lecturesArray = [ERODatabaseAccess getLessonsWithFacultyCode:self.selectedFaculty.kod year:self.selectedYear departmentCode:self.selectedDepartment groupNumber:self.selectedGroupNumber];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

