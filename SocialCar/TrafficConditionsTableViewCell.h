//
//  TrafficConditionsTableViewCell.h
//  SocialCar
//
//  Created by Vittorio Tauro on 27/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrafficConditionsTableViewCell : UITableViewCell{
    
}

@property (nonatomic, weak) IBOutlet UIView* backgroundUIView;
@property (weak, nonatomic) IBOutlet UILabel *reportDetail;
@property (weak, nonatomic) IBOutlet UILabel *reportType;
@property (weak, nonatomic) IBOutlet UILabel *reportPriority;
@property (weak, nonatomic) IBOutlet UILabel *reportDate;
@property (weak, nonatomic) IBOutlet UILabel *reportHour;

@end
