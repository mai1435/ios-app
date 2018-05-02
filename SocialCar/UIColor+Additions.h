//
//  UIColor+Additions.h
//  shadappmessenger
//
//  Created by Luca Comanducci on 04/04/17.
//  Copyright © 2017 Vittorio Tauro. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Additions)


+ (UIColor *)colorWithHex:(NSString *)hex;
+ (UIColor *)colorWithHex:(NSString *)hex andAlpha:(CGFloat)alpha;

- (NSString *)hex;


@end
