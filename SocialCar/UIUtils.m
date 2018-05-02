//
//  UIUtils.m
//  SocialCar
//
//  Created by Vittorio Tauro on 01/02/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (void)startAppCustomization
{
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

//	[[UINavigationBar appearance] setTitleTextAttributes:navTextAttributes];
//	[[UINavigationBar appearance] setBarTintColor:EFFColor_NavigationBar];
//	[[UINavigationBar appearance] setTintColor:EFFColorCerulean];
//
//	[[UINavigationBar appearance] setBackIndicatorImage:backImage];
//	[[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
	[[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	[[UINavigationBar appearance] setShadowImage:[UIImage new]];
	
//	[[UIBarButtonItem appearance] setBackButtonBackgroundVerticalPositionAdjustment:-3 forBarMetrics:UIBarMetricsDefault];
//	[[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]]
//	 setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor clearColor],
//							   NSFontAttributeName : [UIFont systemFontOfSize:1.0f] }
//	 forState:UIControlStateNormal];
}

@end
