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
    
    // data preparing done notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLoading:) name:@"finishedLoading" object:nil];
    
    // update loading data message label
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoadingMessage:) name:@"updateLoadingMessage" object:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    // TODO: fix me
    // have to call this from this method, to prevent modal segue error
    [self createAndCheckDatabase];
}

-(void) createAndCheckDatabase {
    BOOL databaseAlreadyExits;
    NSString *databasePath =  [EROUtility getDatabasePath];
    NSString *databaseName =  [EROUtility getDatabaseName];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    databaseAlreadyExits = [fileManager fileExistsAtPath:databasePath];
    
//    if (databaseAlreadyExits) {
//        [self hideLoadingView];
//        return;
//    }
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
    [EROUtility fillDatabase];
    
    NSLog(@"Database copied from bundle path");
}

// notification methods
- (void) updateLoadingMessage: (NSNotification *) notification {
    // update loading message info
    self.loadingMessageLabel.text = [notification.userInfo objectForKey:@"message"];
}

- (void)finishedLoading:(NSNotification *)notification {
    [self hideLoadingView];
}

- (void) hideLoadingView {
    [self performSegueWithIdentifier:@"initSegue" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
