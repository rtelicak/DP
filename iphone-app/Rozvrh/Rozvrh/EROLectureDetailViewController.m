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
    // Do any additional setup after loading the view.
    
    NSLog(@"%@", self.selectedLecture);
    self.subjectName.text = [self.selectedLecture objectForKey:@"subjectName"];
    self.roomName.text = [self.selectedLecture objectForKey:@"room"];
    
    NSString *lectureDayAndHour = [NSString stringWithFormat:@"%@ %@ %@", [self.selectedLecture objectForKey:@"day"], [self.selectedLecture objectForKey:@"timeFrom"], [self.selectedLecture objectForKey:@"timeTo"]];
    self.subjectDayAndHour.text = lectureDayAndHour;
    
    self.teacherNameAndSurname.text = [NSString stringWithFormat:@"%@ %@ %@", [self.selectedLecture objectForKey:@"teacherDegree"], [self.selectedLecture objectForKey:@"teacherName"], [self.selectedLecture objectForKey:@"teacherLastname"]];
    
    NSString *lectureOrSeminar = [[self.selectedLecture objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? @"prednaska" : @"cvicenie";
    self.subjectLectureOrSeminar.text = lectureOrSeminar;
    
    NSString *subjectRequired = [[self.selectedLecture objectForKey:@"subjectRequired"] isEqual: [NSNumber numberWithInt:1]] ? @"povinny" : @"nepovinny";
    self.subjectRequired.text = subjectRequired;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
