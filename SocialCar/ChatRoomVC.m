//
//  ChatRoomVC.m
//  SocialCar
//
//  Created by Vittorio Tauro on 10/04/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "ChatRoomVC.h"

@interface ChatRoomVC ()
@property (nonatomic) NSTimer* updateTimer;
@property (nonatomic) NSTimer* updateFakeTimer;

@end
int count = 0;

@implementation ChatRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor lightGrayColor];
//	self.topContentAdditionalInset =
//	self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
	
	sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
	sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
	sharedProfile = [SharedProfileData sharedObject];
	sharedDriverProfile = [SharedDriverProfileData sharedObject];
	commonData = [[CommonData alloc]init];
	[commonData initWithValues];
	
	self.title = _passedCLI.receiverNameSurname;
	
	self.senderID = [sharedProfile.userID integerValue];
	self.senderDisplayName = sharedProfile.user_name;
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	self.inputToolbar.audioRecordingEnabled = false;
	self.inputToolbar.sendButtonOnRight = true;
	self.inputToolbar.contentView.leftBarButtonItem = nil;
	self.inputToolbar.contentView.textView.placeHolder = @"Write a message";
	self.inputToolbar.preferredDefaultHeight = 1.0f;
	
	[self startTimerFetchingMessage];
	[self startTimerFakeMessage];
	[self updateMessage];
	//	QBChatMessage* msg = [QBChatMessage message];
//	msg.text = @"QuickBlox - Communication & cloud backend platform which brings superpowers to your mobile apps. QuickBlox is a suite of communication features & data services (APIs, SDKs, code samples, admin panel, tutorials) ";
//	msg.senderID = self.senderID;
//	msg.dateSent = [NSDate date];
//	[self.chatDataSource addMessage:msg];
//
//	QBChatMessage *msg2 = [QBChatMessage message];
//	msg2.text = @"which help digital agencies, mobile developers and publishers to add great functionality to smartphone applications. Please read full iOS SDK documentation on the";
//	msg2.senderID = 124543;
//	msg2.dateSent = [NSDate date];
//
//	[self.chatDataSource addMessage:msg2];
	// Do any additional setup after loading the view.
}

- (void)startTimerFetchingMessage
{
	NSTimeInterval time = 5.0;
	self.updateTimer =
	[NSTimer scheduledTimerWithTimeInterval:time
									 target:self
								   selector:@selector(updateMessage)
								   userInfo:nil
									repeats:YES];
}

- (void)startTimerFakeMessage
{
	NSTimeInterval time = 15.0;
	self.updateFakeTimer =
	[NSTimer scheduledTimerWithTimeInterval:time
									 target:self
								   selector:@selector(sendFakeMessage)
								   userInfo:nil
									repeats:YES];
}

-(void)sendFakeMessage
{
	if (count == 0) {
		[self sendFakeMessage:@"Hi!" toReceiverID:sharedProfile.userID fromSenderID:_passedCLI.receiverId andLiftID:_passedCLI.refLift._id];
		count ++;
	}else if (count == 1){
		[self sendFakeMessage:@"Are you late?" toReceiverID:sharedProfile.userID fromSenderID:_passedCLI.receiverId andLiftID:_passedCLI.refLift._id];
		count ++;
	}else if (count == 2){
		[self sendFakeMessage:@"Ok, I'm near the pick up point too" toReceiverID:sharedProfile.userID fromSenderID:_passedCLI.receiverId andLiftID:_passedCLI.refLift._id];
		count ++;
	}
}

-(void)updateMessage
{
	//1. Create URL
	NSString *ulrStr = commonData.BASEURL_CHAT;
	ulrStr = [ulrStr stringByAppendingString:@"?lift_id="];
	ulrStr = [ulrStr stringByAppendingString:_passedCLI.refLift._id];
	
	NSURL *urlWithString = [NSURL URLWithString:ulrStr];
	NSLog(@"urlWitString=%@",urlWithString);
	
	
	//2. Create and send Request
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
	//3. Set HTTP Headers and HTTP Method
	[urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
	[urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	//4. Set HTTP Method
	[urlRequest setHTTPMethod:HTTP_METHOD_GET];
	
	//5. Send Request to Server
	//?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
	//?        [dataTask resume];
	//create the task
	NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
								  {
									  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
									  
									  NSLog(@"ParseJson[retrievedMessages] =%@", json);
									  for (NSDictionary* dict in RetrieveObj(json, @"messages")) {
										  if ([RetrieveObj(dict, @"sender_id") isEqualToString:sharedProfile.userID]) {
											  QBChatMessage *message = [QBChatMessage message];
											  message.ID = RetrieveObj(dict, @"_id");
											  message.text = RetrieveObj(dict, @"body");
											  message.senderID = [sharedProfile.userID integerValue];
											  message.dateSent = [NSDate dateWithTimeIntervalSince1970:[RetrieveObj(dict, @"timestamp") doubleValue]];
											  dispatch_async(dispatch_get_main_queue(), ^{
												  if (![self.chatDataSource messageExists:message]) {
													  [self.chatDataSource addMessage:message];
												  }
											  });
										  }else{
											  QBChatMessage *message = [QBChatMessage message];
											  message.ID = RetrieveObj(dict, @"_id");
											  message.text = RetrieveObj(dict, @"body");
											  message.senderID = [RetrieveObj(dict, @"sender_id") integerValue];
											  message.dateSent = [NSDate dateWithTimeIntervalSince1970:[RetrieveObj(dict, @"timestamp") doubleValue]];
											  dispatch_async(dispatch_get_main_queue(), ^{
												  if (![self.chatDataSource messageExists:message]) {
													  [self.chatDataSource addMessage:message];
												  }
											  });
										  }
									  }
								  }];
	[task resume];
}

-(NSUInteger)inputToolBarStartPos {
	return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didPressSendButton:(UIButton *)button
		   withMessageText:(NSString *)text
				  senderId:(NSUInteger)senderId
		 senderDisplayName:(NSString *)senderDisplayName
					  date:(NSDate *)date {
	
	[self.updateTimer invalidate];
	self.updateTimer = nil;
	
	[self sendFakeMessage:text toReceiverID:_passedCLI.receiverId fromSenderID:sharedProfile.userID andLiftID:_passedCLI.refLift._id];
}

#pragma mark - Send Chat
-(void) sendFakeMessage:(NSString *)body toReceiverID:(NSString*)receiver_id fromSenderID:(NSString*)sender_id andLiftID:(NSString*)lift_id
{
	NSDictionary *dataToSend = @{
								 @"sender_id":sender_id,
								 @"receiver_id":receiver_id,
								 @"lift_id":lift_id,
								 @"body":body
								 };
	//1. Create URL
	NSString *ulrStr = commonData.BASEURL_CHAT;
	
	NSURL *urlWithString = [NSURL URLWithString:ulrStr];
	NSLog(@"urlWitString=%@",urlWithString);
	
	//2. Create and send Request
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
	//3. Set HTTP Headers and HTTP Method
	[urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
	[urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	MyTools* myTools = [[MyTools alloc]init];
	NSString *strRes = [myTools dictionaryToJSONString:dataToSend];
	
	[urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
	//4. Set HTTP Method
	[urlRequest setHTTPMethod:HTTP_METHOD_POST];
	
	//5. Send Request to Server
	//?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
	//?        [dataTask resume];
	//create the task
	NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
								  {
									  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
									  dispatch_async(dispatch_get_main_queue(), ^{
										  if ([RetrieveObj(json, @"sender_id") isEqualToString:sharedProfile.userID]) {
											  QBChatMessage *message = [QBChatMessage message];
											  message.ID = RetrieveObj(json, @"_id");
											  message.text = RetrieveObj(json, @"body");
											  message.senderID = [sharedProfile.userID integerValue];
											  message.dateSent = [NSDate dateWithTimeIntervalSince1970:[RetrieveObj(json, @"timestamp") doubleValue]];
											  if (![self.chatDataSource messageExists:message]) {
												  [self.chatDataSource addMessage:message];
											  }
										  }else{
											  QBChatMessage *message = [QBChatMessage message];
											  message.ID = RetrieveObj(json, @"_id");
											  message.text = RetrieveObj(json, @"body");
											  message.senderID = [RetrieveObj(json, @"sender_id") integerValue];
											  message.dateSent = [NSDate dateWithTimeIntervalSince1970:[RetrieveObj(json, @"timestamp") doubleValue]];
											  if (![self.chatDataSource messageExists:message]) {
												  [self.chatDataSource addMessage:message];
											  }
										  }
										  [self startTimerFetchingMessage];
										  [self.inputToolbar.contentView.textView setText:@""];
									  });
									  //[self finishSendingMessageAnimated:YES];
								  }];
	[task resume];
}

- (Class)viewClassForItem:(QBChatMessage *)item {
	// Cell class for message
	if (item.senderID != self.senderID) {
		if (item.senderID == 0) {
			return [QMChatNotificationCell class];
		}
		return [QMChatIncomingCell class];
	}
	else {
		
		return [QMChatOutgoingCell class];
	}
	
	return nil;
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[self.updateTimer invalidate];
	self.updateTimer = nil;
	[self.updateFakeTimer invalidate];
	self.updateFakeTimer = nil;
}

- (CGSize)collectionView:(QMChatCollectionView *)collectionView dynamicSizeAtIndexPath:(NSIndexPath *)indexPath maxWidth:(CGFloat)maxWidth {
	
	QBChatMessage *item = [self.chatDataSource messageForIndexPath:indexPath];
	Class viewClass = [self viewClassForItem:item];
	CGSize size;
	
	if (viewClass == [QMChatAttachmentIncomingCell class] || viewClass == [QMChatAttachmentOutgoingCell class]) {
		size = CGSizeMake(MIN(200, maxWidth), 200);
	} else {
		NSAttributedString *attributedString = [self attributedStringForItem:item];
		
		size = [TTTAttributedLabel sizeThatFitsAttributedString:attributedString
												withConstraints:CGSizeMake(maxWidth, MAXFLOAT)
										 limitedToNumberOfLines:0];
	}
	
	return size;
}

- (CGFloat)collectionView:(QMChatCollectionView *)collectionView minWidthAtIndexPath:(NSIndexPath *)indexPath {
	
	QBChatMessage *item = [self.chatDataSource messageForIndexPath:indexPath];
	
	CGSize size;
	
	if (item != nil) {
		
		NSAttributedString *attributedString =
		[item senderID] == self.senderID ?  [self bottomLabelAttributedStringForItem:item] : [self topLabelAttributedStringForItem:item];
		
		size = [TTTAttributedLabel sizeThatFitsAttributedString:attributedString
												withConstraints:CGSizeMake(1000, 1000)
										 limitedToNumberOfLines:1];
	}
	
	return size.width;
}

- (void)collectionView:(QMChatCollectionView *)collectionView configureCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
	
	if ([cell conformsToProtocol:@protocol(QMChatAttachmentCell)]) {
		QBChatMessage* message = [self.chatDataSource messageForIndexPath:indexPath];
		
		if (message.attachments != nil) {
			QBChatAttachment* attachment = message.attachments.firstObject;
			NSData *imageData = [NSData dataWithContentsOfFile:attachment.url];
			[(UICollectionViewCell<QMChatAttachmentCell> *)cell setAttachmentImage:[UIImage imageWithData:imageData]];
			
			[cell updateConstraints];
		}
	}
	
	[super collectionView:collectionView configureCell:cell forIndexPath:indexPath];
}

- (QMChatCellLayoutModel)collectionView:(QMChatCollectionView *)collectionView layoutModelAtIndexPath:(NSIndexPath *)indexPath {
	
	QMChatCellLayoutModel layoutModel = [super collectionView:collectionView layoutModelAtIndexPath:indexPath];
	QBChatMessage *item = [self.chatDataSource messageForIndexPath:indexPath];
	
	layoutModel.avatarSize = CGSizeMake(0, 0);
	
	if (item!= nil) {
		
		NSAttributedString *topLabelString = [self topLabelAttributedStringForItem:item];
		CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:topLabelString
													   withConstraints:CGSizeMake(CGRectGetWidth(self.collectionView.frame), CGFLOAT_MAX)
												limitedToNumberOfLines:1];
		layoutModel.topLabelHeight = size.height;
	}
	
	return layoutModel;
}

- (NSAttributedString *)attributedStringForItem:(QBChatMessage *)messageItem {
	
	UIColor *textColor = [messageItem senderID] == self.senderID ? [UIColor whiteColor] : [UIColor colorWithWhite:0.290 alpha:1.000];
	UIFont *font = [UIFont fontWithName:@"Helvetica" size:15];
	
	NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor,
								 NSFontAttributeName : font};
	
	NSMutableAttributedString *attrStr;
	
	if ([messageItem.text length] > 0) {
		
		attrStr = [[NSMutableAttributedString alloc] initWithString:messageItem.text attributes:attributes];
	}
	
	return attrStr;
}

- (NSAttributedString *)topLabelAttributedStringForItem:(QBChatMessage *)messageItem {
	
	UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
	
	if ([messageItem senderID] == self.senderID) {
		return nil;
	}
	
	NSDictionary *attributes = @{ NSForegroundColorAttributeName:[UIColor colorWithRed:0.184 green:0.467 blue:0.733 alpha:1.000], NSFontAttributeName:font};
	
	NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_passedCLI.receiverNameSurname attributes:attributes];
	
	return attrStr;
}

- (NSAttributedString *)bottomLabelAttributedStringForItem:(QBChatMessage *)messageItem {
	
	UIColor *textColor = [messageItem senderID] == self.senderID ? [UIColor colorWithWhite:1.000 alpha:0.510] : [UIColor colorWithWhite:0.000 alpha:0.490];
	UIFont *font = [UIFont fontWithName:@"Helvetica" size:12];
	
	NSDictionary *attributes = @{ NSForegroundColorAttributeName:textColor, NSFontAttributeName:font};
	NSMutableAttributedString *attrStr =
	[[NSMutableAttributedString alloc] initWithString:[self timeStampWithDate:messageItem.dateSent]
										   attributes:attributes];
	
	return attrStr;
}

- (NSString *)timeStampWithDate:(NSDate *)date {
	
	static NSDateFormatter *dateFormatter = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateFormat = @"HH:mm";
	});
	
	NSString *timeStamp = [dateFormatter stringFromDate:date];
	
	return timeStamp;
}

- (UIImage *)resizedImageFromImage:(UIImage *)image
{
	CGFloat largestSide = image.size.width > image.size.height ? image.size.width : image.size.height;
	CGFloat scaleCoefficient = largestSide / 560.0f;
	CGSize newSize = CGSizeMake(image.size.width / scaleCoefficient, image.size.height / scaleCoefficient);
	
	UIGraphicsBeginImageContext(newSize);
	
	[image drawInRect:(CGRect){0, 0, newSize.width, newSize.height}];
	UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return resizedImage;
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
