//
//  ChatListViewController.m
//  SocialCar
//
//  Created by Vittorio Tauro on 05/04/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatRoomVC.h"
#import "AppDelegate.h"

@interface ChatListViewController ()
@property NSMutableArray<ChatListItem*> *chatList;

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	

    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
	// [super viewWillAppear:animated];
	[super viewWillAppear:YES];
	//your code
	self.title = @"Chat List";
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
	
	sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
	sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
	sharedProfile = [SharedProfileData sharedObject];
	sharedDriverProfile = [SharedDriverProfileData sharedObject];
	commonData = [[CommonData alloc]init];
	[commonData initWithValues];
	liftAsDriver = [sharedRoutesAsDriver lifts];
	liftAsPassenger = [sharedRoutesAsPassenger lifts];
	
	self.tableView.delegate = self;
	[self.tableView registerNib:[UINib nibWithNibName:[ChatListCell nibName] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[ChatListCell reuseIdentifier]];;

	self.chatList = [[NSMutableArray alloc] init];
	[self populateChatItemList];
//	for (Lift *l in sharedRoutesAsDriver.lifts) {
//		[self retrieveMessages:l._id];
//	}
}

#pragma mark - Retrieve Chats
-(void) retrieveMessages:(NSString *)lift_id
{
	//1. Create URL
	NSString *ulrStr = commonData.BASEURL_CHAT;
	ulrStr = [ulrStr stringByAppendingString:@"?lift_id="];
	ulrStr = [ulrStr stringByAppendingString:lift_id];
	
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
											  ChatListItem *itemChat = [ChatListItem new];
											  [itemChat setReceiverId:RetrieveObj(dict, @"receiver_id")];
											  [itemChat setReceiverNameSurname:RetrieveObj(dict, @"receiver_name")];
											  if (![_chatList containsObject:itemChat]) {
												  [_chatList addObject:itemChat];
											  }
										  }else{
											  ChatListItem *itemChat = [ChatListItem new];
											  [itemChat setReceiverId:RetrieveObj(dict, @"sender_id")];
											  [itemChat setReceiverNameSurname:RetrieveObj(dict, @"sender_name")];
											  if (![_chatList containsObject:itemChat]) {
												  [_chatList addObject:itemChat];
											  }
										  }
									  }
									  [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
								  }];
	[task resume];
	
}

- (void)populateChatItemList{
	for (Lift* lp in sharedRoutesAsPassenger.lifts) {
		NSArray* stepArray = lp.steps;
		for (Steps *sp in stepArray) {
			if ([sp.travel_mode isEqualToString:TRANSPORT_CAR_POOLING]) {
				Driver* driver = [sp.driver objectAtIndex:0];
				ChatListItem *itemChat = [ChatListItem new];
				[itemChat setReceiverId:driver.userID];
				[itemChat setReceiverNameSurname:driver.user_name];
				[itemChat setReceiverAvatar:driver.user_image];
				[itemChat setRefLift:lp];
				if (itemChat.receiverAvatar == nil)				{
					itemChat.receiverAvatar = [UIImage imageNamed:@"account-circle-grey"];
				}
				[itemChat setReceiverType:DRIVER];
				if (![_chatList containsObject:itemChat]) {
					[_chatList addObject:itemChat];
				}
			}			
		}
	}
	for (Lift* ld in sharedRoutesAsDriver.lifts) {
		ChatListItem *itemChat = [ChatListItem new];
		[itemChat setReceiverId:ld.passenger_id];
		[itemChat setReceiverNameSurname:ld.passenger_name];
		[itemChat setReceiverAvatar:ld.passenger_picture];
		[itemChat setRefLift:ld];
		if (itemChat.receiverAvatar == nil)				{
			itemChat.receiverAvatar = [UIImage imageNamed:@"account-circle-grey"];
		}
		[itemChat setReceiverType:PASSENGER];
		if (![_chatList containsObject:itemChat]) {
			[_chatList addObject:itemChat];
		}
	}
	[self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	return self.chatList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ChatListCell reuseIdentifier]
														   forIndexPath:indexPath];
	
	ChatListItem *item = [_chatList objectAtIndex:indexPath.row];
	
	[cell setCellWithChatListItem:item index:indexPath.row];
	
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	ChatRoomVC *chatVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"ChatVC"];
	[chatVC setPassedCLI:[self.chatList objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:chatVC animated:YES];
	
}

@end
