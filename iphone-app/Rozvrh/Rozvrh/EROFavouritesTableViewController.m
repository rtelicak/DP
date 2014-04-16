//
//  EROFavouritesTableViewController.m
//  Rozvrh
//
//  Created by Roman Telicak on 31/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROFavouritesTableViewController.h"
#import "EROScheduleSearchCriterion.h"
#import "EROSubjectsList.h"
#import "ERODatabaseAccess.h"

@interface EROFavouritesTableViewController ()

@end

@implementation EROFavouritesTableViewController

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
    self.searchCriterionArray = [EROUtility getFavouritesSelections];
//    self.title = @"Obľúbené rozvrhy";
    
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.searchCriterionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCriterionCell" forIndexPath:indexPath];
    
    // Configure the cell...
    EROScheduleSearchCriterion *c = [self.searchCriterionArray objectAtIndex:indexPath.row];
    cell.textLabel.text =  [NSString stringWithFormat:@"%@  %@. ročník %@ %@. krúžok", c.facultyCode, c.year, c.departmentCode, c.groupNumber];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.searchCriterionArray removeObjectAtIndex:indexPath.row];
        [EROScheduleSearchCriterion transformToDictionaryAndUpdateUserDefaultsWithCriteriaArray:self.searchCriterionArray];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



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

-(void)viewWillAppear:(BOOL)animated {
    self.title = @"Obľúbené rozvrhy";
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // remove default "back" title
    self.title = @"";

    
    EROSubjectsList *targetController = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
    EROScheduleSearchCriterion *tappedSelectedCriterion = [self.searchCriterionArray objectAtIndex:selectedIndexPath.row];
    targetController.scheduleArguments = tappedSelectedCriterion;
    
    targetController.lecturesArray = [ERODatabaseAccess getLessonsWithFacultyCode:tappedSelectedCriterion.facultyCode year:tappedSelectedCriterion.year departmentCode:tappedSelectedCriterion.departmentCode groupNumber:tappedSelectedCriterion.groupNumber];

}


@end
