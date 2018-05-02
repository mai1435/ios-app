//
//  PassengerDetailsForRidesViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 26/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import "PassengerDetailsForRidesViewController.h"

@interface PassengerDetailsForRidesViewController ()

@end

@implementation PassengerDetailsForRidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    
    myTools = [[MyTools alloc]init];
    
    rides = [[NSMutableArray alloc]init];
    rides = [sharedRoutesAsDriver rides];
    
    Ride *ride = rides[sharedRoutesAsDriver.ride_selected];
    
    
    NSMutableArray *lifts = [[NSMutableArray alloc]init];
    lifts = ride.lifts;
    
    Lift *lift = lifts[ride.lift_selected]; //??create ride lift selected
    
    if (lift.passenger_picture)
    {
        self.image_picture.image = lift.passenger_picture;
        CGSize size = CGSizeMake(80, 80);
        self.image_picture.image= [self imageWithImage:self.image_picture.image convertToSize:size];
        
        [self setStyleForImageCirle:self.image_picture];
    }

    self.label_passenger_name.text = lift.passenger_name;
    
    self.label_feedback_rating.text = lift.passenger_rating;
    
    //Create "X (cnt feedback)"
    self.label_feedback_rating.text  = [ self.label_feedback_rating.text  stringByAppendingString:@" ("];
    
    NSString *feedbackCounter = [NSString stringWithFormat:@"%lu",(unsigned long)sharedRoutesAsPassenger.feedbackArray.count];
    
    self.label_feedback_rating.text  = [ self.label_feedback_rating.text  stringByAppendingString:feedbackCounter];
    
    if (sharedRoutesAsPassenger.feedbackArray.count >1)
    {
        self.label_feedback_rating.text  = [ self.label_feedback_rating.text  stringByAppendingString:@" feedbacks)"];
    }
    else
    {
        self.label_feedback_rating.text  = [ self.label_feedback_rating.text  stringByAppendingString:@" feedback)"];
    }
    //End of creating "X (cnt feedback)"

    
}

#pragma mark - Styling picture as as circle
-(void) setStyleForImageCirle: (UIImageView *) imageView
{
    self.image_picture.backgroundColor = [UIColor clearColor];
    
    self.image_picture.layer.cornerRadius = self.image_picture.frame.size.width /2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    self.image_picture.layer.masksToBounds =  YES;
    
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


#pragma mark - UITAbleViewDataSource
//Asks the data source for a cell to insert in a particular location of the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellFeedback";
    
    DriverFeedback *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DriverFeedbackCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.image_driver setHidden:NO];
    
    
    Feedback *feedback = [[Feedback alloc] init];
    
    
    feedback = [sharedRoutesAsPassenger.feedbackArray objectAtIndex:(int) indexPath.row];
    
    cell.label_user_name.text = feedback.reviewer;
    
    // Convert string to date object
    /*  NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"dd/MM/YYYY"];
     //Convert Stiring into timestamp and format it to the "dd/MM/YYYY"
     NSTimeInterval _interval=[feedback.date longLongValue];
     NSDate *dateStr	 = [NSDate dateWithTimeIntervalSince1970:_interval];
     
     NSString *stringDate = [formatter stringFromDate:dateStr];
     */
    
    NSString *stringDate = [myTools convertTimeStampToString:feedback.date];
    
    cell.label_datetime.text = stringDate;
    //////////////////\\\\\\\\\\\\\\\\\\\
    
    cell.label_comments.text = feedback.review;
    [self displayStars:cell withRating:[feedback.rating intValue]];
    
    return cell;
}


-(void) displayStars: (DriverFeedback *) cell withRating:(int) rating
{
    UIImage *imageStarBlack = [UIImage imageNamed:@"star_black"];
    UIImage *imageStarGrey = [UIImage imageNamed:@"star_grey"];
    
    
    if (rating == 1)
    {
        cell.image_star1.image = imageStarBlack;
        
        cell.image_star2.image = imageStarGrey;
        cell.image_star3.image = imageStarGrey;
        cell.image_star4.image = imageStarGrey;
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 2)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        
        cell.image_star3.image = imageStarGrey;
        cell.image_star4.image = imageStarGrey;
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 3)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        cell.image_star3.image = imageStarBlack;
        
        cell.image_star4.image = imageStarGrey;
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 4)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        cell.image_star3.image = imageStarBlack;
        cell.image_star4.image = imageStarBlack;
        
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 5)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        cell.image_star3.image = imageStarBlack;
        cell.image_star4.image = imageStarBlack;
        cell.image_star5.image = imageStarBlack;
    }
    
}


//return the number of rows in a given section of a table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return sharedRoutesAsPassenger.feedbackArray.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//default value
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
