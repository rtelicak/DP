//
//  EROInitVC.m
//  Rozvrh
//
//  Created by Roman Telicak on 23/04/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROInitVC.h"
#import "EROUtility.h"
#import "EROWebService.h"
#import "EROColors.h"

@interface EROInitVC ()

//@property (strong, nonatomic) NSNumber *loadingCounter;
@property int loadingCounter;

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
    
    // update loading data message label
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoadingMessage:) name:@"updateLoadingMessage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(errorOccuredWhileInsertingData:) name:@"errorOccuredWhileInsertingData" object:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    // TODO: fix me
    // have to call this from this method, to prevent modal segue error
    [self createAndCheckDatabase];
    self.loadingCounter = 0;
}

-(void) createAndCheckDatabase {
    BOOL databaseAlreadyExits;
    NSString *databasePath =  [EROUtility getDatabasePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    databaseAlreadyExits = [fileManager fileExistsAtPath:databasePath];
    
    NSDictionary *statusDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"isDatabaseUpdateNeeded"];
    
    // if the app is launched for the very first time
    if (statusDictionary == NULL) {
        
        [self requiredUpdateDatabaseAfterFirstLaunch];
        
    } else {
        
        BOOL updateDatabase = [EROUtility getDatabaseUpdateStatus];
        
        if (databaseAlreadyExits && !updateDatabase) {
            [self hideLoadingView];
            return;
        }
        
        // flag, there is no need to update db
        // will be changed to YES if error occurs in process of filling DB
        [EROUtility setDatabaseUpdateStatus:NO reason:@""];
        self.mainLabel.text = @"Načítavam dáta, potrvá to asi minútku...";
        
        // create database
        [EROUtility createAndFillDatabase];
        
        NSLog(@"Database copied from bundle path");
    }
}

// notification methods
- (void) updateLoadingMessage: (NSNotification *) notification {
    // update loading message info
    self.loadingMessageLabel.text = [notification.userInfo objectForKey:@"message"];
    
    self.loadingCounter++;
    
    // everything is loaded, hide initial screen
    if (self.loadingCounter == 11) {
        [self finishedLoading];
    }
}

- (void)finishedLoading {
    self.loadingMessageLabel.textColor = [EROColors mainColor];
    self.loadingMessageLabel.text = @"Success!";
    // using perfomSelector just because of delay feature
    [self performSelector:@selector(hideLoadingView) withObject:nil afterDelay:1.5];

}

- (void) hideLoadingView {
    [self performSegueWithIdentifier:@"initSegue" sender:nil];
}

-(void) errorOccuredWhileInsertingData: (NSNotification *) notification {
    // popupt aler view just once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self popupErrorInternetConnectionAlertView];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    self.loadingMessageLabel.text = @"";
    self.mainLabel.text = @"";
    [self styleView];
}

-(void) requiredUpdateDatabaseAfterFirstLaunch {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Prvé spustenie aplikácie."
                                                    message:@"Je potrebné sa pripojiť na internet a stiahnuť aktuálny rozvrh."
                                                   delegate:self
                                          cancelButtonTitle:@"Chápem"
                                          otherButtonTitles:nil];
    alert.tag = 1;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // first time launch alertView
    if (alertView.tag == 1) {
        [self checkInternetConnectionAndCreateDatabase];
    }
}

-(void) checkInternetConnectionAndCreateDatabase {
    
    [[EROWebService sharedInstance] getVersionWithSuccess:^(id responseObject) {
        
        // update semester label
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *version = (NSArray *) responseObject;
            self.semesterLabel.text = [[version objectAtIndex:0] objectForKey:@"verzia"];
        });
        
        self.mainLabel.text = @"Načítavam dáta, potrvá to asi minútku :)";
        [EROUtility setDatabaseUpdateStatus:NO reason:@""];
        
        // create database
        [EROUtility createAndFillDatabase];
        NSLog(@"Database copied from bundle path");
    } failure:^(NSError *error) {
        [self popupErrorInternetConnectionAlertView];
    }];
}

-(void) popupErrorInternetConnectionAlertView {
    self.mainLabel.text = @"Pripojenie na server zlyhalo :(";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chyba."
                                                    message:@"Pripojenie do internetu zlyhalo, server je nedostupný."
                                                   delegate:self
                                          cancelButtonTitle:@"Chápem"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void) styleView {
    self.view.backgroundColor = [EROColors mainColor];
    
    [self.imageView setImage:[UIImage imageNamed:@"welcome-screen-logo.png"]];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    
    self.semesterLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    self.semesterLabel.textColor = [UIColor whiteColor];
    
    self.loadingMessageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    self.loadingMessageLabel.textColor = [EROColors mainLabelColor];
    
    self.mainLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
    self.mainLabel.textColor = [EROColors mainLabelColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}















@end
