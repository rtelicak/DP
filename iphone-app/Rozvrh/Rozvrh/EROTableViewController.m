//
//  EROTableViewController.m
//  Rozvrh
//
//  Created by Roman Telicak on 24/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROTableViewController.h"
#import "EROWebService.h"
#import "ERODatabaseAccess.h"

@interface EROTableViewController ()

@end

@implementation EROTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self populateFaculties];
    [self populateLessons];
    [self populateInstitutes];
    [self populateGroups];
}

// FACULTIES
-(void) populateFaculties {
    [[EROWebService sharedInstance] getFacultiesWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        self.facultiesArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertFacultiesFromArray:self.facultiesArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating faculties: %@", error);
    }];
}

// LESSONS
-(void) populateLessons {
    [[EROWebService sharedInstance] getLessonsWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        self.lessonsArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertLessonsFromArray:self.lessonsArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating lessons: %@", error);
    }];
}

// INSTITUTES
-(void) populateInstitutes {

    [[EROWebService sharedInstance] getInstitutesWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        self.instituteArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertInstitutesFromArray:self.instituteArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating institutes: %@", error);
    }];

}

// GROUPS
-(void) populateGroups {

    [[EROWebService sharedInstance] getGroupsWithSuccess:^(id responseObject) {
        NSArray *array = (NSArray *)responseObject;
        self.groupArray = [NSMutableArray arrayWithArray:array];
        [ERODatabaseAccess insertGroupsFromArray:self.groupArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error ocured while populating groups: %@", error);
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.facultiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"facultyCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[self.facultiesArray objectAtIndex:indexPath.row] objectForKey:@"nazov"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
