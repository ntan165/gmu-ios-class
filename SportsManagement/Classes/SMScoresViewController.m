//
//  SMScoresViewController.m
//  SportsManagement
//
//  Created by Jason Harwig on 11/2/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import "SMScoresViewController.h"
#import "SMAllScoresViewController.h"
#import <YAJLIOS/YAJLIOS.h>
#import "SMLoginViewController.h"

#define CURRENT_SCORES_JSON @"http://dl.dropbox.com/u/11760590/game_results.json"
#define SCORES_JSON @"http://dl.dropbox.com/u/11760590/leagues/%@/seasons/%@/game_results.json"

@implementation SMScoresViewController

@synthesize nibLoadedCell;
@synthesize allButton;
@synthesize leagueId;
@synthesize seasonId;
@synthesize results;

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.navigationItem.title = @"Scores";
	
    //NETWORK_ON    
    responseData = [[NSMutableData alloc] init];
    self.results = [NSArray array];
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	[self.view addSubview:activityView];
	activityView.center = CGPointMake(160, 152);
	[activityView startAnimating];
	
	NSString *url;
	NSURLRequest *request;
	if ( (leagueId == nil) || (seasonId == nil) ) //Current scores
	{
		request = [NSURLRequest requestWithURL:[NSURL URLWithString:CURRENT_SCORES_JSON]];
		NSLog(@"Current scores url string = %@", url);
		[NSURLConnection connectionWithRequest:request delegate:self];
	}
	else //All scores - Scores within a particular season & league
	{
		url = [NSString stringWithFormat:SCORES_JSON,leagueId,seasonId];
		NSLog(@"All scores url string = %@", url);
		request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
		[NSURLConnection connectionWithRequest:request delegate:self];	
	}
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
	
	[activityView stopAnimating];
    self.results = [responseData yajl_JSON];
    NSLog(@"Scores result=%@", self.results);
    
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
    if (cell == nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"SMScoreTableCell" owner:self options:NULL];
		cell = nibLoadedCell;
    }   
	
    // Configure the cell...
	NSDictionary *data = [results objectAtIndex:indexPath.row];
	//[NSString stringWithFormat:@"Season %@",[data objectForKey:@"id"]];
	
	UILabel *sportLabel = (UILabel*) [cell viewWithTag:1];
	sportLabel.text = [data objectForKey:@"sport"];
	
	UILabel *dateLabel = (UILabel*) [cell viewWithTag:2];
	dateLabel.text = [data objectForKey:@"date"];
	
	UILabel *homeTeamLabel = (UILabel*) [cell viewWithTag:3];
	homeTeamLabel.text = [data objectForKey:@"home_name"];
	
	UILabel *awayTeamLabel = (UILabel*) [cell viewWithTag:4];
	awayTeamLabel.text = [data objectForKey:@"away_name"];
	
	UILabel *homeScoreLabel = (UILabel*) [cell viewWithTag:5];
	homeScoreLabel.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"home_score"]];
	
	UILabel *awayScoreLabel = (UILabel*) [cell viewWithTag:6];
	awayScoreLabel.text = [NSString stringWithFormat:@"%@",[data objectForKey:@"away_score"]];
	
    return cell;
}


- (IBAction) handleAllTapped
{
	SMAllScoresViewController *vc = [[SMAllScoresViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

