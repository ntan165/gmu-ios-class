//
//  SMAllScoresViewController.m
//  SportsManagement
//
//  Created by Tan Nguyen on 12/1/10.
//  Copyright 2010 IT315. All rights reserved.
//

#import "SMAllScoresViewController.h"
#import <YAJLIOS/YAJLIOS.h>
#import "SMSeasonsViewController.h"
#import "SMLoginViewController.h"

#define LEAGUES_JSON @"http://nicsports.railsplayground.net/leagues.json"

@implementation SMAllScoresViewController
@synthesize results;

- (void)viewDidLoad
{
	self.navigationItem.title = @"Leagues";

    responseData = [[NSMutableData alloc] init];
    self.results = [NSArray array];
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.view addSubview:activityView];
	activityView.center = CGPointMake(160, 152);
	[activityView startAnimating];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:LEAGUES_JSON]];
	NSLog(@"Leagues url string = %@", LEAGUES_JSON);
	[NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	SMLoginViewController *vc = [[SMLoginViewController alloc] initWithChallenge:challenge];
	[self presentModalViewController:vc animated:YES];
	[vc release];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{	
	[activityView stopAnimating];
    self.results = [responseData yajl_JSON];
    NSLog(@"Leagues result=%@", self.results);
    
	// In case an error is received, display the error using an alertview.
    if (self.results == nil || [self.results isKindOfClass:[NSDictionary class]]) 
	{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[(NSDictionary *)self.results objectForKey:@"error"] delegate:self
                                              cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
        return;
    }
	
    [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Response failed. Reason: %@", error);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
     return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [results count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSDictionary *data = [results objectAtIndex:indexPath.row];
	
    cell.textLabel.text = [data objectForKey:@"name"];
    
	//cell.detailTextLabel.text = [data valueForKeyPath:@"sport"];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Sport: %@ - Gender: %@",[data valueForKeyPath:@"sport"],[data valueForKeyPath:@"gender_type"]];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
   	SMSeasonsViewController *vc = [[SMSeasonsViewController alloc] init];
	NSDictionary *temp = [results objectAtIndex:indexPath.row];
    vc.leagueId = [temp objectForKey:@"id"];
	vc.leagueName = [temp objectForKey:@"name"];
	
	NSLog(@"Passing leagueId = %@",vc.leagueId);
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
}


- (void)dealloc 
{
    [super dealloc];
}


@end

