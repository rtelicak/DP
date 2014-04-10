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

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIView *wrapper;

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
    
    // remove padding from table view
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    

//    self.tableView.separatorColor = [UIColor colorWithRed:229/255.0f green:229/255.0f blue:229/255.0f alpha:1.0f];
//    UIColor * colorCCC = [UIColor colorWithRed:0/255.0f green:12/255.0f blue:204/255.0f alpha:0.3f];
    UIColor * colord4d4d4 = [UIColor colorWithRed:213/255.0f green:213/255.0f blue:213/255.0f alpha:0.3f];
    self.tableView.separatorColor = colord4d4d4;
    
    // disabled add button if list already exits in favourites
    if ([EROScheduleSearchCriterion isScheduleCriterionAlreadyInFavourites:self.scheduleArguments]) {
        self.addFavouriteButton.enabled = NO;
    }
    
    // add title to navigtion bar
//    NSString *title = [[NSString alloc] initWithFormat:@"%@ %@. ročník %@ %@. krúžok ", self.scheduleArguments.facultyCode, self.scheduleArguments.year, self.scheduleArguments.departmentCode, self.scheduleArguments.groupNumber];
//    self.navigationItem.title = title;
    
   

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:44/255.0f green:62/255.0f blue:80/255.0f alpha:1.0f]; //2C3E50
    label.text = [[NSString alloc] initWithFormat:@"%@ %@. ročník %@ %@. krúžok ", self.scheduleArguments.facultyCode, self.scheduleArguments.year, self.scheduleArguments.departmentCode, self.scheduleArguments.groupNumber];
    
//    label.text = @"aaaa bbb ccc dddd eeeeee ffff ggggg";

    [label sizeToFit];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 50)];
    
    [titleView addSubview:label];
    [label setCenter:titleView.center];
    

    self.navigationItem.titleView = titleView;
    
    
    //
    
    NSLog(@"%@", self.scheduleArguments);
    
    [self createSegmetedUiControl];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // top offset
//    [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)];
    // creating uisegmentedcontrol programatically
    
}

-(void) createSegmetedUiControl {
    self.wrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    
    self.wrapper.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:0.97f];
//    UIColor * color = [UIColor colorWithRed:241/255.0f green:245/255.0f blue:251/255.0f alpha:1.0f];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Compulsory", @"Optional", nil]];
    self.segmentedControl.frame = CGRectMake(35, 10, 250, 30);
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = [UIColor colorWithRed:44/255.0f green:62/255.0f blue:80/255.0f alpha:1.0f]; //2C3E50
    [self.segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    
    [self.wrapper addSubview:self.segmentedControl];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.wrapper;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (void)valueChanged:(UISegmentedControl *)segment {
        
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:{
            // display all lessons
            self.lecturesArray = [ERODatabaseAccess getLessonsWithFacultyCode:self.scheduleArguments.facultyCode year:self.scheduleArguments.year departmentCode:self.scheduleArguments.departmentCode groupNumber:self.scheduleArguments.groupNumber];
            break;
        }
            
        case 1:{
            // display compulsory only
            self.lecturesArray = [ERODatabaseAccess getCompulsoryOnlyWithFacultyCode:self.scheduleArguments.facultyCode year:self.scheduleArguments.year departmentCode:self.scheduleArguments.departmentCode groupNumber:self.scheduleArguments.groupNumber];
            break;
        }
            
        case 2: {
            //display optional only
            self.lecturesArray = [ERODatabaseAccess getOptionalOnlyWithFacultyCode:self.scheduleArguments.facultyCode year:self.scheduleArguments.year departmentCode:self.scheduleArguments.departmentCode groupNumber:self.scheduleArguments.groupNumber];
            break;
        }
    }

    [self.tableView reloadData];
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
    subjectNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
    subjectNameLabel.textAlignment = NSTextAlignmentLeft;
    subjectNameLabel.textColor = [UIColor whiteColor];
    subjectNameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//    subjectNameLabel.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:subjectNameLabel];
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 45.0, 60.0)];
    dayLabel.tag = SECONDLABEL_TAG;
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:36.0];
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
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(220.0, 20.0, 75.0, 25.0)];
    timeLabel.tag = SECONDLABEL_TAG;
//    timeLabel.font = [UIFont systemFontOfSize:28.0];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor whiteColor];
//    timeLabel.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:timeLabel];
//    [UIFont fontWithName:@"GillSans-Bold" size:18]
    timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];


    
    photo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 55.0, 71.0)];
    photo.tag = PHOTO_TAG;
//    photo.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:photo];
    
    // subject name
    subjectNameLabel.text = [[sub objectForKey:@"subjectName"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // day
    dayLabel.text = [[sub objectForKey:@"day"] substringToIndex:2];
    
    // room
    roomLabel.text = [[sub objectForKey:@"room"]stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    
    // teacher
    // avoid 'null' displaying, when teacher has no degree
    NSString *teacherTitle = [sub objectForKey:@"teacherDegree"];
    
    teacherLabel.text = [teacherTitle isEqual:@"(null)"] ?
    [NSString stringWithFormat:@"%@ %@", [sub objectForKey:@"teacherName"], [sub objectForKey:@"teacherLastname"]]:
    [NSString stringWithFormat:@"%@. %@ %@", [sub objectForKey:@"teacherDegree"], [sub objectForKey:@"teacherName"], [sub objectForKey:@"teacherLastname"]];

    // time
    NSString *timeFrom = [sub objectForKey:@"timeFrom"];
    timeFrom = [timeFrom substringToIndex:[timeFrom length] - 3];

    if ([[timeFrom substringToIndex:1] isEqualToString:@"0"]) {
        timeFrom = [timeFrom substringFromIndex:1];
    }
    
    NSString *timeTo = [sub objectForKey:@"timeTo"];
    timeTo = [timeTo substringToIndex:[timeTo length] - 3];
    
    timeLabel.text = timeFrom;
    
    // image
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"day-bg" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:imagePath];
    photo.image = theImage;
    
    // colors
    UIColor *seminarColor = [UIColor colorWithRed:50/255.0f green:149/255.0f blue:213/255.0f alpha:1.0f];
    UIColor *lessonColor = [UIColor colorWithRed:230/255.0f green:81/255.0f blue:67/255.0f alpha:1.0f];

//    cell.backgroundColor = [[sub objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? lessonColor : seminarColor;
//    cell.backgroundColor = [UIColor whiteColor];
//    NSString *lectureOrSeminar = [[self.selectedLecture objectForKey:@"subjectIsLecture"]  isEqual: [NSNumber numberWithInt:1]] ? @"prednaska" : @"cvicenie";
    
    // set cell's background depending on day
    UIColor *grayColor = [UIColor colorWithRed:52/255.0f green:72/255.0f blue:92/255.0f alpha:1.0f];
    UIColor *darkOrange = [UIColor colorWithRed:192/255.0f green:57/255.0f blue:43/255.0f alpha:1.0f];
    UIColor *lightOrange = [UIColor colorWithRed:230/255.0f green:86/255.0f blue:73/255.0f alpha:1.0f];;
    UIColor *purple = [UIColor colorWithRed:153/255.0f green:91/255.0f blue:180/255.0f alpha:1.0f];
    UIColor *darkBlue = [UIColor colorWithRed:41/255.0f green:128/255.0f blue:185/255.0f alpha:1.0f];
    UIColor *lightBlue = [UIColor colorWithRed:50/255.0f green:149/255.0f blue:212/255.0f alpha:1.0f];
    UIColor * color = [UIColor colorWithRed:50/255.0f green:256/255.0f blue:0/255.0f alpha:1.0f];
    UIColor *pumpkin = [UIColor colorWithRed:211/255.0f green:84/255.0f blue:0/255.0f alpha:1.0f];
    UIColor *concrete = [UIColor colorWithRed:149/255.0f green:165/255.0f blue:166/255.0f alpha:1.0f];
    
    
    
    int id_day = [[sub objectForKey:@"id_day"] intValue];
    
    switch (id_day)  {
            
        case 1: {
            cell.backgroundColor = grayColor;
            break;
        }
        case 2: {
            cell.backgroundColor = darkOrange;
            break;
        }

        case 3: {
            cell.backgroundColor = lightOrange;
            break;
        }

        case 4: {
            cell.backgroundColor = darkBlue;
            break;
        }
        case 5: {
            cell.backgroundColor = lightBlue;
            break;
        }
    }
    
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
    
    self.title = @"";
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
