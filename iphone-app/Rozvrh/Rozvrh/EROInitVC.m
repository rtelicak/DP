//
//  EROInitVC.m
//  Rozvrh
//
//  Created by Roman Telicak on 23/04/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROInitVC.h"
#import "EROUtility.h"
#import "EROPickerViewController.h"

@interface EROInitVC ()

@end

static NSTimer *timer;

@implementation EROInitVC

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
    self.loadingMessageLabel.text = @"asfg1";

}

-(void)viewDidAppear:(BOOL)animated {
    [self createAndCheckDatabase];
}

- (void) finishLoadingView {
    [self performSegueWithIdentifier:@"initSegue" sender:nil];
}

- (UILabel *) getMessageLabel {
    self.loadingMessageLabel.text = @"asfg";
    return self.loadingMessageLabel;
}

-(void) createAndCheckDatabase {
    BOOL databaseAlreadyExits;
    NSString *databasePath =  [EROUtility getDatabasePath];
    NSString *databaseName =  [EROUtility getDatabaseName];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    databaseAlreadyExits = [fileManager fileExistsAtPath:databasePath];
    
    if (databaseAlreadyExits) {
//        return;
    }
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
    [EROUtility fillDatabase];
    
    NSLog(@"Database copied from bundle path");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
