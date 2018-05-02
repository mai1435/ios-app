//  Copyright © 2018 foofastudios. All rights reserved.

#import "ChatListItem.h"


@implementation ChatListItem


- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        self.receiverId = nil;
        self.receiverAvatar = nil;
        self.receiverNameSurname = nil;
		self.refLift = nil;
		self.receiverType = -1;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self != nil)
    {
        if (dictionary)
        {
            self.receiverId =    			RetrieveObj(dictionary, @"receiverId");
            self.receiverAvatar =     		RetrieveObj(dictionary, @"receiverAvatar");
            self.receiverNameSurname =  	RetrieveObj(dictionary, @"receiverNameSurname");
			self.refLift =  				RetrieveObj(dictionary, @"refLift");
			self.receiverType = 			(int)RetrieveObj(dictionary, @"receiverType");;
        }
    }
    return self;
}

- (NSDictionary *)asDictionary
{
    return @{
             @"receiverId" :     			ObjectOrNull(self.receiverId),
             @"receiverAvatar" :      		ObjectOrNull(self.receiverAvatar),
             @"receiverNameSurname" :   	ObjectOrNull(self.receiverNameSurname),
			 @"refLift" :   				ObjectOrNull(self.refLift),
			 @"receiverType" :   			ObjectOrNull(@(self.receiverType))
             };
}


@end
