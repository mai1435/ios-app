//
//  RouteDetailsTableViewCell.m
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "RouteDetailsTableViewCell.h"

@implementation RouteDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.label_stops setHidden:YES];
    [self.label_circle_divider setHidden:YES];
    [self.label_duration setHidden:YES];
    [self.label_estimation_time setHidden:YES];
    
    CGSize size = CGSizeMake(48, 48);
    self.image_driver.image= [self imageWithImage:self.image_driver.image convertToSize:size];
    
    [self setStyleForImageCirle:self.image_driver];
    [self.image_driver setHidden:YES];
    
    [self.image_next_route_details setHidden:YES];
    
}

#pragma mark - Styling picture as as circle
-(void) setStyleForImageCirle: (UIImageView *) imageView
{
    self.image_driver.backgroundColor = [UIColor clearColor];
    
    self.image_driver.layer.cornerRadius = self.image_driver.frame.size.width /2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    self.image_driver.layer.masksToBounds =  YES;
    
    //self.image_photo.clipsToBounds = YES;
    
    //[self.image_photo.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_circle_dots"]] CGColor]];
    //self.image_photo.layer.borderWidth = 0.5f;
    
}

//Convert image to scale it into imageView
//http://stackoverflow.com/questions/4712329/how-to-resize-the-image-programatically-in-objective-c-in-iphone
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImage;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
