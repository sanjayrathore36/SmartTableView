//
//  ViewController.h
//  SmartTableView
//
//  Created by Sanjay on 17/09/13.
//  Copyright (c) 2013 Times mobile ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SelectorAtrribute   title

@interface SmartTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate, UISearchDisplayDelegate>
{
  IBOutlet UITableView* contactTableView;
}



//Public interface
/*
 @ itemsArray : list of items that will be show to table view
 @ selectorString: sorting attribute
 */
-(void)setItemsForTableView:(NSArray*)itemsArray;

@end
