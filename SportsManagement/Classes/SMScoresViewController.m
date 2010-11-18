//
//  SMScoresViewController.m
//  SportsManagement
//
//  Created by Jason Harwig on 11/2/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import "SMScoresViewController.h"

@implementation SMScoresViewController

@synthesize nibLoadedCell;
@synthesize sortControl;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad 
{
    [super viewDidLoad];
	gamesArray = [[NSMutableArray alloc] init];
	
	//Load data - fake data for now , get data from JSON later
	
	SMGame *aGame = [[SMGame alloc] init];
	aGame.date = @"15-March-2010 08:00:00 PM";
	aGame.home_name = @"GMU";
	aGame.away_name = @"VCU";
	aGame.home_score = @"96";
	aGame.away_score = @"101";
	aGame.sport = @"Basketball";
	[gamesArray addObject: aGame];
	[aGame release];
	
	SMGame *aGame1 = [[SMGame alloc] init];
	aGame1.date = @"01-April-2011 07:00:00 PM";
	aGame1.home_name = @"UVA";
	aGame1.away_name = @"GMU";
	aGame1.home_score = @"60";
	aGame1.away_score = @"75";
	aGame1.sport = @"Basketball";
	[gamesArray addObject: aGame1];
	[aGame1 release];
	
	SMGame *aGame2 = [[SMGame alloc] init];
	aGame2.date = @"20-August-2011 04:00:00 PM";
	aGame2.home_name = @"GMU";
	aGame2.away_name = @"DC United";
	aGame2.home_score = @"0";
	aGame2.away_score = @"10";
	aGame2.sport = @"Soccer";
	[gamesArray addObject: aGame2];
	[aGame2 release];
	
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [gamesArray count];
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
	
	//switch(sortControl.selectedSegmentIndex)
	//{
	//	case 0: // This is the current season
			
			SMGame *aGame = [gamesArray objectAtIndex:indexPath.row];
	
			UILabel *sportLabel = (UILabel*) [cell viewWithTag:1];
			sportLabel.text = aGame.sport;
	
			UILabel *dateLabel = (UILabel*) [cell viewWithTag:2];
			dateLabel.text = aGame.date;
	
			UILabel *homeTeamLabel = (UILabel*) [cell viewWithTag:3];
			homeTeamLabel.text = aGame.home_name;
	
			UILabel *awayTeamLabel = (UILabel*) [cell viewWithTag:4];
			awayTeamLabel.text = aGame.away_name;
	
			UILabel *homeScoreLabel = (UILabel*) [cell viewWithTag:5];
			homeScoreLabel.text = aGame.home_score;
	
			UILabel *awayScoreLabel = (UILabel*) [cell viewWithTag:6];
			awayScoreLabel.text = aGame.away_score;
			
		//case 1: // This is all seasons, display a list of leagues
			
	//}
	
    return cell;
}


- (IBAction) handleSortChanged
{
	NSLog(@"index is %d", sortControl.selectedSegmentIndex);
	[self.tableView reloadData];
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

