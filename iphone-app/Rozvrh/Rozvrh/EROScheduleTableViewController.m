//
//  EROScheduleTableViewController.m
//  Rozvrh
//
//  Created by Roman Telicak on 30/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROScheduleTableViewController.h"
#import "ERODatabaseAccess.h"
#import "EROLectureDetailViewController.h"
#import "EROUtility.h"
#import "EROScheduleSearchCriterion.h"

@interface EROScheduleTableViewController ()


@end

@implementation EROScheduleTableViewController

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
    
    if ([EROScheduleSearchCriterion isScheduleCriterionAlreadyInFavourites:self.scheduleArguments]) {
        self.addFavouriteButton.enabled = NO;
    }


    NSLog(@"%@", self.scheduleArguments);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.lecturesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lectureCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *sub = [self.lecturesArray objectAtIndex:indexPath.row];
    NSString *lab = [sub objectForKey:@"subjectName"];
    cell.textLabel.text = lab;
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    EROLectureDetailViewController *detailController = [segue destinationViewController];

//    NSIndexPath *selectedIndexPath = [self.tableView ];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
    NSLog(@"%ld", (long)selectedIndexPath.row);
    detailController.selectedLecture = [self.lecturesArray objectAtIndex:selectedIndexPath.row];
}


- (IBAction)addFavouriteButtonPressed:(id)sender {
    NSMutableArray *favouritesFromUserDefaults = [EROUtility getFavouritesSelections];
    [favouritesFromUserDefaults addObject:self.scheduleArguments];
    
    NSMutableArray *transformedFavourites = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < favouritesFromUserDefaults.count; i++) {
        EROScheduleSearchCriterion *s = [favouritesFromUserDefaults objectAtIndex:i];
        [transformedFavourites addObject: [s transformToDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:transformedFavourites forKey:@"EROFavourites"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.addFavouriteButton.enabled = NO;
}
@end
