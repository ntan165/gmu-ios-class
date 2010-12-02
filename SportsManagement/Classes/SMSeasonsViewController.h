//
//  SMSeasonsViewController.h
//  SportsManagement
//
//  Created by Tan Nguyen on 12/2/10.
//  Copyright 2010 IT315. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SMSeasonsViewController : UITableViewController 
{	
	NSString *leagueId;
    NSMutableData *responseData;
    NSArray *results;
}

@property (nonatomic, retain) NSArray *results;
@property (nonatomic, retain) NSString *leagueId;
@end
