//  Copyright © 2018 Vittorio Tauro. All rights reserved.

#import "BaseCell.h"

@implementation BaseCell


+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight
{
    return 50.0f;
}


@end
