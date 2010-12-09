//
//  SMScoresViewController.h
//  SportsManagement
//
//  Created by Jason Harwig on 11/2/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMScoresViewController : UITableViewController 
{
	NSString *leagueId;
	NSString *seasonId;

	UITableViewCell *nibLoadedCell;
	UIBarButtonItem *allButton;

    NSMutableData *responseData;
    NSArray *results;
	UIActivityIndicatorView *activityView;
}

@property (nonatomic,retain) IBOutlet UITableViewCell *nibLoadedCell;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *allButton;
@property (nonatomic,retain) NSString *leagueId;
@property (nonatomic,retain) NSString *seasonId;
@property (nonatomic,retain) NSArray *results;

- (IBAction) handleAllTapped;

@end
