//
//  SMScoresViewController.h
//  SportsManagement
//
//  Created by Jason Harwig on 11/2/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMGame.h"

@interface SMScoresViewController : UITableViewController 
{
	NSMutableArray *gamesArray;
	UITableViewCell *nibLoadedCell;
	//UISegmentedControl *sortControl; //later use
}

@property (nonatomic,retain) IBOutlet UITableViewCell *nibLoadedCell;
//@property (nonatomic,retain) IBOutlet UISegmentedControl *sortControl;

@end
