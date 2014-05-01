//
//  EROLectureDetailViewController.m
//  Rozvrh
//
//  Created by Roman Telicak on 31/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROLectureDetailViewController.h"
#import "EROColors.h"

@interface EROLectureDetailViewController ()

@end

@implementation EROLectureDetailViewController

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
    [self populateLessonDetailView];
    [self styleView];
    
    NSLog(@"%@", self.selectedLecture);

    
    int id_day = [[self.selectedLecture objectForKey:@"id_day"] intValue];
    
    switch (id_day)  {
            
        case 1: {
            self.view.backgroundColor = [EROColors mondayColor];
            break;
        }
        case 2: {
            self.view.backgroundColor = [EROColors tuesdayColor];
            break;
        }
            
        case 3: {
            self.view.backgroundColor = [EROColors wednesdayColor];
            break;
        }
            
        case 4: {
            self.view.backgroundColor = [EROColors thursdayColor];
            break;
        }
        case 5: {
            self.view.backgroundColor = [EROColors fridayColor];
            break;
        }
    }
    
    UIView *grayBackground = [[UIView alloc] initWithFrame:CGRectMake(15.0, 80.0, 270.0, 300.0)];
    [self.view addSubview:grayBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) styleView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [EROColors mainLabelColor];
    label.text = self.subjectName.text;
    
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

- (void) populateLessonDetailView {
    // subject name
    self.subjectName.text = [[self.selectedLecture objectForKey:@"subjectName"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // day
    NSString *lectureDay = [NSString stringWithFormat:@"%@", [self.selectedLecture objectForKey:@"day"]];
    self.subjectDay.text = lectureDay;
    
    // time
    NSString *timeFrom = [self.selectedLecture objectForKey:@"timeFrom"];
    timeFrom = [timeFrom substringToIndex:[timeFrom length] - 3];
    
    if ([[timeFrom substringToIndex:1] isEqualToString:@"0"]) {
        timeFrom = [timeFrom substringFromIndex:1];
    }
    
    NSString *timeTo = [self.selectedLecture objectForKey:@"timeTo"];
    timeTo = [timeTo substringToIndex:[timeTo length] - 3];
    
    self.subjectTime.text = [NSString stringWithFormat:@"%@ - %@", timeFrom, timeTo];
    
    // room
    self.roomName.text = [[self.selectedLecture objectForKey:@"room"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // teacher
    NSString *teacherTitle = [self.selectedLecture objectForKey:@"teacherDegree"];
    
    self.teacherNameAndSurname.text = [teacherTitle isEqual:@"(null)"] ?
    [NSString stringWithFormat:@"%@ %@", [self.selectedLecture objectForKey:@"teacherName"], [self.selectedLecture objectForKey:@"teacherLastname"]]:
    [NSString stringWithFormat:@"%@. %@ %@", [self.selectedLecture objectForKey:@"teacherDegree"], [self.selectedLecture objectForKey:@"teacherName"], [self.selectedLecture objectForKey:@"teacherLastname"]];
    
    // lecture or seminar
    NSString *lectureOrSeminar = [[self.selectedLecture objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? @"prednaska" : @"cvicenie";
    self.subjectLectureOrSeminar.text = lectureOrSeminar;
    
    // si subject required
    NSString *subjectRequired = [[self.selectedLecture objectForKey:@"subjectRequired"] isEqual: [NSNumber numberWithInt:1]] ? @"povinny" : @"nepovinny";
    self.subjectRequired.text = subjectRequired;
}



















@end
