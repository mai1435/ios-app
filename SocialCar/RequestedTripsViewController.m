    //
//  RequestedTripsViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "RequestedTripsViewController.h"

@interface RequestedTripsViewController ()

@end

@implementation RequestedTripsViewController



- (void)comingFrom:(NSString *)viewControllerStr
{
    isComingFrom = viewControllerStr;
}

/*
 In order to leave space between cells, I declare each row data as a different section in tableView. See: http://stackoverflow.com/questions/17490203/how-to-create-paddingspacing-between-rows-in-tablview
 */
//- (void)viewDidLoad {
    //[super viewDidLoad];

- (void) viewWillAppear:(BOOL)animated
{
   // [super viewWillAppear:animated];
     [super viewWillAppear:YES];
    //your code

    // Do any additional setup after loading the view.
    
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    //Get lifts
    lifts = [[NSMutableArray alloc]init];
    
    if ([isComingFrom isEqualToString:@"Passenger"])
    {
        lifts = [sharedRoutesAsPassenger lifts];
    }
    else if ([isComingFrom isEqualToString:@"Driver"])
    {
        lifts = [sharedRoutesAsDriver lifts];
    }
    
    
  //  tableData_tripStatus = [NSArray arrayWithObjects:@"Cancelled Trip",@"Pending Trip",@"Completed Trip",@"Active Trip",@"Declined Trip", @"Completed Trip",nil];
   // tableData_tripInfo = [NSArray arrayWithObjects:@"1 Glan Dafarn - 17 Beechfield Rd",@"9 Shiplake  ottom - 64 Upsall Grove",@"49 Longbank RD - 6 Boswell Rd",@"17 Beechfield Rd - 5 Priestley Way",@"1 Studd St - 11 Woodbank Ave",@"29 Castle Cres - 6 St Jones View", nil];
    
    thumbnails_tripStatus = [NSArray arrayWithObjects:@"trip_status_cancelled", @"trip_status_pending",@"trip_status_completed",@"trip_status_active",@"trip_status_declined",@"trip_status_completed", nil];
    
    
    //UITableView goes below over 50 from navigation bar. I remove the "margin" area between them
   // self.tableView_requestedTrips.contentInset = UIEdgeInsetsMake(-10,0,0,0);
   [self.tableView_requestedTrips reloadData];

}



#pragma mark - UITAbleViewDataSource
//Asks the data source for a cell to insert in a particular location of the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LiftsCell";
    LiftsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LiftsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    /* cell.nameLabel.text = [tableData objectAtIndex:indexPath.row];
     cell.thumbnailImageView.image = [UIImage imageNamed:
     [thumbnails objectAtIndex:indexPath.row]];
     cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
     */
    
    Lift *lift = [[Lift alloc]init];
    lift = [lifts objectAtIndex:indexPath.section];
    
    NSString *lift_status = lift.status;
    
    // thumbnails_tripStatus = [NSArray arrayWithObjects:@"trip_status_cancelled", @"trip_status_pending",@"trip_status_completed",@"trip_status_active",@"trip_status_declined",@"trip_status_completed", nil];
    
    //Change height;make it smaller by default and increse it when trip is COMPLETED
    tableView.rowHeight = 72.0f;
    
    if ([lift.status isEqualToString:CANCELLED])
    {
        lift_status = NSLocalizedString(@"Cancelled Trip", @"Cancelled Trip");
        cell.imageView_status.image = [UIImage imageNamed:[thumbnails_tripStatus objectAtIndex:0]];
    }
    else if ([lift.status isEqualToString:REFUSED])
    {
        lift_status = NSLocalizedString(@"Rejected trip", @"Rejected Trip");
        cell.imageView_status.image = [UIImage imageNamed:[thumbnails_tripStatus objectAtIndex:4]];
    }
    else if ([lift.status isEqualToString:PENDING])
    {
        lift_status = NSLocalizedString(@"Pending Trip", @"Pending Trip");
        cell.imageView_status.image = [UIImage imageNamed:[thumbnails_tripStatus objectAtIndex:1]];
    }
    else if ([lift.status isEqualToString:ACTIVE])
    {
        lift_status = NSLocalizedString(@"Active Trip", @"Active Trip");
        cell.imageView_status.image = [UIImage imageNamed:[thumbnails_tripStatus objectAtIndex:3]];
        
        
    }
    else if ([lift.status isEqualToString:COMPLETED])
    {
        lift_status = NSLocalizedString(@"The trip is completed", @"The trip is completed");
        cell.imageView_status.image = [UIImage imageNamed:[thumbnails_tripStatus objectAtIndex:5]];
        
        [cell.view_line setHidden:NO];
        [cell.imageView_feedback setHidden:NO];
        [cell.label_feedback setHidden:NO];
        
        cell.label_feedback.adjustsFontSizeToFitWidth = YES;
        
        //Change height;make it bigger
        tableView.rowHeight = 131.0f;

    }
    else if ([lift.status isEqualToString:REVIEWED])
    {
        lift_status = NSLocalizedString(@"The trip is completed", @"The trip is completed");
        cell.imageView_status.image = [UIImage imageNamed:[thumbnails_tripStatus objectAtIndex:5]];
        
       /* [cell.view_line setHidden:NO];
        [cell.imageView_feedback setHidden:NO];
        [cell.label_feedback setHidden:NO];
        
        cell.label_feedback.adjustsFontSizeToFitWidth = YES;
        
        //Change height;make it bigger
        tableView.rowHeight = 131.0f;
        */
    }
    
    cell.label_trip_status.text = lift_status;
    cell.label_route_instructions.text = [lift.start_address stringByAppendingString:@" - "];
    cell.label_route_instructions.text = [cell.label_route_instructions.text stringByAppendingString:lift.end_address];
    
    
    
//#define PENDING @"PENDING"
//#define ACTIVE @"ACTIVE"
//#define REFUSED @"REFUSED"
//#define COMPLETED @"COMPLETED"
//#define CANCELLED @"CANCELLED"
    
    
 /*   cell.imageView_status.image = [UIImage imageNamed:[thumbnails_tripStatus objectAtIndex:indexPath.section]]; //indexPath.row
    
    cell.label_trip_status.text = [tableData_tripStatus objectAtIndex:indexPath.section];//row];
    
    cell.label_route_instructions.text = [tableData_tripInfo objectAtIndex:indexPath.section];//row];
    
    NSString *completedStr= NSLocalizedString(@"Completed", @"Completed");
    
    //Change height;make it smaller
    tableView.rowHeight = 72.0f;
    
    if ([cell.label_trip_status.text containsString:completedStr])
    {
        [cell.view_line setHidden:NO];
        [cell.imageView_feedback setHidden:NO];
        [cell.label_feedback setHidden:NO];
        
        cell.label_feedback.adjustsFontSizeToFitWidth = YES;
        
        //Change height;make it bigger
        tableView.rowHeight = 131.0f;
    }
  */
    
  /*  UIView *theContentView = [[UIView alloc]initWithFrame:CGRectMake(0,10,tableView.bounds.size.width,tableView.rowHeight)];
    
    theContentView.backgroundColor = [UIColor grayColor];//contentColor
   
    cell.backgroundColor = [UIColor clearColor];
    [cell addSubview: theContentView];
   */
    
    return cell;
}


//return the number of rows in a given section of a table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//[tableData_tripStatus count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // return [tableData_tripStatus count];//1;//default value
    return lifts.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //this is the space
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row selected = %lu",(unsigned long)indexPath.section);
    
    
    if ([isComingFrom isEqualToString:@"Passenger"])
    {
        sharedRoutesAsPassenger.lift_selected = indexPath.section;
        
        MyTripsNavigationController *myTripsNavigationController = (MyTripsNavigationController *)self.navigationController;
        [myTripsNavigationController comingFrom:@"Passenger"];
        
        [myTripsNavigationController performSegueWithIdentifier:@"showLiftStepDetails" sender:self];
    }
    else if ([isComingFrom isEqualToString:@"Driver"])
    {
        sharedRoutesAsDriver.lift_selected = indexPath.section;
        
        MyTripsNavigationController *myTripsNavigationController = (MyTripsNavigationController *)self.navigationController;
        [myTripsNavigationController comingFrom:@"Driver"];
        
        [myTripsNavigationController performSegueWithIdentifier:@"showLiftStepDetails" sender:self];
    }
    
   
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //segueFromLifts
    
    if ([segue.identifier isEqualToString:@"segueFromLifts"])
    {
        RouteDetailsViewController *routeDetailsViewController = segue.destinationViewController;
        routeDetailsViewController.comingFrom = 2;
    }

    
}
*/


@end
