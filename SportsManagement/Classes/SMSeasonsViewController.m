//
//  SMSeasonsViewController.m
//  SportsManagement
//
//  Created by Tan Nguyen on 12/2/10.
//  Copyright 2010 IT315. All rights reserved.
//

#import "SMSeasonsViewController.h"
#import <YAJLIOS/YAJLIOS.h>
#import "SMLoginViewController.h"
#import "SMScoresViewController.h"

//#define SEASONS_JSON @"http://nicsports.railsplayground.net/leagues/%@/seasons.json"

#define SEASONS_JSON @"http://dl.dropbox.com/u/11760590/leagues/%@/seasons.json"

@implementation SMSeasonsViewController
@synthesize results;
@synthesize leagueId;

#pragma mark -
#pragma mark Initialization

- (void)viewDidLoad
{
	self.navigationItem.title = @"Seasons";
    //NETWORK_ON    
    responseData = [[NSMutableData alloc] init];
    self.results = [NSArray array];
    
	NSString *url = [NSString stringWithFormat:SEASONS_JSON,self.leagueId];
	NSLog(@"Season url string = %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
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
    //NETWORK_OFF
	
    self.results = [responseData yajl_JSON];
    NSLog(@"result=%@", self.results);
    
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
    //NETWORK_OFF
    NSLog(@"Response failed. Reason: %@", error);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
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
	
    cell.textLabel.text = [NSString stringWithFormat:@"Season %@",[data objectForKey:@"id"]];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Start date: %@ - End date: %@",[data objectForKey:@"start_date"],[data objectForKey:@"end_date"]];
    
	return cell;}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSDictionary *temp = [results objectAtIndex:indexPath.row];
	NSLog(@"Passing leagueId = %@",self.leagueId);
	NSLog(@"Passing seasonId = %@",[temp objectForKey:@"id"]);
	
	SMScoresViewController *vc = [[SMScoresViewController alloc] init];
	vc.leagueId = self.leagueId;
	vc.seasonId = [temp objectForKey:@"id"];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

