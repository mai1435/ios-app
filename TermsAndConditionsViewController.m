//
//  TermsAndConditionsViewController.m
//  SocialCar
//
//  Created by Nikolaos Dimokas on 10/10/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import "TermsAndConditionsViewController.h"

@interface TermsAndConditionsViewController ()

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    if ( [countryCode isEqualToString:@"NL"] )
    {
        self.constraint_height_sl.constant = 0.0f;
        self.constraint_height_fr.constant = 0.0f;
        self.constraint_height_en.constant = 0.0f;
        self.constraint_height_it.constant = 0.0f;
        
        self.constraint_height_nl.constant = 554.0f;
    }
    else if ( [countryCode isEqualToString:@"IT"] )
    {
        self.constraint_height_nl.constant = 0.0f;
        self.constraint_height_sl.constant = 0.0f;
        self.constraint_height_fr.constant = 0.0f;
        self.constraint_height_en.constant = 0.0f;
        
        self.constraint_height_it.constant = 554.0f;
        
    }
    else if ( [countryCode isEqualToString:@"FR"] )
    {
        self.constraint_height_nl.constant = 0.0f;
        self.constraint_height_sl.constant = 0.0f;
        self.constraint_height_it.constant = 0.0f;
        self.constraint_height_en.constant = 0.0f;
        
        self.constraint_height_fr.constant = 554.0f;
        
        
    }
    else if ( [countryCode isEqualToString:@"SI"] )
    {
        self.constraint_height_nl.constant = 0.0f;
        self.constraint_height_fr.constant = 0.0f;
        self.constraint_height_it.constant = 0.0f;
        self.constraint_height_en.constant = 0.0f;
        
        self.constraint_height_sl.constant = 554.0f;
    }
    else
    {
        self.constraint_height_nl.constant = 0.0f;
        self.constraint_height_fr.constant = 0.0f;
        self.constraint_height_it.constant = 0.0f;
        self.constraint_height_sl.constant = 0.0f;
        
        self.constraint_height_en.constant = 554.0f;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
