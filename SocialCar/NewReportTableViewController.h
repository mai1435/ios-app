//
//  NewReportTableViewController.h
//  SocialCar
//
//  Created by Vittorio Tauro on 01/08/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface NewReportTableViewController : UITableViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL from;

- (void)setTextFieldSource:(BOOL)from;

@end
