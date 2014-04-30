//
//  EROLectureDetailViewController.m
//  Rozvrh
//
//  Created by Roman Telicak on 31/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROLectureDetailViewController.h"

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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // colors
    UIColor *seminarColor = [UIColor colorWithRed:50/255.0f green:149/255.0f blue:213/255.0f alpha:1.0f];
    UIColor *lessonColor = [UIColor colorWithRed:230/255.0f green:81/255.0f blue:67/255.0f alpha:1.0f];
    
    //    cell.backgroundColor = [[sub objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? lessonColor : seminarColor;
    //    cell.backgroundColor = [UIColor whiteColor];
    //    NSString *lectureOrSeminar = [[self.selectedLecture objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? @"prednaska" : @"cvicenie";
    
    // set cell's background depending on day
    UIColor *grayColor = [UIColor colorWithRed:52/255.0f green:72/255.0f blue:92/255.0f alpha:1.0f];
    UIColor *darkOrange = [UIColor colorWithRed:192/255.0f green:57/255.0f blue:43/255.0f alpha:1.0f];
    UIColor *lightOrange = [UIColor colorWithRed:230/255.0f green:86/255.0f blue:73/255.0f alpha:1.0f];;
    UIColor *purple = [UIColor colorWithRed:153/255.0f green:91/255.0f blue:180/255.0f alpha:1.0f];
    UIColor *darkBlue = [UIColor colorWithRed:41/255.0f green:128/255.0f blue:185/255.0f alpha:1.0f];
    UIColor *lightBlue = [UIColor colorWithRed:50/255.0f green:149/255.0f blue:212/255.0f alpha:1.0f];
    UIColor * color = [UIColor colorWithRed:50/255.0f green:256/255.0f blue:0/255.0f alpha:1.0f];
    UIColor *pumpkin = [UIColor colorWithRed:211/255.0f green:84/255.0f blue:0/255.0f alpha:1.0f];
    UIColor *concrete = [UIColor colorWithRed:149/255.0f green:165/255.0f blue:166/255.0f alpha:1.0f];
    
    
    
    int id_day = [[self.selectedLecture objectForKey:@"id_day"] intValue];
    
    switch (id_day)  {
            
        case 1: {
            self.view.backgroundColor = grayColor;
            break;
        }
        case 2: {
            self.view.backgroundColor = darkOrange;
            break;
        }
            
        case 3: {
            self.view.backgroundColor = lightOrange;
            break;
        }
            
        case 4: {
            self.view.backgroundColor = darkBlue;
            break;
        }
        case 5: {
            self.view.backgroundColor = lightBlue;
            break;
        }
    }
    
    UIView *grayBackground = [[UIView alloc] initWithFrame:CGRectMake(15.0, 80.0, 270.0, 300.0)];
//    grayBackground.backgroundColor = [UIColor colorWithRed:149/255.0f green:165/255.0f blue:166/255.0f alpha:0.3f];
//   grayBackground.backgroundColor = [UIColor colorWithRed:153/255.0f green:91/255.0f blue:180/255.0f alpha:0.3f];

//    [grayBackground setOpaque:NO];
    
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
    label.textColor = [UIColor whiteColor];
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
