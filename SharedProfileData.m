//
//  SharedProfileData.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 14/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "SharedProfileData.h"

@interface SharedProfileData ()

@end

@implementation SharedProfileData


-(id) initWithAllData:(NSString *) uname andEmail:(NSString *)uemail;
{
    self = [super init];
    if (self)
    {
        self.user_name = uname;
        self.email = uemail;
        self.platform = @"IOS";
    }
    
    return self;
}

+(instancetype) setSharedProfileData:(NSString *) uname andEmail:(NSString *)uemail
{
    SharedProfileData *profileData = [[SharedProfileData alloc]initWithAllData:uname andEmail:uemail];
    
    return profileData;
}

+(SharedProfileData *) sharedObject;
{
    static dispatch_once_t once;
    static SharedProfileData *sharedObject;
    
     
    dispatch_once(&once, ^{
        sharedObject = [[self alloc] init];
    });
    
    return sharedObject;
}

 //not use GCD
/*
 +(id)sharedManager 
 {
    static MyManager *sharedMyManager = nil;
    @synchronized(self) 
    {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
 
    return sharedMyManager;
 }
 
 */

@end
