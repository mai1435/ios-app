//
//  MultipleSelectionTableViewCell.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 28/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDataViewControllerTabItem.h"
#import "ProfileDataViewControllerRegister.h"

@interface MultipleSelectionTableViewCell : UITableViewCell
{
    BOOL switch_state;
}

@property (strong, nonatomic) IBOutlet UILabel *label_settingTitle;

@property (strong, nonatomic) IBOutlet UISwitch *switch_setting;


@end
