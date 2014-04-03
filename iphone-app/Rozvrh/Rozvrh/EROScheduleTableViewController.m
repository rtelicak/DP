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
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // http://uicolor.org/
//    self.tableView.separatorColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1.0f];
    self.tableView.separatorColor = [UIColor clearColor];
    
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
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lectureCell" forIndexPath:indexPath];
    //
    //    // Configure the cell...
    NSDictionary *sub = [self.lecturesArray objectAtIndex:indexPath.row];
    //    NSString *lab = [sub objectForKey:@"subjectName"];
    //    cell.textLabel.text = [lab stringByReplacingOccurrencesOfString:@"_" withString:@" "];
#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3
    
    // advanced configuring
    static NSString *CellIdentifier = @"lectureCell";
    
    UILabel *subjectNameLabel, *roomLabel, *timeLabel, *teacherLabel, *dayLabel;
    UIImageView *photo;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    
    subjectNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 8.0, 230.0, 15.0)];
    subjectNameLabel.tag = MAINLABEL_TAG;
    subjectNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    subjectNameLabel.textAlignment = NSTextAlignmentLeft;
    subjectNameLabel.textColor = [UIColor whiteColor];
    subjectNameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//    subjectNameLabel.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:subjectNameLabel];
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 45.0, 60.0)];
    dayLabel.tag = SECONDLABEL_TAG;
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:36.0];
    dayLabel.textAlignment = NSTextAlignmentLeft;
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [cell.contentView addSubview:dayLabel];
//    dayLabel.backgroundColor = [UIColor redColor];
    
    roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 23.0, 220.0, 25.0)];
    roomLabel.tag = SECONDLABEL_TAG;
    roomLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    roomLabel.textAlignment = NSTextAlignmentLeft;
    roomLabel.textColor = [UIColor whiteColor];
    roomLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [cell.contentView addSubview:roomLabel];
    
    teacherLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 40.0, 220.0, 25.0)];
    teacherLabel.tag = SECONDLABEL_TAG;
    teacherLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    teacherLabel.textAlignment = NSTextAlignmentLeft;
    teacherLabel.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:teacherLabel];
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220.0, 34.0, 75.0, 25.0)];
    timeLabel.tag = SECONDLABEL_TAG;
//    timeLabel.font = [UIFont systemFontOfSize:28.0];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor whiteColor];
//    timeLabel.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:timeLabel];
//    [UIFont fontWithName:@"GillSans-Bold" size:18]
    timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];


    
    photo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 55.0, 70.0)];
    photo.tag = PHOTO_TAG;
//    photo.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:photo];
    
    
    subjectNameLabel.text = [[sub objectForKey:@"subjectName"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    dayLabel.text = [[sub objectForKey:@"day"] substringToIndex:2];

    roomLabel.text = [[sub objectForKey:@"room"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // avoid 'null' displaying, when teacher has no degree
    NSString *teacherTitle = [sub objectForKey:@"teacherDegree"];
    
    teacherLabel.text = [teacherTitle isEqual:@"(null)"] ?
    [NSString stringWithFormat:@"%@ %@", [sub objectForKey:@"teacherName"], [sub objectForKey:@"teacherLastname"]]:
    [NSString stringWithFormat:@"%@. %@ %@", [sub objectForKey:@"teacherDegree"], [sub objectForKey:@"teacherName"], [sub objectForKey:@"teacherLastname"]];


//    if (teacherTitle) {
//            teacherLabel.text
//    }
//     = !!teacherTitle ?
//    [NSString stringWithFormat:@"%@. %@ %@", [sub objectForKey:@"teacherDegree"], [sub objectForKey:@"teacherName"], [sub objectForKey:@"teacherLastname"]] :
//    [NSString stringWithFormat:@"%@ %@", [sub objectForKey:@"teacherName"], [sub objectForKey:@"teacherLastname"]];

    
    NSString *timeFrom = [sub objectForKey:@"timeFrom"];
    timeFrom = [timeFrom substringToIndex:[timeFrom length] - 3];

    if ([[timeFrom substringToIndex:1] isEqualToString:@"0"]) {
        timeFrom = [timeFrom substringFromIndex:1];
    }
    

    NSString *timeTo = [sub objectForKey:@"timeTo"];
    timeTo = [timeTo substringToIndex:[timeTo length] - 3];

    
//    [str substringToIndex:[str length]-1];
    
//    timeLabel.text = [NSString stringWithFormat:@"%@ - %@", timeFrom, timeTo];
    timeLabel.text = timeFrom;
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"day-bg" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:imagePath];
    photo.image = theImage;
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIColor *seminarColor = [UIColor colorWithRed:50/255.0f green:149/255.0f blue:213/255.0f alpha:1.0f];
    UIColor *lessonColor = [UIColor colorWithRed:230/255.0f green:81/255.0f blue:67/255.0f alpha:1.0f];

    cell.backgroundColor = [[sub objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? lessonColor : seminarColor;
    
//    NSString *lectureOrSeminar = [[self.selectedLecture objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? @"prednaska" : @"cvicenie";
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailSegue" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    EROLectureDetailViewController *detailController = [segue destinationViewController];
    
    //    NSIndexPath *selectedIndexPath = [self.tableView ];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];

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
