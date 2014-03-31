//
//  EROFavouritesTableViewController.m
//  Rozvrh
//
//  Created by Roman Telicak on 31/03/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROFavouritesTableViewController.h"
#import "EROScheduleSearchCriterion.h"
#import "EROScheduleTableViewController.h"
#import "ERODatabaseAccess.h"

@interface EROFavouritesTableViewController ()

@property (nonatomic, strong) NSMutableArray *searchCriterionArray;

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
    
    NSString *propertyListPath =  [EROUtility getPropertyListPath];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile: propertyListPath];
    NSMutableArray *plistArray = [[NSMutableArray alloc] initWithContentsOfFile: propertyListPath];
//    NSMutableArray *a = [dic objectForKey:@"settings"];
    
    self.searchCriterionArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [plistArray count]; i++) {
        EROScheduleSearchCriterion *s = [[EROScheduleSearchCriterion alloc] init];
        
        s.facultyCode = [[plistArray objectAtIndex:i] objectForKey:@"facultyCode"];
        s.departmentCode = [[plistArray objectAtIndex:i] objectForKey:@"departmentCode"];
        s.year = [[plistArray objectAtIndex:i] objectForKey:@"year"];
        s.groupNumber = [[plistArray objectAtIndex:i] objectForKey:@"groupNumber"];
        
        [self.searchCriterionArray addObject:s];
    }
    
    
    
    NSLog(@"%@", self.searchCriterionArray);
    NSMutableArray *plistArray2 = [[NSMutableArray alloc] init];
    NSDictionary *d = @{
                     @"facultyCode": @"FHI",
                     @"departmentCode": @"MRIT",
                     @"year": @"1",
                     @"groupNumber": @"2"
                     };

    NSDictionary *e = @{
                        @"facultyCode": @"FHI",
                        @"departmentCode": @"MRIT",
                        @"year": @"3",
                        @"groupNumber": @"2"
                        };
    
    NSDictionary *f = @{
                        @"facultyCode": @"FHI",
                        @"departmentCode": @"MRIT",
                        @"year": @"5",
                        @"groupNumber": @"4"
                        };

    [plistArray2 addObject:d];
    [plistArray2 addObject:e];
    [plistArray2 addObject:f];


//    NSLog(@"%@", [dic objectForKey:@"settings"]);
//    NSLog(@"%@", plistArray);
    
//    [a addObject:d];
//    [dic setObject:a forKey:@"settings"];
    [plistArray2 writeToFile:propertyListPath atomically:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
    
    
//    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
//    
//    //here add elements to data file and write data to file
//    int value = 5;
//    
//    [data setObject:[NSNumber numberWithInt:value] forKey:@”value”];
//    
//    [data writeToFile: path atomically:YES];
//    [data release]
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
    cell.textLabel.text =  [NSString stringWithFormat:@"%@ > %@ > %@ > %@", c.facultyCode, c.year, c.departmentCode, c.groupNumber];
    
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
    EROScheduleTableViewController *targetController = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
    EROScheduleSearchCriterion *tappedSelectedCriterion = [self.searchCriterionArray objectAtIndex:selectedIndexPath.row];
    targetController.scheduleArguments = @{
                                           @"selectedFacultyCode": tappedSelectedCriterion.facultyCode,
                                           @"selectedYear": tappedSelectedCriterion.year,
                                           @"selectedDepartmentCode": tappedSelectedCriterion.departmentCode,
                                           @"selectedGroupNumber": tappedSelectedCriterion.groupNumber
                                           };
    targetController.lecturesArray = [ERODatabaseAccess getLessonsWithFacultyCode:tappedSelectedCriterion.facultyCode year:tappedSelectedCriterion.year departmentCode:tappedSelectedCriterion.departmentCode groupNumber:tappedSelectedCriterion.groupNumber];

}


@end
