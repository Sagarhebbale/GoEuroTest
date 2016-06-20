//
//  TransportTableViewController.h
//  GoEuroTest
//
//  Created by master on 6/19/16.
//  Copyright © 2016 Neemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Datasource.h"

#define TransportVC_StoryboardID @"TransportVC"

@interface TransportTableViewController : UIViewController<UITableViewDelegate , UITableViewDataSource>
/**
 *  TableView property hooked upto the storyboard. This table view lists all the transport data
 */
@property(nonatomic , retain)IBOutlet UITableView *tableView;
/**
 *  Property holding the transport type. Transport type can be train, bus or flight
 */
@property(nonatomic)TransportType transportType;

/**
 *  Factory method for the creation of This view controller
 *
 *  @return UINavigationController with an instance of this view controller as its root view controller.
 */
+(UINavigationController *)createFromNib;
/**
 *  Button Handler on Press of sorting Button
 *
 *  @param sender UIBarButtonItem, SortButton on navigation bar
 */
-(IBAction)sortButtonPressed:(id)sender;

@end
