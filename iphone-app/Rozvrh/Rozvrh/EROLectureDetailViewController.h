//
//  EROLectureDetailViewController.h
//  Rozvrh
//
//  Created by Roman Telicak on 31/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EROLectureDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *selectedLecture;

// just labels
@property (weak, nonatomic) IBOutlet UILabel *subjectDay;
@property (weak, nonatomic) IBOutlet UILabel *subjectTime;
@property (weak, nonatomic) IBOutlet UILabel *roomName;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameAndSurname;
@property (weak, nonatomic) IBOutlet UILabel *subjectLectureOrSeminar;
@property (weak, nonatomic) IBOutlet UILabel *subjectRequired;

// inputs
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *lectureTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *compulsoryLessonLabel;

@end
