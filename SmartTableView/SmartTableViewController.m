//
//  ViewController.m
//  SmartTableView
//
//  Created by Sanjay on 17/09/13.
//  Copyright (c) 2013 Times mobile ltd. All rights reserved.
//

#import "SmartTableViewController.h"

@interface SmartTableViewController()

- (NSMutableArray*)setTableViewObjects:(NSArray *)objectsArray;

@property (nonatomic, strong) NSMutableArray*  tableData;
@property (nonatomic, strong) NSMutableArray*  filteredListContent;
@property (nonatomic, strong) UILocalizedIndexedCollation* collation;

@end


@implementation SmartTableViewController
{
    //private members
}

@synthesize tableData;
@synthesize collation;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 * create indexes for the table view
 */

- (NSMutableArray*)setTableViewObjects:(NSArray *)objectsArray {
    

    //set the selector for sorting....
    SEL selector = @selector(SelectorAtrribute);
    
    //count the total number of sections
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];

    NSMutableArray *mutableSections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    for (int idx = 0; idx < sectionTitlesCount; idx++) {
        
        [mutableSections addObject:[[NSMutableArray alloc]init]];
    }
    
    for (id theCustomer in objectsArray) {
        
         NSInteger sectionNumber = [collation sectionForObject:theCustomer collationStringSelector:selector];
        [[mutableSections objectAtIndex:sectionNumber] addObject:theCustomer];
    }
    
    for (int idx = 0; idx < sectionTitlesCount; idx++) {
        
        NSArray *objectsForSection = [mutableSections objectAtIndex:idx];
        [mutableSections replaceObjectAtIndex:idx withObject:[collation sortedArrayFromArray:objectsForSection collationStringSelector:selector]];
    }
    
    return mutableSections;
}


#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    
    return [self.collation.sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    
    NSString *theLetter  = [self.collation.sectionTitles objectAtIndex:section];
    
    if (![theLetter isEqualToString:@"#"]) {
        NSString *titleString = [NSString stringWithFormat:@"Names for the letter %@", theLetter];
        return titleString;
    }
    
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    
    return [self.collation sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 0;
    } else {
        if (title == UITableViewIndexSearch) {
            [tableView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
            return -1;
        } else {
            return [self.collation sectionForSectionIndexTitleAtIndex:index];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return [self.filteredListContent count];
    }
    
    NSArray *innerArray = [self.tableData objectAtIndex:section];
    return [innerArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    id theName = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        theName = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        // Get the inner array for this section
        NSArray *innerArray = [self.tableData objectAtIndex:indexPath.section];
        // Get the name from the inner array
        theName = [innerArray objectAtIndex:indexPath.row];
        
    }

    cell.textLabel.text = [theName title];
    
    return cell;
    
}



#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
    for (NSArray *section in self.tableData) {
        
        for (id object in section)
        {
            if (1) {  //[scope isEqualToString:@"All"] || [product.title isEqualToString:scope]) {
            
                NSComparisonResult result = [[object title] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
                if (result == NSOrderedSame)
                {
                    [self.filteredListContent addObject:object];
                }
            }
        }
    }
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id  objectItem = nil;
    
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        objectItem = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        NSArray *innerArray = [self.tableData objectAtIndex:indexPath.section];
        objectItem  = [innerArray objectAtIndex:indexPath.row];
      
        NSLog(@"Selected item is = %@", [objectItem title]);
        
    }

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // create a filtered list that will contain products for the search results table.
	self.filteredListContent = [NSMutableArray arrayWithCapacity:1];

}

-(void)setItemsForTableView:(NSArray*)itemsArray
{
    self.collation = [UILocalizedIndexedCollation currentCollation];
    self.tableData = [self setTableViewObjects:itemsArray];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    /* Save the state of the search UI so that it can be restored if the view is re-created.
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    */
	self.filteredListContent = nil;
    self.tableData = nil;
    self.collation = nil;
    self.tableData = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [contactTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
