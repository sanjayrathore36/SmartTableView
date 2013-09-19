//
//  SmartMarkableViewController.h
//  SmartTableView
//
//  Created by Sanjay on 19/09/13.
//  Copyright (c) 2013 Times mobile ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SelectorAtrribute   title

@interface SmartMarkableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate, UISearchDisplayDelegate>
{
    IBOutlet UITableView* contactTableView;
}


//Public interface
/*
 @ itemsArray : list of items that will be show to table view
 */
-(void)setItemsForTableView:(NSArray*)itemsArray;

@end
