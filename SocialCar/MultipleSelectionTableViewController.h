//
//  MultipleSelectionTableViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 28/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipleSelectionTableViewCell.h"
//#import "SharedProfileData.h"
#import "CommonData.h"
#import "RouteViewController.h"

@interface MultipleSelectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    
    int current_section;
    
  //  SharedProfileData *sharedProfile;
    
    CommonData *commonData;
   
    
    
}

@property (strong,nonatomic) NSString *txtfieldEnteredTitle;
@property (strong,nonatomic) NSString *comingFrom;
//@property BOOL clearSharedObject;

/*
 See which Switch Selection are set to "Yes" and create the text to
 be dispalyed int the textfield. At the end, remove the last comma.
 */
-(NSString *) displaySwitchSelectionsInTextField: (NSArray *) tableData withValues: (NSMutableArray *) tableValues;

//-(BOOL) clearSharedObject:(BOOL)clearSharedObject;
//Clear sharedObject
//-(SharedProfileData *) initialiseSharedProfileObject : (BOOL *)clearSharedObject;


@end
