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
#import "EROColors.h"

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
    [self styleView];
    
    self.searchCriterionArray = [EROUtility getFavouritesSelections];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    self.searchCriterionArray = [EROUtility getFavouritesSelections];
    [self.tableView reloadData];
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
    return self.searchCriterionArray.count > 0 ? self.searchCriterionArray.count : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.searchCriterionArray.count > 0 ) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCriterionCell" forIndexPath:indexPath];
        
        EROScheduleSearchCriterion *c = [self.searchCriterionArray objectAtIndex:indexPath.row];
        cell.textLabel.text =  [NSString stringWithFormat:@"%@  %@. ročník %@ %@. krúžok", c.facultyCode, c.year, c.departmentCode, c.groupNumber];
        
        // style cell
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
        cell.textLabel.textColor = [EROColors tableCellText];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevron-icon.png"]];
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyDataCell" forIndexPath:indexPath];
        
        return cell;
    }
    


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
    if ([self.searchCriterionArray count] > 0) {
        
        return 60;
    } else {
        
        return self.tableView.frame.size.height;
    }

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // remove default "back" title
//    self.title = @"";

    
    EROSubjectsList *targetController = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
    EROScheduleSearchCriterion *tappedSelectedCriterion = [self.searchCriterionArray objectAtIndex:selectedIndexPath.row];
    targetController.scheduleArguments = tappedSelectedCriterion;
    
    targetController.lecturesArray = [ERODatabaseAccess getCompulsoryOnlyWithFacultyCode:tappedSelectedCriterion.facultyCode year:tappedSelectedCriterion.year departmentCode:tappedSelectedCriterion.departmentCode groupNumber:tappedSelectedCriterion.groupNumber];

}

- (void) styleView {
    
    // navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // remove empty cells at the bottom
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    // remove padding from table view
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [EROColors mainLabelColor];
    titleLabel.text = @"Obľúbené rozvrhy";
    
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;

}

-(void)viewWillAppear:(BOOL)animated {
//    self.title = @"Obľúbené rozvrhy";
}





















@end
