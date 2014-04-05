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

@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UILabel *subjectDay;
@property (weak, nonatomic) IBOutlet UILabel *subjectTime;
@property (weak, nonatomic) IBOutlet UILabel *roomName;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameAndSurname;
@property (weak, nonatomic) IBOutlet UILabel *subjectLectureOrSeminar;
@property (weak, nonatomic) IBOutlet UILabel *subjectRequired;

@end
