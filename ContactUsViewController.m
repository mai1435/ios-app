//
//  ContactUsViewController.m
//  SocialCar
//
//  Created by Nikolaos Dimokas on 10/10/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController () <SFSafariViewControllerDelegate>

@end

@implementation ContactUsViewController

//- (void)viewDidLoad {
  //  [super viewDidLoad];
-(void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Contact us", @"Contact us");
    NSString *contact_url;
    
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    if ( [countryCode isEqualToString:@"GB"] )
    {
		contact_url = @"*********";
    }
    else if ( [countryCode isEqualToString:@"NL"] )
    {
        contact_url = @"*********";
    }
    else if ( [countryCode isEqualToString:@"IT"] )
    {
        contact_url = @"*********";
    }
    else if ( [countryCode isEqualToString:@"FR"] )
    {
        contact_url = @"*********";
    }
    else if ( [countryCode isEqualToString:@"SI"] )
    {
        contact_url = @"*********";
    }
    else
    {
        contact_url = @"*********";
    }
    
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:contact_url] entersReaderIfAvailable:NO];
    
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];

    
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
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    NSLog(@"disappear....");
}
@end
