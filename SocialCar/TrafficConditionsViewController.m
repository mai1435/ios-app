//
//  TrafficConditionsViewController.m
//  SocialCar
//
//  Created by  Kostas Kalogirou (CERTH) on 24/07/17.
//  Copyright © 2017  Kostas Kalogirou (CERTH)  All rights reserved.
//

#import "TrafficConditionsViewController.h"
#import "TrafficConditionsTableViewCell.h"
#import "MNFloatingActionButton.h"
#import "MBProgressHUD.h"

@interface TrafficConditionsViewController ()

@end

@implementation TrafficConditionsViewController
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    myTools = [[MyTools alloc]init];
    
    self.title = NSLocalizedString(@"Traffic Conditions", @"Traffic Conditions");
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];

    self.navigationItem.rightBarButtonItem = addButton;
    sharedProfile = [SharedProfileData sharedObject];
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    tableView.delegate = self;
    tableView.separatorColor = [UIColor clearColor];
    
    [self retrieveReports];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 500; // meters //see that
        
        [self.locationManager startUpdatingLocation];
    }

    lastLat = 0.0f;
    lastLng = 0.0f;
    //Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    reportsArray = @[];
    [tableView reloadData];
    
    self.title = NSLocalizedString(@"Traffic Conditions", @"Traffic Conditions");
    
    [self retrieveReports];
    //Do any additional setup after loading the view.

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.title = NSLocalizedString(@"Back", @"Back");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(id)sender{
    [self performSegueWithIdentifier:@"toReportSubmission" sender:self];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"TrafficConditionsTableViewCell";
    
    TrafficConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[TrafficConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.reportPriority.text = [[reportsArray objectAtIndex:indexPath.row] objectForKey:@"severity"];
    if ([[[reportsArray objectAtIndex:indexPath.row] objectForKey:@"severity"] isEqualToString:@"HIGH"]) {
        cell.reportPriority.textColor = [UIColor redColor];
    }else if ([[[reportsArray objectAtIndex:indexPath.row] objectForKey:@"severity"] isEqualToString:@"MEDIUM"]){
        cell.reportPriority.textColor = [UIColor orangeColor];
    }else{
        cell.reportPriority.textColor = [UIColor greenColor];
    }
    
    cell.reportType.text = [[reportsArray objectAtIndex:indexPath.row] objectForKey:@"category"];
    cell.reportDetail.text =  [[[reportsArray objectAtIndex:indexPath.row] objectForKey:@"location"] objectForKey:@"address"];
    
    NSDate *timestamp = [[NSDate new] initWithTimeIntervalSince1970: [[[reportsArray objectAtIndex:indexPath.row] objectForKey:@"timestamp"] integerValue]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateFormatHour = [[NSDateFormatter alloc] init];
    [dateFormatHour setDateFormat:@"HH:mm"];
    
    cell.reportDate.text = [dateFormat stringFromDate:timestamp];
    cell.reportHour.text = [dateFormatHour stringFromDate:timestamp];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return reportsArray.count;
}

#pragma mark - Retrieve Reports (as driver)
-(void) retrieveReports
{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_RETRIEVE_REPORTS;
    
    ulrStr = [ulrStr stringByAppendingString:[NSString stringWithFormat:@"-around?lat=%.8f&lon=%.8f&radius=80", lastLat, lastLng]];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWithString=%@",urlWithString);
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:@"GET"];
    
    //5. Send Request to Server
    //?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
    //?        [dataTask resume];
    //create the task
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                          [MBProgressHUD hideHUDForView:self.view animated:YES];

                                          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                          NSLog(@"ParseJson[retrieveReports]=%@", json);
                                          
                                          reportsArray = [json objectForKey:@"reports"];
                                          NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"timestamp" ascending: NO];
                                          [reportsArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
                                          [tableView reloadData];
                                      });

                                  }];
    [task resume];
    
    
}


#pragma mark - CLLocationManagerDelegate
//From CLLocationManagerDelegate
/*
 Tells the delegate that the location manager was unable to retrieve a location value.
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSString *error_title = NSLocalizedString(@"Error", @"Error");
    NSString *ok= NSLocalizedString(@"OK", @"OK");
    
    UIAlertController *alertOK   =   [UIAlertController
                                      alertControllerWithTitle:error_title
                                      message:error.description
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:ok
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alertOK dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alertOK addAction:okAction];
    //[self presentViewController:alertOK animated:NO completion:nil];
    
}

//From CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *crnLoc = [locations lastObject];
    NSString *longit_lat = [NSString stringWithFormat:@"%.8f - %.8f",crnLoc.coordinate.longitude,crnLoc.coordinate.latitude];
    NSLog(@"%@", longit_lat);
    lastLat = crnLoc.coordinate.latitude;
    lastLng = crnLoc.coordinate.longitude;
    [self retrieveReports];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
