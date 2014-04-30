//
//  EROSubjectsList.m
//  Rozvrh
//
//  Created by Roman Telicak on 16/04/14.
//  Copyright (c) 2014 Roman Telicak. All rights reserved.
//

#import "EROSubjectsList.h"
#import "ERODatabaseAccess.h"
#import "EROLectureDetailViewController.h"
#import "EROUtility.h"
#import "EROScheduleSearchCriterion.h"
#import "EROColors.h"


@interface EROSubjectsList ()

@end

@implementation EROSubjectsList

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
    [self styleView];
    
    NSLog(@"%@", self.scheduleArguments);
}

// remove selection state on rows
- (void) viewWillAppear:(BOOL)animated {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    [super viewWillAppear:animated];
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
    [cell.contentView addSubview:subjectNameLabel];
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 45.0, 60.0)];
    dayLabel.tag = SECONDLABEL_TAG;
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:36.0];
    dayLabel.textAlignment = NSTextAlignmentLeft;
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [cell.contentView addSubview:dayLabel];
    
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
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:timeLabel];
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
    
    int id_day = [[sub objectForKey:@"id_day"] intValue];
    
    switch (id_day)  {
            
        case 1: {
            cell.backgroundColor = [EROColors mondayColor];
            break;
        }
        case 2: {
            cell.backgroundColor = [EROColors tuesdayColor];
            break;
        }
            
        case 3: {
            cell.backgroundColor = [EROColors wednesdayColor];
            break;
        }
            
        case 4: {
            cell.backgroundColor = [EROColors thursdayColor];
            break;
        }
        case 5: {
            cell.backgroundColor = [EROColors fridayColor];
            break;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

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

- (IBAction)segmentedControlValueChanged:(id)sender {
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:{
            // display compulsory only
            self.lecturesArray = [ERODatabaseAccess getCompulsoryOnlyWithFacultyCode:self.scheduleArguments.facultyCode year:self.scheduleArguments.year departmentCode:self.scheduleArguments.departmentCode groupNumber:self.scheduleArguments.groupNumber];
            break;
        }
            
        case 1:{
            //display optional only
            self.lecturesArray = [ERODatabaseAccess getOptionalOnlyWithFacultyCode:self.scheduleArguments.facultyCode year:self.scheduleArguments.year departmentCode:self.scheduleArguments.departmentCode groupNumber:self.scheduleArguments.groupNumber];
            break;
        }
            
        case 2: {
            // display all lessons
            self.lecturesArray = [ERODatabaseAccess getLessonsWithFacultyCode:self.scheduleArguments.facultyCode year:self.scheduleArguments.year departmentCode:self.scheduleArguments.departmentCode groupNumber:self.scheduleArguments.groupNumber];
            break;
        }
    }
    
    [self.tableView reloadData];

}

-(void) styleView {
    
    // disabled add button if list already exits in favourites
    if ([EROScheduleSearchCriterion isScheduleCriterionAlreadyInFavourites:self.scheduleArguments]) {
        self.addFavouriteButton.enabled = NO;
    }

    // remove padding from table view
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIColor * colord4d4d4 = [UIColor colorWithRed:213/255.0f green:213/255.0f blue:213/255.0f alpha:0.3f];
    self.tableView.separatorColor = colord4d4d4;
    
    // navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // create navigation view
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationItem.titleView.bounds.size.width, 150)];
    
    // add label to it
    UILabel *navigationTitleLabel = [self createNavigationTitleLabel];
    [titleView addSubview:navigationTitleLabel];
    [navigationTitleLabel setCenter:titleView.center];
    
    self.navigationItem.titleView = titleView;
    
    // segmented control
    self.segmentedControl.tintColor = [EROColors mainColor];
    
    
    // back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-icon.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backAction)];
    backButton.tintColor = [EROColors mainColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem.tintColor = [EROColors mainColor];
}
-(void) backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UILabel *) createNavigationTitleLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [EROColors mainLabelColor];
    label.text = [[NSString alloc] initWithFormat:@"%@ %@. ročník %@ %@. krúžok ", self.scheduleArguments.facultyCode, self.scheduleArguments.year, self.scheduleArguments.departmentCode, self.scheduleArguments.groupNumber];
    
    [label sizeToFit];
    
    return label;
}

















@end
