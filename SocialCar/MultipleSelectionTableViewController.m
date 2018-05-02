//
//  MultipleSelectionTableViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 28/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "MultipleSelectionTableViewController.h"


@interface MultipleSelectionTableViewController ()
{
    SharedProfileData *sharedProfile; //private declaration
}

@end

@implementation MultipleSelectionTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
   // p.sharedProfile
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    sharedProfile = [SharedProfileData sharedObject];
   
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    //Set title
    [self setTitle:self.txtfieldEnteredTitle];
    
   // [self.tableView reloadData];
 
 /*?
    //Table data for Travel Modes
    NSString *bus = NSLocalizedString(@"BUS", @"BUS");
    NSString *car_pooling = NSLocalizedString(@"CAR POOLING", @"CAR POOLING");
    NSString *feet = NSLocalizedString(@"FEET", @"FEET");
    NSString *metro = NSLocalizedString(@"METRO", @"METRO");
    NSString *rail = NSLocalizedString(@"RAIL", @"RAIL");
    NSString *tram = NSLocalizedString(@"TRAM", @"TRAM");
    
    tableTravelModes = [NSArray arrayWithObjects:bus,car_pooling,feet,metro,rail,tram, nil];

    //Table Data for Optimise Travel Solutions
    NSString *cheapest = NSLocalizedString(@"CHEAPEST", @"CHEAPEST");
    NSString *comfort = NSLocalizedString(@"COMFORT", @"COMFORT");
    NSString *fastest = NSLocalizedString(@"FASTEST", @"FASTEST");
    NSString *safest = NSLocalizedString(@"SAFEST", @"SAFEST");
    NSString *shortest = NSLocalizedString(@"SHORTEST", @"SHORTEST");
    
    tableOptimiseTravelSolutions = [NSArray arrayWithObjects:cheapest,comfort,fastest,safest,shortest, nil];
    
    
    //Table Data for Special Needs
    NSString *wheelchair = NSLocalizedString(@"WHEELCHAIR", @"WHEELCHAIR");
    NSString *deaf = NSLocalizedString(@"DEAF", @"DEAF");
    NSString *blind = NSLocalizedString(@"BLIND", @"BLIND");
    NSString *elderly = NSLocalizedString(@"ELDERLY", @"ELDERLY");
    
    tableSpecialNeeds = [NSArray arrayWithObjects:wheelchair,deaf,blind,elderly,nil];
  ?  */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MultipleSelectionCell";
    //NSString *yes = NSLocalizedString(@"Yes", @"Yes");
    //NSString *no = NSLocalizedString(@"No", @"No");

    NSString *yes = @"Yes";
    NSString *no = @"No";

    
    MultipleSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MultipleSelections" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    if ([self.txtfieldEnteredTitle isEqualToString: TRAVEL_MODES])
    {
        cell.label_settingTitle.text = commonData.tableTravelModes[indexPath.section];
        
        if (sharedProfile.tableTravelModesValues == nil)
        {
            sharedProfile.tableTravelModesValues = [NSMutableArray arrayWithObjects:no,no,no,no,no,no, nil];
            
           // sharedProfile.tableTravelModesValues_StringValues_Selected = [[NSMutableArray alloc]init];
        }
        else
        {
            if ([sharedProfile.tableTravelModesValues[indexPath.section] isEqualToString:yes])
            {
                [cell.switch_setting setOn: YES animated: YES];
                
            }
            else
            {
                [cell.switch_setting setOn: NO animated: YES];
            }
        }
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: OPTIMISE_TRAVEL_SOLUTIONS])
    {
        cell.label_settingTitle.text = commonData.tableOptimiseTravelSolutions[indexPath.section];
        
        if (sharedProfile.tableOptimiseTravelSolutions == nil)
        {
             sharedProfile.tableOptimiseTravelSolutions = [NSMutableArray arrayWithObjects:no,no,no,no,no, nil];
            
            // sharedProfile.tableOptimiseTravelSolutions_StringValues_Selected = [[NSMutableArray alloc]init];
        }
        else
        {
            
            if ([sharedProfile.tableOptimiseTravelSolutions[indexPath.section] isEqualToString:yes])
            {
                [cell.switch_setting setOn: YES animated: YES];
                
            }
            else
            {
                [cell.switch_setting setOn: NO animated: YES];
            }
        }
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: SPECIAL_NEEDS])
    {
        cell.label_settingTitle.text = commonData.tableSpecialNeeds[indexPath.section];
        
        if (sharedProfile.tableSpecialNeeds == nil)
        {
            sharedProfile.tableSpecialNeeds = [NSMutableArray arrayWithObjects:no,no,no,no, nil];
            
           // sharedProfile.tableSpecialNeeds_StringValues_Selected = [[NSMutableArray alloc]init];
        }
        else
        {
            
            if ([sharedProfile.tableSpecialNeeds[indexPath.section] isEqualToString:@"Yes"])
            {
                [cell.switch_setting setOn: YES animated: YES];
                
            }
            else
            {
                [cell.switch_setting setOn: NO animated: YES];
            }
        }
        
    }
    //tableFilters
    else if ([self.txtfieldEnteredTitle isEqualToString: FILTERS])
    {
        cell.label_settingTitle.text = commonData.tableFilters[indexPath.section];
        
        if (sharedProfile.tableFilters == nil)
        {
            sharedProfile.tableFilters = [NSMutableArray arrayWithObjects:yes,yes,yes,yes,yes,yes,yes, nil];
        }
        else
        {
            
            if ([sharedProfile.tableFilters[indexPath.section] isEqualToString:@"Yes"])
            {
                [cell.switch_setting setOn: YES animated: YES];
                
            }
            else
            {
                [cell.switch_setting setOn: NO animated: YES];
            }
        }
        

    }


    [cell.switch_setting addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}


-(void) switchChanged:(id)sender
{
    UISwitch* switcher = (UISwitch*)sender;
    
    //See: http://stackoverflow.com/questions/3462484/if-i-add-a-uiswitch-control-to-each-of-my-table-view-cells-how-can-i-tell-which
    /*Just for those who still found a problem with the superview, sometimes you need to point to the superview of the superview of the control since the control might be in the UITableViewCellContentView. The superview to the UITableViewCellContentView will be the required UITableViewCell
    */
    //=>> UITableViewCell.ContentView.StackView.Switcher => Switche belongs to a Stack View, which belongs to ContentView where ContentView belongs to UITableViewCell!!!!
    UITableViewCell *parentCell = (UITableViewCell *)switcher.superview.superview.superview;
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:parentCell];
    
   //?  [self.tableView reloadData];
    
    NSLog(@"indexPath.row=%lu",indexPath.row);
    NSLog(@"indexPath.section=%lu",indexPath.section);
    
    current_section = (int)indexPath.section;
    
    NSString *strSwitcherValue = [[NSString alloc] initWithFormat:@"%@",switcher.isOn?@"Yes":@"No"];
  
    if ([self.txtfieldEnteredTitle isEqualToString: TRAVEL_MODES])
    {
        [sharedProfile.tableTravelModesValues replaceObjectAtIndex:current_section withObject:strSwitcherValue];
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: OPTIMISE_TRAVEL_SOLUTIONS])
    {
        [sharedProfile.tableOptimiseTravelSolutions replaceObjectAtIndex:current_section withObject:strSwitcherValue];
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: SPECIAL_NEEDS])
    {
        [sharedProfile.tableSpecialNeeds replaceObjectAtIndex:current_section withObject:strSwitcherValue];
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: FILTERS])
    {
        [sharedProfile.tableFilters replaceObjectAtIndex:current_section withObject:strSwitcherValue];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int total_data_cnt=0;
    
    if ([self.txtfieldEnteredTitle isEqualToString: TRAVEL_MODES])
    {
        total_data_cnt = (int)commonData.tableTravelModes.count;
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: OPTIMISE_TRAVEL_SOLUTIONS])
    {
        total_data_cnt = (int)commonData.tableOptimiseTravelSolutions.count;
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: SPECIAL_NEEDS])
    {
        total_data_cnt = (int)commonData.tableSpecialNeeds.count;
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: FILTERS])
    {
        total_data_cnt = (int)commonData.tableFilters.count;
    }
    
    return total_data_cnt;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"Row selected = %lu",(unsigned long)indexPath.row);
    //current_section = (int)indexPath.section;
    //NSLog(@"Section selected = %lu",(unsigned long) current_section);
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    MultipleSelectionTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UISwitch* switcher = (UISwitch *)cell.switch_setting;
 
    [switcher setOn:!switcher.on animated:YES];
    [self switchChanged:switcher];
}

/*
 Detect the press of The back button of NavigationItem:
 */
-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        // Navigation BACK button was pressed.
        //[self.navigationController  popViewControllerAnimated:NO]; => NOt use this because removes the top and move to the top the current active
        
        if ([self.comingFrom isEqualToString:@"FindTrips"])
        {
             NSArray *viewControllers = [self.navigationController viewControllers];
            //Go back to (previous View Controller) the RouteViewController
            RouteViewController *routeViewController = [viewControllers objectAtIndex:1];
            
            NSArray *transportTypes = @[@"use_bus",@"use_metro",@"use_train"];
            NSArray *optimisationTypes = @[@"transfer_mode=CHEAPEST_ROUTE",@"transfer_mode=FASTEST_ROUTE"];
            
            NSString *strParameters=@"";
            
            for (int i=0;i<transportTypes.count;i++)
            {
                strParameters=[strParameters stringByAppendingString:@"&"];
                strParameters=[strParameters stringByAppendingString:transportTypes[i]];
                
                if ([sharedProfile.tableFilters[i] isEqualToString:@"Yes"])
                {
                    strParameters=[strParameters stringByAppendingString:@"=true"];
                }
                else
                {
                    strParameters=[strParameters stringByAppendingString:@"=false"];
                }
                //use_bus=false&use_metro=true&use_train=true&
            }
            
            for (int i=0;i<optimisationTypes.count;i++)
            {
                strParameters=[strParameters stringByAppendingString:@"&"];
                strParameters=[strParameters stringByAppendingString:optimisationTypes[i]];
                
                
                if ([sharedProfile.tableFilters[5+i] isEqualToString:@"Yes"])
                {
                    strParameters=[strParameters stringByAppendingString:@"=true"];
                }
                else
                {
                    strParameters=[strParameters stringByAppendingString:@"=false"];
                }
                
            }
            
            NSLog(@"strParameters=%@",strParameters);
            
            routeViewController.parametersForRequest = strParameters;
            // [self.navigationController popViewControllerAnimated:YES];
            
            [self.navigationController popToViewController:routeViewController animated:YES];
            
        }
        else
        {
            //Prepare text to be displayed in the textField
            NSArray *viewControllers = [self.navigationController viewControllers];
            
            //Case 1
            if (viewControllers.count == 1)
            {
                ProfileDataViewControllerTabItem *profileVCTabItem = [viewControllers objectAtIndex:0];
                
                [self displayMultipleSelectionsInTextField_ProfileDataViewControllerTabItem:profileVCTabItem];
            }
            else  if (viewControllers.count == 3) //Case 2
            {
                ProfileDataViewControllerRegister *profileVCTabItem = [viewControllers objectAtIndex:2];
                
                profileVCTabItem = (ProfileDataViewControllerRegister *)[viewControllers objectAtIndex:2];
                
                [self displayMultipleSelectionsInTextField_ProfileViewControllerRegister:profileVCTabItem];
                
            }
            else  if (viewControllers.count == 4) //Case 3
            {
                ProfileDataViewControllerRegister *profileVCTabItem = [viewControllers objectAtIndex:3];
                profileVCTabItem = (ProfileDataViewControllerRegister *)[viewControllers objectAtIndex:3];
                
                [self displayMultipleSelectionsInTextField_ProfileViewControllerRegister:profileVCTabItem];
            }
            
            //* [self.navigationController popToViewController:profileVCTabItem animated:YES];
            //  [self.navigationController showViewController:profileVCTabItem sender:self];
        }
    }
    
   [super viewWillDisappear:animated];
}

/*
 Display multiple selections in textfield at ProfileViewControllerRegister
 */
-(void)displayMultipleSelectionsInTextField_ProfileViewControllerRegister:(ProfileDataViewControllerRegister *)profileVCTabItem
{
    NSString *textToDisplay = @"";
    
    if ([self.txtfieldEnteredTitle isEqualToString: TRAVEL_MODES])
    {
        textToDisplay = [self displaySwitchSelectionsInTextField:commonData.tableTravelModes withValues:sharedProfile.tableTravelModesValues];
        
        [profileVCTabItem.txtfield_travel_modes setFont:[UIFont systemFontOfSize:12]];
        profileVCTabItem.txtfield_travel_modes.text = textToDisplay;
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: OPTIMISE_TRAVEL_SOLUTIONS])
    {
        textToDisplay = [self displaySwitchSelectionsInTextField:commonData.tableOptimiseTravelSolutions withValues:sharedProfile.tableOptimiseTravelSolutions];
        
        [profileVCTabItem.txtfield_optimise_travel setFont:[UIFont systemFontOfSize:12]];
        profileVCTabItem.txtfield_optimise_travel.text = textToDisplay;
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: SPECIAL_NEEDS])
    {
        textToDisplay = [self displaySwitchSelectionsInTextField:commonData.tableSpecialNeeds withValues:sharedProfile.tableSpecialNeeds];
        
        [profileVCTabItem.txtfield_special_needs setFont:[UIFont systemFontOfSize:12]];
        profileVCTabItem.txtfield_special_needs.text = textToDisplay;
        
    }
}

/*
Display multiple selections in textfield at ProfileDataViewControllerTabItem
*/
-(void)displayMultipleSelectionsInTextField_ProfileDataViewControllerTabItem:(ProfileDataViewControllerTabItem *)profileVCTabItem
{
    NSString *textToDisplay = @"";
    
    if ([self.txtfieldEnteredTitle isEqualToString: TRAVEL_MODES])
    {
        textToDisplay = [self displaySwitchSelectionsInTextField:commonData.tableTravelModes withValues:sharedProfile.tableTravelModesValues];
        
        [profileVCTabItem.txtfield_travel_modes setFont:[UIFont systemFontOfSize:12]];
        profileVCTabItem.txtfield_travel_modes.text = textToDisplay;
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: OPTIMISE_TRAVEL_SOLUTIONS])
    {
        textToDisplay = [self displaySwitchSelectionsInTextField:commonData.tableOptimiseTravelSolutions withValues:sharedProfile.tableOptimiseTravelSolutions];
        
        [profileVCTabItem.txtfield_optimise_travel setFont:[UIFont systemFontOfSize:12]];
        profileVCTabItem.txtfield_optimise_travel.text = textToDisplay;
    }
    else if ([self.txtfieldEnteredTitle isEqualToString: SPECIAL_NEEDS])
    {
        textToDisplay = [self displaySwitchSelectionsInTextField:commonData.tableSpecialNeeds withValues:sharedProfile.tableSpecialNeeds];
        
        [profileVCTabItem.txtfield_special_needs setFont:[UIFont systemFontOfSize:12]];
        profileVCTabItem.txtfield_special_needs.text = textToDisplay;
        
    }
}

/*
 See which Switch Selection are set to "Yes" and create the text to
 be dsipalyed int the textfield. At the end, remove the last comma.
 */
-(NSString *) displaySwitchSelectionsInTextField: (NSArray *) tableData withValues: (NSMutableArray *) tableValues
{
    NSString *textToDisplay=@"";
    
    //for (int i=0;i<sharedProfile.tableTravelModesValues.count;i++)
    for (int i=0;i<tableValues.count;i++)
    {
        //if ([sharedProfile.tableTravelModesValues[i] isEqualToString:@"Yes"])
        if ([tableValues[i] isEqualToString:@"Yes"])
        {
           /* if ([self.txtfieldEnteredTitle isEqualToString: TRAVEL_MODES])
            {
                [sharedProfile.tableTravelModesValues_StringValues_Selected addObject:tableValues[i]];
            }
            else if ([self.txtfieldEnteredTitle isEqualToString: OPTIMISE_TRAVEL_SOLUTIONS])
            {
                [sharedProfile.tableOptimiseTravelSolutions_StringValues_Selected addObject:tableValues[i]];
            }
            else if ([self.txtfieldEnteredTitle isEqualToString: SPECIAL_NEEDS])
            {
                [sharedProfile.tableSpecialNeeds_StringValues_Selected addObject:tableValues[i]];
            }*/
            //textToDisplay = [textToDisplay stringByAppendingString:tableTravelModes[i]];
            textToDisplay = [textToDisplay stringByAppendingString:tableData[i]];
            textToDisplay = [textToDisplay stringByAppendingString:@","];
        }
    }
    
    //Remove last comma
    if (textToDisplay.length !=0)
    {
        textToDisplay = [textToDisplay substringToIndex:[textToDisplay length]-1];
    }
    else
    {
        NSString *none = NSLocalizedString(@"None", @"None");
        textToDisplay = none;
    }
    
    return textToDisplay;
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
