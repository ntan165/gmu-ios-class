//
//  SMAllScoresViewController.h
//  SportsManagement
//
//  Created by Tan Nguyen on 12/1/10.
//  Copyright 2010 IT315. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SMAllScoresViewController : UITableViewController 
{
    NSMutableData *responseData;
    NSArray *results;
	UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) NSArray *results;



@end
