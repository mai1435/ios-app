//
//  TermsAndConditionsViewController.h
//  SocialCar
//
//  Created by Nikolaos Dimokas on 10/10/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsAndConditionsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *textView_en;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_en;


@property (strong, nonatomic) IBOutlet UITextView *textView_nl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_nl;


@property (strong, nonatomic) IBOutlet UITextView *textView_fr;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_fr;


@property (strong, nonatomic) IBOutlet UITextView *textView_it;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_it;


@property (strong, nonatomic) IBOutlet UITextView *textView_sl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_sl;

@end
