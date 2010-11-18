//
//  Game.h
//  SportsManagement
//
//  Created by Tan Nguyen on 11/11/10.
//  Copyright 2010 IT315. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SMGame : NSObject 
{
	NSString *date;
	NSString *home_name;
	NSString *away_name;
	NSString *home_score;
	NSString *away_score;
	NSString *sport;
}

@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *home_name;
@property (nonatomic,copy) NSString *away_name;
@property (nonatomic,copy) NSString *home_score;
@property (nonatomic,copy) NSString *away_score;
@property (nonatomic,copy) NSString *sport;

@end
