//
//  TableViewController.m
//  MapSearchInTable
//
//  Created by Kostas Kalogirou (CERTH) on 30/01/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "AddressesTableViewController.h"
#import "HomePassengerViewController.h"
#import "HomeSegmentsViewController.h"
#import "MyCustomAnnotation.h"

@interface AddressesTableViewController ()

@end

@implementation AddressesTableViewController

MKLocalSearch *localSearch;
MKLocalSearchResponse *results;

- (void)comingFrom:(NSString *)viewControllerStr
{
    self.previousViewController = viewControllerStr;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    /*
     Likewise we will also use the table view controller to update the search results by having it implement the UISearchResultsUpdating protocol.
     */
    self.searchController.searchResultsUpdater = self;
    
    /*
     We do not want to dim the underlying content as we want to show the filtered results as the user types into the search bar.
     */
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    //[self.view addSubview:self.searchController.searchBar];
    //[self.searchController.searchBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)]; //==//self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
    
    [self.searchController.searchBar sizeToFit];
    
    self.searchController.delegate = self;
    
    [self.searchController setActive:YES];
	[self.searchController setHidesNavigationBarDuringPresentation:false];
	[self.searchController.searchBar setTintColor:[UIColor whiteColor]];

}

//Method from UISearchControllerDelegate
//see http://stackoverflow.com/questions/27951965/cannot-set-searchbar-as-firstresponder
- (void)didPresentSearchController:(UISearchController *)searchController
{
    //Set focus inside searchbar via this method;
    //Before you had to set [self.searchController setActive:YES]
    [searchController.searchBar becomeFirstResponder];
}

//From UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    // Cancel any previous searches.
    [localSearch cancel];
    
    // Perform a new search.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.searchController.searchBar.text;
   
    //Get the viewContollers currently on the navigation stack.
    NSArray *viewControllers = [self.navigationController viewControllers];
    
    HomePassengerViewController *viewController;
    //Coming as Passenger
    if (![self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
    {
        HomeSegmentsViewController *segmentsViewController =
            [viewControllers objectAtIndex:0];
    
        viewController = (HomePassengerViewController *)segmentsViewController.currentViewController;
    }
    else //Coaming As driver
    {
        //NSArray *viewContollers = self.navigationController.viewControllers;
        viewController = (HomePassengerViewController *) [viewControllers objectAtIndex:2];
    }
    
    //Set to the current region for make search more robust
	request.region = viewController.mapView.region;
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        /*   if (error != nil) {
         [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Map Error",nil)
         message:[error localizedDescription]
         delegate:nil
         cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil] show];
         return;
         }
         */
        
        /*  if ([response.mapItems count] == 0) {
         [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Results",nil)
         message:nil
         delegate:nil
         cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil] show];
         return;
         }
         */
        
        results = response;
        
        [self.tableView reloadData];
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}*/

//For tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [results.mapItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDENTIFIER = @"SearchResultsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
    }
    
    MKMapItem *item = results.mapItems[indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.placemark.addressDictionary[@"Street"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // [self.searchDisplayController setActive:NO animated:YES];
    
    MKMapItem *item = results.mapItems[indexPath.row];
    
    
    if (![self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
   
    HomePassengerViewController *viewController;
    
   // HomeViewController *viewController = (HomeViewController *)self.navigationController.topViewController;
    if (![self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
    {
        HomeSegmentsViewController *segmentsViewController =
            (HomeSegmentsViewController *)self.navigationController.topViewController;
    
        viewController = (HomePassengerViewController *)segmentsViewController.currentViewController;
    }
    else
    {
        
        NSArray *viewControllers = self.navigationController.viewControllers;
        viewController = (HomePassengerViewController *) [viewControllers objectAtIndex:2];
    }
    
    viewController.mapItem = item;
    viewController.special_case = NO; //init to default
	
    //Use my own NSMutuableArray and compare it with mapView.annotations
    if (viewController.addressStatus == 0)
    {
        viewController.txtfield_startAddress.text = results.mapItems[indexPath.row].name;
        
        ////// Added
        //
        MKMapItem *item_origin = results.mapItems[indexPath.row];
        CLLocationCoordinate2D origin_coordinate = [item_origin.placemark coordinate];
        
        NSLog(@"******  [AddressTableView ORIGIN] *****");
        NSLog(@"origin_coordinate.longitude=%f",origin_coordinate.longitude);
        NSLog(@"origin_coordinate.latitude=%f",origin_coordinate.latitude);
        NSLog(@"******  [End of AddressTableView ORIGIN] *****");
		
		if (viewController.annotationViewStart!=nil){
			[viewController.mapView removeAnnotation:viewController.annotationViewStart];
		}
		viewController.annotationViewStart = item.placemark;
        ///// Added
//        if (viewController.mapView.annotations.count == 0)
//        {
//            NSLog(@"\n mapView.annotations.count  ==  0");
//
//            if (viewController.annotationViews.count !=0)
//            {
//                [viewController.annotationViews replaceObjectAtIndex:0 withObject:item.placemark];
//            }
//            else
//            {
//                [viewController.annotationViews addObject:item.placemark];
//            }
//
//        }
//        else if (viewController.mapView.annotations.count ==1)
//        {
//
//            NSLog(@"\n mapView.annotations.count  == 1 ");
//
//            if ([viewController.mapView.annotations[0] isKindOfClass:[MKUserLocation class]])
//            {
//                viewController.mapView.showsUserLocation = NO;//delete user location
//                NSLog(@"annotationViews.count(lu)=%lu",(unsigned long)viewController.annotationViews.count);
//
//                //Now, mapView.annotations.count  = 0 so viewForAnnotation will execute two
//                // timew with addressStatus =0, thus twice icon A will appear.
//                //Set special_case
//                if (viewController.annotationViews.count == 2) ///1)
//                {
//                    NSLog(@"**** SPECIAL CASE ***** ");
//                    viewController.special_case = YES;
//                }
//            }
//            else
//            {
//                [viewController.mapView removeAnnotation:viewController.mapView.annotations[0] ];
//            }
//
//            if (viewController.annotationViews.count != 0)
//            {
//                [viewController.annotationViews replaceObjectAtIndex:0 withObject:item.placemark];
//            }
//            else
//            {
//                 [viewController.annotationViews addObject:item.placemark]; //Add item.placemark
//            }
//
//
//
//            for (int i=0; i< viewController.mapView.annotations.count;i++)
//            {
//                NSLog(@"\nmapView annotaions[%d] = %@",i,[viewController.mapView.annotations[i] title]);
//            }
//            for (int i=0; i< viewController.annotationViews.count;i++)
//            {
//                NSLog(@"\n annotationViews[%d] = %@",i,[viewController.annotationViews[i] title]);
//            }
//            NSLog(@"\n CASE addressStatus == 0 - DESTINATION NOT FILLED");
//
//            NSLog(@"\n ");
//
//        }
////*********>>>>>CASE WHERE DESTINATION IS FILLED
//        else if (viewController.mapView.annotations.count  == 2)
//        {
//
//            NSLog(@"\n mapView.annotations.count  == 2 ");
//            NSLog(@"\n ----- CASE addressStatus == 0 AND DESTINATION FILLED ");
//
//            if ([viewController.mapView.annotations isEqualToArray:viewController.annotationViews])
//            {
//                [viewController.annotationViews replaceObjectAtIndex:0 withObject:item.placemark];
//
//                //Check if user location exists in maoView.annotaions
//                if ([viewController.mapView.annotations[0] isKindOfClass:[MKUserLocation class]])
//                {
//                    NSLog(@"Instance of MKUserLocation class found!!!!");
//                    viewController.mapView.showsUserLocation = NO;
//                }
//                else
//                {
//                    [viewController.mapView removeAnnotation:viewController.mapView.annotations[0] ];
//                }
//            }
//            else //Contains CASE USER LOCATION -EDW!
//            {
//                //flag to check if MKUserLocation instance found among mapView annotations
//                BOOL UserLocationFound = NO;
//
//                for (int i=0;i<viewController.mapView.annotations.count;i++)
//                {
//                    if ([viewController.mapView.annotations[i] isKindOfClass:[MKUserLocation class]])
//                    {
//                        NSLog(@"Instace of MKUserLocation class found!!!!");
//                        viewController.mapView.showsUserLocation = NO;
//                        UserLocationFound = YES;
//                    }
//                }
//
//                for (int i=0;i<viewController.mapView.annotations.count;i++)
//                {
//                    NSLog(@"\nmapView.annotations[%d] = %@",i,[viewController.mapView.annotations[i] title]);
//                }
//
//                [viewController.annotationViews replaceObjectAtIndex:0 withObject:item.placemark];
//
//                if (!UserLocationFound)
//                {
//                   [viewController.mapView removeAnnotation:viewController.mapView.annotations[1] ];
//                    //-> Call ths viewForAnnotation two times
//                    //-> [viewController.mapView removeAnnotations:viewController.mapView.annotations ];
//                }
//            }
//
//            for (int i=0; i< viewController.mapView.annotations.count;i++)
//            {
//                NSLog(@"\nmapView.annotations[%d] = %@",i,[viewController.mapView.annotations[i] title]);
//            }
//
//            for (int i=0; i< viewController.annotationViews.count;i++)
//            {
//                NSLog(@"\nannotationViews[%d] = %@",i,[viewController.annotationViews[i] title]);
//            }
//            NSLog(@"\n ---- END OF CASE addressStatus == 0 AND DESTINATION FILLED ");
//            NSLog(@"\n ");
//        }
    }
    else if (viewController.addressStatus == 1)
    {
        viewController.txtfield_setDestinationAddress.text = results.mapItems[indexPath.row].name;
        
        ////// Added
        //
        MKMapItem *item_destination = results.mapItems[indexPath.row];
        CLLocationCoordinate2D destination_coordinate = [item_destination.placemark coordinate];
        
        NSLog(@"******  [AddressTableView DESTINATION] *****");
        NSLog(@"destination_coordinate.longitude=%f",destination_coordinate.longitude);
        NSLog(@"destination_coordinate.latitude=%f",destination_coordinate.latitude);
        NSLog(@"******  [End of AddressTableView DESTINATION] *****");
        
        ///// Added
		if (viewController.annotationViewStop!=nil){
			[viewController.mapView removeAnnotation:viewController.annotationViewStop];
		}
		viewController.annotationViewStop = item.placemark;

//        if (viewController.mapView.annotations.count-viewController.annotationViewsWaypoints.count == 1)
//        {
//
//            if (viewController.annotationViews.count == 0 )
//            {
//                [viewController.annotationViews addObject:viewController.mapView.annotations[0]];
//                [viewController.annotationViews addObject:item.placemark];
//            }
//            else if (viewController.annotationViews.count == 1 )
//            {
//                [viewController.annotationViews addObject:item.placemark];
//            }
//            else
//            {
//                [viewController.annotationViews replaceObjectAtIndex:1 withObject:item.placemark];
//            }
//
//            NSLog(@"\n CASE addressStatus == 1 ");
//            NSLog(@"\n ");
//        }
//        else  if (viewController.mapView.annotations.count-viewController.annotationViewsWaypoints.count > 1)
//        {
//            if ([viewController.mapView.annotations isEqualToArray:viewController.annotationViews])
//            {
//                [viewController.annotationViews replaceObjectAtIndex:0 withObject:viewController.mapView.annotations[0] ];
//                [viewController.annotationViews replaceObjectAtIndex:1 withObject:item.placemark];
//
//                [viewController.mapView removeAnnotation:viewController.mapView.annotations[1] ];
//            }
//            else
//            {
//                //[viewController.annotationViews replaceObjectAtIndex:0 withObject:viewController.mapView.annotations[0] ];
//                [viewController.annotationViews replaceObjectAtIndex:1 withObject:item.placemark];
//
//                [viewController.mapView removeAnnotation:viewController.mapView.annotations[0] ];
//
//            }
//
//            NSLog(@"\n CASE addressStatus == 1 ");
//
//            for (int i=0; i< viewController.annotationViews.count;i++)
//            {
//                NSLog(@"\nmannotationViews[%d] = %@",i,[viewController.annotationViews[i] title]);
//            }
//
//            NSLog(@"\n ");
//        }
	}else{
		[viewController.annotationViewsWaypoints addObject:item.placemark];
	}
    ////////Check it
    if (viewController.addressStatus == 0)
    {
        viewController.txtfield_startAddress.text = results.mapItems[indexPath.row].name;
        viewController.txtfield_startAddress.backgroundColor = [UIColor clearColor];
        
//        for (int i=0; i< viewController.mapView.annotations.count;i++)
//        {
//            NSLog(@"\nmapView.annotation[%d] = %@",i,[viewController.mapView.annotations[i] title]);
//        }
		
    }
    else if (viewController.addressStatus == 1)
    {
        viewController.txtfield_setDestinationAddress.text = results.mapItems[indexPath.row].name;
        viewController.txtfield_setDestinationAddress.backgroundColor = [UIColor clearColor];
        
//        for (int i=0; i< viewController.mapView.annotations.count;i++)
//        {
//            NSLog(@"\nmapView.annotation[%d] = %@",i,[viewController.mapView.annotations[i] title]);
//        }
//
//        for (int i=0; i< viewController.annotationViews.count;i++)
//        {
//            NSLog(@"\nannotationViews[%d] = %@",i,[viewController.annotationViews[i] title]);
//        }
		
	}else{
		((UITextField*)[viewController.view viewWithTag:viewController.addressStatus]).text = results.mapItems[indexPath.row].name;
		((UITextField*)[viewController.view viewWithTag:viewController.addressStatus]).backgroundColor = [UIColor clearColor];
		((UITextField*)[viewController.view viewWithTag:viewController.addressStatus]).userInteractionEnabled = false;
	}
 ////////End of check it
 
    NSLog(@"[tableView:didSelectRowAtIndexPath]....");
    
    for (int i=0; i< viewController.annotationViews.count;i++)
    {
        NSLog(@"\nnotationViews[%d] = %@",i,[viewController.annotationViews[i] title]);
    }
	
    [viewController.mapView addAnnotations:[viewController.annotationViews arrayByAddingObjectsFromArray:viewController.annotationViewsWaypoints]];
	if(viewController.annotationViewStart){
		[viewController.mapView addAnnotation:viewController.annotationViewStart];
	}
	if(viewController.annotationViewStop){
		[viewController.mapView addAnnotation:viewController.annotationViewStop];
	}
    
    //[viewController.mapView selectAnnotation:item.placemark animated:YES];
    
    [viewController.mapView setCenterCoordinate:item.placemark.location.coordinate animated:YES];
    
    [viewController.mapView setUserTrackingMode:MKUserTrackingModeNone];
    

    ////////////////// 3rd try store pos in MyCustomAnnotation <MKAnnotation>
/*    CLLocationCoordinate2D customCoordinates = CLLocationCoordinate2DMake (item.placemark.coordinate.latitude, item.placemark.coordinate.longitude);
    
    MyCustomAnnotation *customAnnotation = [[MyCustomAnnotation alloc] initWithTitle:item.placemark.title Location:customCoordinates ];
    
    [customAnnotation setPosInArray:viewController.addressStatus];
    NSLog(@"customAnnotation getPosInArray=%d",[customAnnotation posInArray]);
    
    //Set values to textfield
    //if (viewController.addressStatus == 0)
    if ([customAnnotation posInArray] == 0)
    {
        viewController.txtfield_startAddress.text = results.mapItems[indexPath.row].name;
        viewController.txtfield_startAddress.backgroundColor = [UIColor clearColor];
        [viewController.annotationViews insertObject:customAnnotation atIndex:0];
        //[viewController.annotationViews addObject:customAnnotation];
       
        for (int i=0; i< viewController.annotationViews.count;i++)
        {
            NSLog(@"annotationViews title[%d] = %@",i,[viewController.annotationViews[i] title]);
        }
        
    }
    else if ([customAnnotation posInArray] == 1)
    {
        viewController.txtfield_setDestinationAddress.text = results.mapItems[indexPath.row].name;
        viewController.txtfield_setDestinationAddress.backgroundColor = [UIColor clearColor];
        
        [viewController.annotationViews insertObject:customAnnotation atIndex:1];
        //[viewController.annotationViews addObject:customAnnotation];
        
        for (int i=0; i< viewController.annotationViews.count;i++)
        {
            NSLog(@"annotationViews title[%d] = %@",i,[viewController.annotationViews[i] title]);
        }
        
    }
    
    [viewController.mapView removeAnnotations:viewController.mapView.annotations];
    [viewController.mapView addAnnotations:viewController.annotationViews];
    
 //END of 3rd try
 --> */
    
    
    NSLog(@"After addAnnotation");
        
    for (int i=0; i< viewController.mapView.annotations.count;i++)
    {
        NSLog(@"mapView.annotations title[%d] = %@",i,[viewController.mapView.annotations[i] title]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self.navigationController popToViewController:viewController animated:YES];
    
}



/*- (IBAction)unwindToPrevious:(UIStoryboardSegue *)unwindSegue
{
    [self performSegueWithIdentifier:@"UnWIndToMap" sender:self];
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
