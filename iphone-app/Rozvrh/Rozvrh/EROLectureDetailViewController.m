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

    
//    int id_day = [[self.selectedLecture objectForKey:@"id_day"] intValue];
//    
//    switch (id_day)  {
//            
//        case 1: {
//            self.view.backgroundColor = [EROColors mondayColor];
//            break;
//        }
//        case 2: {
//            self.view.backgroundColor = [EROColors tuesdayColor];
//            break;
//        }
//            
//        case 3: {
//            self.view.backgroundColor = [EROColors wednesdayColor];
//            break;
//        }
//            
//        case 4: {
//            self.view.backgroundColor = [EROColors thursdayColor];
//            break;
//        }
//        case 5: {
//            self.view.backgroundColor = [EROColors fridayColor];
//            break;
//        }
//    }
//    
//    UIView *grayBackground = [[UIView alloc] initWithFrame:CGRectMake(15.0, 80.0, 270.0, 300.0)];
//    [self.view addSubview:grayBackground];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) styleView {
    
    // navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // title label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [EROColors mainLabelColor];
    label.text = [[self.selectedLecture objectForKey:@"subjectName"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    // back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-icon.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backAction)];
    backButton.tintColor = [EROColors mainColor];
    self.navigationItem.leftBarButtonItem = backButton;
    
    // labels
    self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.dayLabel.textColor = [EROColors mainLabelColor];
    self.timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.timeLabel.textColor = [EROColors mainLabelColor];
    self.roomLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.roomLabel.textColor = [EROColors mainLabelColor];
    self.teacherLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.teacherLabel.textColor = [EROColors mainLabelColor];
    self.lectureTypeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.lectureTypeLabel.textColor = [EROColors mainLabelColor];
    self.compulsoryLessonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.compulsoryLessonLabel.textColor = [EROColors mainLabelColor];
    
    // inputs
    self.subjectDay.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    self.subjectDay.textColor = [EROColors buttonColor];
    self.subjectTime.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    self.subjectTime.textColor = [EROColors buttonColor];
    self.roomName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    self.roomName.textColor = [EROColors buttonColor];
    self.teacherNameAndSurname.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    self.teacherNameAndSurname.textColor = [EROColors buttonColor];
    self.subjectLectureOrSeminar.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    self.subjectLectureOrSeminar.textColor = [EROColors buttonColor];
    self.subjectRequired.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
    self.subjectRequired.textColor = [EROColors buttonColor];
}

-(void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) populateLessonDetailView {
    
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
    
    if ([[timeTo substringToIndex:1] isEqualToString:@"0"]) {
        timeTo = [timeTo substringFromIndex:1];
    }
    
    self.subjectTime.text = [NSString stringWithFormat:@"%@ - %@", timeFrom, timeTo];
    
    // room
    self.roomName.text = [[self.selectedLecture objectForKey:@"room"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // teacher
    NSString *teacherTitle = [self.selectedLecture objectForKey:@"teacherDegree"];
    
    self.teacherNameAndSurname.text = [teacherTitle isEqual:@"(null)"] ?
    [NSString stringWithFormat:@"%@ %@", [self.selectedLecture objectForKey:@"teacherName"], [self.selectedLecture objectForKey:@"teacherLastname"]]:
    [NSString stringWithFormat:@"%@. %@ %@", [self.selectedLecture objectForKey:@"teacherDegree"], [self.selectedLecture objectForKey:@"teacherName"], [self.selectedLecture objectForKey:@"teacherLastname"]];
    
    // lecture or seminar
    NSString *lectureOrSeminar = [[self.selectedLecture objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? @"prednáška" : @"cvičenie";
    self.subjectLectureOrSeminar.text = lectureOrSeminar;
    
    // is subject required
    NSString *subjectRequired = [[self.selectedLecture objectForKey:@"subjectRequired"] isEqual: [NSNumber numberWithInt:1]] ? @"povinný" : @"nepovinný";
    self.subjectRequired.text = subjectRequired;
}



















@end
