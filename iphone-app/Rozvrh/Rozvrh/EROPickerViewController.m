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
#import "EROSubjectsList.h"
#import "EROScheduleSearchCriterion.h"
#import "ERODatabaseAccess.h"
#import "EROWebService.h"
#import "EROUtility.h"
#import "EROColors.h"

#define duplicateConstant 30



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
    [self styleView];
    [[self.submitPickerButton layer] setBorderWidth:1.0f];
    
    // remove text from navigation back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}


-(void)initializeView {
    
    self.faculties = [ERODatabaseAccess getFacultiesFromDatabase];
    
    // duplicate faculties to simulate circular picker
    self.faculties = [self duplicateFaculties:self.faculties];
    [self.pickerView selectRow:[self.faculties count] / 2 inComponent:0 animated:YES];

    
    self.years = [[NSMutableArray alloc] init];
    self.departments = [[NSMutableArray alloc] init];
}

- (NSMutableArray *) duplicateFaculties: (NSMutableArray *) faculties {
    
    faculties = [self duplicateCompontneSourceArray:faculties];
    
    EROFaculty *f = [[EROFaculty alloc] init];
    f.kod = @"...";
    [faculties insertObject:f atIndex:[faculties count] / 2];
    
    return faculties;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return [self.faculties count];
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

- (NSMutableArray *) duplicateCompontneSourceArray: (NSMutableArray *) sourceArray {
    
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < duplicateConstant; i++) {
        [tmp addObjectsFromArray:sourceArray];
    }

    return tmp;
}

- (void) refreshDepartmentComponent {
    self.departments = [ERODatabaseAccess getDepartmentsFromDatabaseByFacultyId: self.selectedFaculty.id_fakulta andYear:self.selectedYear];
    self.departments = [self duplicateCompontneSourceArray:self.departments];
    [self.pickerView reloadComponent:2];
    [self.pickerView selectRow:[self.departments count] / 2  inComponent:2 animated:YES];
    self.selectedDepartment = [self.departments objectAtIndex:[self.departments count] / 2];
}

- (void) refreshYearComponent {
    self.years = [NSMutableArray arrayWithObjects: @"1", @"2", @"3", @"4", @"5", nil];
    self.years = [self duplicateCompontneSourceArray:self.years];
    [self.pickerView reloadComponent:1];
    [self.pickerView selectRow:[self.years count] / 2  inComponent:1 animated:YES];
    self.selectedYear = [self.years objectAtIndex:[self.years count] / 2];
}

- (void) refreshGroupComponent {
    self.groups = [ERODatabaseAccess getGroupNumbersWithFacultyCode: [NSString stringWithFormat:@"%@", self.selectedFaculty.kod] year:self.selectedYear andDepartmentCode:self.selectedDepartment];
    self.groups = [self duplicateCompontneSourceArray:self.groups];
    [self.pickerView reloadComponent:3];
    [self.pickerView selectRow:[self.groups count] / 2 inComponent:3 animated:YES];
    self.selectedGroupNumber = [self.groups objectAtIndex:[self.groups count] / 2];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        
        // faculty component
        case 0: {
            self.selectedFaculty = [self.faculties objectAtIndex:row];
            if ([self.selectedFaculty.kod isEqual:@"..."]) {
                // empty all other componentns
                [self emptyAllComponents];
                return;
            }
            
            [self refreshYearComponent];
            [self refreshDepartmentComponent];
            [self refreshGroupComponent];
            
            break;
        }
        
        // year component
        case 1: {
            self.selectedYear = [self.years objectAtIndex:row];
            
            [self refreshDepartmentComponent];
            [self refreshGroupComponent];

            break;
        }
        
        // department component
        case 2: {
            self.selectedDepartment = [self.departments objectAtIndex:row];
            
            [self refreshGroupComponent];
            
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
    
    EROSubjectsList *targetController = [segue destinationViewController];
    EROScheduleSearchCriterion *scheduleSearchCriterion = [[EROScheduleSearchCriterion alloc] init];
    
    scheduleSearchCriterion.facultyCode = self.selectedFaculty.kod;
    scheduleSearchCriterion.year = self.selectedYear;
    scheduleSearchCriterion.departmentCode = self.selectedDepartment;
    scheduleSearchCriterion.groupNumber = self.selectedGroupNumber;
    
    targetController.scheduleArguments = scheduleSearchCriterion;
    
    targetController.lecturesArray = [ERODatabaseAccess getCompulsoryOnlyWithFacultyCode:self.selectedFaculty.kod year:self.selectedYear departmentCode:self.selectedDepartment groupNumber:self.selectedGroupNumber];
}


- (IBAction)refreshButton:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aktualizácia"
                                                    message:@"Na vykonanie tejto akcie je potrebné internetové pripojenie."
                                                   delegate:self
                                          cancelButtonTitle:@"Nie"
                                          otherButtonTitles:@"Aktualizovať", nil];
    [alert show];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        return;
    }
    
    NSString *currentVersion = [ERODatabaseAccess getVersionFromDatabase];
    NSLog(@"%@",  currentVersion);
    
    [self checkLatestVersion:currentVersion];
    // check for latest version
}


- (void) checkLatestVersion: (NSString *) currentVersion {
    
    [[EROWebService sharedInstance] getVersionWithSuccess:^(id responseObject) {
        
        NSArray *versionArray = (NSArray *) responseObject;
        NSString *latestVersion = [[versionArray objectAtIndex:0] objectForKey:@"verzia"];
        
        if ([currentVersion isEqualToString:latestVersion]) {
            // data is up to date
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dáta su aktuálne."
                                                            message:[NSString stringWithFormat:@"Momentálne novší rozvrh ako %@ nie je dostupný.", currentVersion]
                                                           delegate:self
                                                  cancelButtonTitle:@"Chápem"
                                                  otherButtonTitles:nil];
            [alert show];
        } else {
            // update database
            [EROUtility setDatabaseUpdateStatus:YES reason:@"update"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chyba."
                                                        message:@"Pripojenie do internetu zlyhalo, server je nedostupný."
                                                       delegate:self
                                              cancelButtonTitle:@"Chápem"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void) emptyAllComponents{
    [self.years removeAllObjects];
    [self.departments removeAllObjects];
    [self.groups removeAllObjects];
    
    [self.pickerView reloadComponent:1];
    [self.pickerView reloadComponent:2];
    [self.pickerView reloadComponent:3];
}

-(void) styleView {
    // navigation bar color
    self.navigationController.navigationBar.barTintColor = [EROColors mainColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    // navigationbar item
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = [ERODatabaseAccess getVersionFromDatabase];
    
    [label sizeToFit];
    self.navigationItem.titleView = label;

}






@end

