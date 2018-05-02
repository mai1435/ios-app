//  Copyright © 2018 foofastudios. All rights reserved.

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "MyTools.h"
#import "Lift.h"

@interface ChatListItem : BaseModel

@property (nonatomic, strong) NSString *receiverId;
@property (nonatomic, strong) UIImage *receiverAvatar;
@property (nonatomic, strong) NSString *receiverNameSurname;
@property (nonatomic, strong) Lift *refLift;
@property (nonatomic) int receiverType;


@end
