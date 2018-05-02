//  TableViewController.h
//  MapSearchInTable
//
//  Created by Kostas Kalogirou (CERTH) on 30/01/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressesTableViewController : UITableViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//Used to identify the previous ViewContoller
@property NSString *previousViewController;
- (void)comingFrom:(NSString *)viewControllerStr;


@end
