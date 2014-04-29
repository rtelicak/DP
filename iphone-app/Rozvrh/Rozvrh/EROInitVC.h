//
//  EROInitVC.h
//  Rozvrh
//
//  Created by Roman Telicak on 23/04/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EROPickerViewController.h"

@interface EROInitVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *loadingMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *semesterLabel;

@end
