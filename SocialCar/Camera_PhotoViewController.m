//
//  Camera_PhotoViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 12/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "Camera_PhotoViewController.h"

@interface Camera_PhotoViewController ()

@end

@implementation Camera_PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self isCameraAvailable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) isCameraAvailable
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
       
        NSString *error = NSLocalizedString(@"Error", @"Error");
        NSString *device_no_camera = NSLocalizedString(@"Device has no camera!", @"Device has no camera!");
        NSString *ok= NSLocalizedString(@"OK", @"OK");
        
        UIAlertController *alertOK   =   [UIAlertController
                                          alertControllerWithTitle:error
                                          message:device_no_camera
                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                              actionWithTitle:ok
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  [alertOK dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        
        [alertOK addAction:okAction];
        [self presentViewController:alertOK animated:NO completion:nil];
   
        
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                              message:@"Device has no camera"
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"OK"
//                                                    otherButtonTitles: nil];
//        
//        [myAlertView show];
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //info = A dictionary containing the original image and the edited image, if an image was picked
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage]; //Specifies an image edited by the user.
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
