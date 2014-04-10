//
//  EROAppDelegate.m
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROAppDelegate.h"

@implementation EROAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window setTintColor:[UIColor colorWithRed:44/255.0f green:62/255.0f blue:80/255.0f alpha:1.0f]];
    
    // navigation bar background color
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:241/255.0f green:245/255.0f blue:251/255.0f alpha:1.0f]];
    
    // navigation bar color
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:44/255.0f green:62/255.0f blue:80/255.0f alpha:1.0f]}];
    
    // navigation bar font
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0]}];
    
    
//    [[UINavigationBar appearance] setb];
//    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor : [UIColor whiteColor]};


    self.webServiceBasePath = [NSURL URLWithString:@"http://localhost:8888/DP/web-app/svc/"];
    self.databaseName = @"Rozvrh.db";
    self.propertyListName = @"favouritesList.plist";
    
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = documentsPath[0];
    self.databasePath = [documentsDir stringByAppendingPathComponent:self.databaseName];
    self.propertyListPath = [documentsDir stringByAppendingPathComponent:self.propertyListName];
    
    [self createAndCheckDatabase];
    [self createAndCheckPropertyList];

    return YES;
}

-(void) createAndCheckDatabase {
    BOOL databaseAlreadyExits;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    databaseAlreadyExits = [fileManager fileExistsAtPath:self.databasePath];
    
//    [EROUtility fillDatabase];
    
    if (databaseAlreadyExits) {
//        return;
    }
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
    
    NSLog(@"Database copied from bundle path");
}

- (void) createAndCheckPropertyList {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: self.propertyListPath])
    {
        NSString *propertyListPathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.propertyListName];
        
        [fileManager copyItemAtPath:propertyListPathFromApp toPath:self.propertyListPath error:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
